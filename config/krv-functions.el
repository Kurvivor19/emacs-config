;;; krv-funcitions.el
;; Copyright © 2017 Ivan Truskov
;; Author Ivan Truskov
;; Some commands i have composed for personal convenience
;;; Code:
;;;###autoload

(require 'cl)

(defun krv/punto (&optional beg end)
  "With region, re-type string from that region after toggling input method.
Otherwise, toggle input method"
  (interactive (and (use-region-p)
                    (list (region-beginning) (region-end))))
  (let* ((events (and beg end
                      (cl-mapcan
                       (lambda (ch)
                         (let ((quail-list (quail-find-key ch)))
                           (if (booleanp quail-list)
                               (list ch)
                             (cl-mapcan 'listify-key-sequence quail-list))))
                       (delete-and-extract-region beg end)))))
        (toggle-input-method)
        (setq unread-command-events (nconc events unread-command-events))))
(global-set-key (kbd "C-\\") 'krv/punto)

;; this is from technomancy's code
(defun select-current-line ()
  "Select the current line"
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position)))
(global-set-key (kbd "C-S-l") 'select-current-line)

(defun krv/squeeze (p m)
  "Convert region to CamelCase literal"
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (user-error "Region is not active")))
  (when (use-region-p)
    (let* ((region-string (buffer-substring p m))
           (changed-string (save-match-data
                             (apply 'concat (split-string (capitalize region-string)
                                                          "[^[:word:]0-9]+"
                                                          t)))))
      (delete-region p m)
      (insert-before-markers changed-string))))

(defun krv/last-char-check (&optional pos)
  "Find previous non-whitespace character in current string.

Return in form of (position . character) cons nor nil"
  (save-excursion
    (let ((cur-pos (or (and pos (goto-char pos))
                       (point))))
      (loop for prev-char = (preceding-char) then (preceding-char)
            for back-pos = 0 then (1- back-pos)
            when (bolp) return nil
            ; known whitespaces listed
            unless (member prev-char (list ?\ ?\xA0 ?\t)) return (cons back-pos prev-char)
            else do (backward-char)))))

(defun krv/unwrap-list-to-alist (list-form)
  "Helper function for setting character substitutions"
  (loop with first = (car list-form)
        for (s1 s2 . nil) on list-form
        if s2 collect (cons s1 s2)
        else collect (cons s1 first)))

(defvar krv/cycle-chars-alist nil
  "list of characters used for symbol cycling")

(defgroup krv/cycle-characters nil
  "Group for cycling symbols")

;; (defcustom krv/cycle-characters-lists-default
;;   nil ; (lambda () "" (list '(?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8 ?9 ?0) '(?+ ?-) '(?> ?< ?=)))
  
;;   "Default lists for symbol cycling"
;;   :type 'sexp
;;   :set (lambda (s val)
;;          (set-default s val)
;;          (setq krv/cycle-chars-alist (mapcan #'krv/unwrap-list-to-alist val))))

(defconst cyrillic-symbol-lists
  (list
   ;; e-like letters
   (list ?\N{CYRILLIC SMALL LETTER IE}
         ?\N{CYRILLIC SMALL LETTER YAT}
         ?\N{CYRILLIC SMALL LETTER IO}
         ?\N{CYRILLIC CAPITAL LETTER IE}
         ?\N{CYRILLIC CAPITAL LETTER YAT}
         ?\N{CYRILLIC CAPITAL LETTER IO})
   ;; i-like letters
   (list ?и
         ?\N{CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I}
         ?\N{CYRILLIC SMALL LETTER SHORT I}
         ?\N{CYRILLIC SMALL LETTER IZHITSA}
         ?\N{CYRILLIC CAPITAL LETTER I}
         ?\N{CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I}
         ?\N{CYRILLIC CAPITAL LETTER SHORT I}
         ?\N{CYRILLIC CAPITAL LETTER IZHITSA})
   ;; f-like letters
   (list ?\N{CYRILLIC SMALL LETTER EF}
         ?\N{CYRILLIC SMALL LETTER FITA}
         ?\N{CYRILLIC CAPITAL LETTER EF}
         ?\N{CYRILLIC CAPITAL LETTER FITA})))

;; (list ?я ?\N{CYRILLIC SMALL LETTER LITTLE YUS}
;;               ?\N{CYRILLIC SMALL LETTER BIG YUS}
;;               ?Я ?\N{CYRILLIC CAPITAL LETTER LITTLE YUS}
;;               ?\N{CYRILLIC CAPITAL LETTER BIG YUS})

;; add cyrillic substitutions
(setq krv/cycle-chars-alist
      (mapcan #'krv/unwrap-list-to-alist cyrillic-symbol-lists))
;; (custom-set-variables
;;  `(krv/cycle-characters-lists-default ,(append krv/cycle-characters-lists-default
;;                                        cyrillic-symbol-lists)))

(defun krv/cycle-characters-command ()
  "Cycle previous non-whitespace if there is a known substitution"
  (interactive)
  (let* ((check-pair (krv/last-char-check))
         (pos (car check-pair))
         (char (cdr check-pair))
         (rchar (assoc char krv/cycle-chars-alist)))
    (when (and check-pair rchar)
      (forward-char pos)
      (delete-backward-char 1)
      (insert-char (cdr rchar))
      (backward-char pos))))

(global-set-key (kbd "C-<backspace>") 'krv/cycle-characters-command)
(global-set-key (kbd "C-c s") 'krv/squeeze)

(provide 'krv-functions)
