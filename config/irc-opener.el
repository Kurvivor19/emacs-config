;; functions for opening orc links

(require 'erc)

(defun krv/validate-irc-url (url-string)
  "Validate given string as an IRC URL.

 Return parsed version of the string or nil.
 'Damaged' URLs, for example c:/emacs/bin/irc:/server/channel
 are fixed and then validated"
  
  (if (string-match
       "\\(?:^\\|[^a-zA-Z]\\)\\(irc:/.*\\)" url-string)
      ;; aligned-url-string is guaranteed to start with "irc:/"
      (let ((aligned-url-string (match-string 1 url-string)))
        (unless (equal ?/ (aref aligned-url-string 5))
          ;; irc:/[^/] -> irc://
          (setq aligned-url-string (concat "irc://" (substring aligned-url-string 5))))
        ; (print aligned-url-string)
        (let ((url-struct (url-generic-parse-url (url-unhex-string aligned-url-string t)))
              (bad-character-list (list
                                   ?\x20	; SPACE
                                   ?\x7		; BELL
                                   ?\x0		; NUL
                                   ?\xD		; CR
                                   ?\xA		; LF
                                   )))
          (when (equal "irc" (url-type url-struct))
            (let ((channel-name (or (url-target url-struct) (url-filename url-struct))))
              (and
               (> (length (url-host url-struct)) 0)
               channel-name
               ;; url-filename part begins with '/'
               (> (length channel-name) 0)
               (cl-every (lambda (char) (not (member char bad-character-list)))
                       channel-name)
             ;; parsed url structure is returned
               url-struct)))))))

(defun krv/make-channel-opener (irc-channel-name)
  "Return function that will open a channel

 Function is a hook that removes itself from erc-after-connect
 after own execution.

 NOTE: first hook from erc-after-connect is actually removed, so
 this hook must not be appended"
  ;; possible alternate function (erc-join-channel irc-url-name-part)
  `(lambda (server nick)
     ;; (message "Hook function was run!")
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
        (let* ((channel-name (or (url-target parsed-url-struct) (url-filename parsed-url-struct)))
               (channel-name-parts (split-string channel-name "," t))
               (irc-url-name-part (if (equal (aref (car channel-name-parts)) ?/)
                                      (substring (car channel-name-parts) 1 nil)
                                    (car channel-name-parts)))
               (irc-url-keyword-part (cadr channel-name-parts))
               (irc-url-host-part (url-host parsed-url-struct))
               (irc-url-port-part (url-port parsed-url-struct)))
          (cond 
           ((or (not irc-url-keyword-part) (equal irc-url-keyword-part "needkey"))
            ;; check first symbol
            (unless (member (aref irc-url-name-part 0)
                            '(?# ?& ?+))
              (setq irc-url-name-part (concat "#" irc-url-name-part)))
            (message (format "URL is for irc channel %s on server %s"
                           irc-url-name-part irc-url-host-part))
                                        ; open erc channel!
            (add-hook 'erc-after-connect (krv/make-channel-opener irc-url-name-part))
            (erc :server irc-url-host-part :port irc-url-port-part))
           ((equal irc-url-keyword-part "isnick")
            (message "URL is for irc nickname. These urls are not supported"))
           (t (message "Unable to determine type of IRC URL"))))
      (message "irc url not validated"))))

(defun krv/irc-url-server-open (original-function &rest args)
  "Intercept calls to server-visit-files"
  (message "Advice on server-visit-files executed")
  (let* ((files (caar args))
         (flag (catch 'irc-protocol
                (dolist (file files)
                  (if (krv/validate-irc-url file)
                      (throw 'irc-protocol file))))))
    (if flag
        (progn
         (message "Attempting to open irc channel")
         (krv/open-irc-url flag))
      (message "Executing default server-visit-files")
      (apply original-function args))))

(advice-add 'server-visit-files :around #'krv/irc-url-server-open)

(provide 'irc-opener)
