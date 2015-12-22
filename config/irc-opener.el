;; functions for opening orc links

(require 'erc)

(defun krv/validate-irc-url (url-string)
  "Validate given string as an IRC URL.\n
 Return parsed version of the string or nil"
  (let ((url-struct (url-generic-parse-url (url-unhex-string url-string t)))
        (bad-character-list (list
                             ?\x20	; SPACE
                             ?\x7	; BELL
                             ?\x0	; NUL
                             ?\xD	; CR
                             ?\xA	; LF
                             )))
    (when (equal "irc" (url-type url-struct))
      (and
       (> (length (url-host url-struct)) 0)
       ;; url-filename part begins with '/'
       (> (length (url-filename url-struct)) 1)
       (cl-every (lambda (char) (not (member char bad-character-list)))
                 (url-filename url-struct))
       ;; parsed url structure is returned
       url-struct))))

(defun krv/make-channel-opener (irc-channel-name)
  "Return function that will open a channel
 Function is a hook that removes itself from erc-after-connect
 after own execution.
 NOTE: first hook from erc-after-connect is actually removed, so
 this hook must not be appended"
  ;; possible alternate function (erc-join-channel irc-url-name-part)
  `(lambda (server nick)
     ;; (print "Hook function was run!")
     (erc-server-send (concat "join " ,irc-channel-name))
     (remove-hook 'erc-after-connect (car erc-after-connect))))

(defun krv/open-irc-url (url-string)
  "Open IRC channel that is described by a given URL.
 As per specification [1], if the first symbol isn't encoded
 representation of '#', '!' or '&', default value of '#' is
 substituted.
 On successful IRC URL validation, erc is opened for speci-
 fied channel of the specified server.
 [1]: http://www.w3.org/Addressing/draft-mirashi-url-irc-01"
  (let ((parsed-url-struct (krv/validate-irc-url url-string)))
    (if parsed-url-struct
        (let* ((filename-string-parts (split-string (url-filename parsed-url-struct) "," t))
               (irc-url-name-part (substring (car filename-string-parts) 1 nil))
               (irc-url-keyword-part (cadr filename-string-parts))
               (irc-url-host-part (url-host parsed-url-struct))
               (irc-url-port-part (url-port parsed-url-struct)))
          (cond 
           ((or (not irc-url-keyword-part) (equal irc-url-keyword-part "needkey"))
            ;; check first symbol
            (unless (member (aref irc-url-name-part 0)
                            '(?# ?& ?+))
              (setq irc-url-name-part (concat "#" irc-url-name-part)))
            (print (format "URL is for irc channel %s on server %s"
                           irc-url-name-part irc-url-host-part))
                                        ; open erc channel!
            (add-hook 'erc-after-connect (krv/make-channel-opener irc-url-name-part))
            (erc :server irc-url-host-part :port irc-url-port-part))
           ((equal irc-url-keyword-part "isnick")
            (print "URL is for irc nickname. These urls are not supported"))
           (t (print "Unable to determine type of IRC URL"))))
      (print "not validated"))))

(provide 'irc-opener)
