;;; krv-funcitions.el

;; Copyright © 2017 Ivan Truskov
;; Author Ivan Truskov
;; Some commands i have composed for personal convenience
;;; Code:
;;;###autoload

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

(defvar cycle-symbols-alist nil
  "list of characters used for symbol cycling")

(defgroup cycle-symbols nil
  "Group for cycling symbols")

(defcustom cycle-symbols-lists-default
  (list (list ?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8 ?9 ?0) (list ?+ ?-) (list ?> ?< ?=))
  "Default lists for symbol cycling"
  :type 'sexp
  :set (lambda (s val)
         (set-default s val)
         (setq cycle-symbols-alist (mapcan #'krv/unwrap-list-to-alist val))))

(defun krv/cycle-symbols-command ()
  "Cycle previous non-whitespace if there is a known substitution"
  (interactive)
  (let* ((check-pair (krv/last-char-check))
         (pos (car check-pair))
         (char (cdr check-pair))
         (rchar (assoc char cycle-symbols-alist)))
    (when (and check-pair rchar)
      (forward-char pos)
      (delete-backward-char 1)
      (insert-char (cdr rchar))
      (backward-char pos))))

(global-set-key (kbd "C-<backspace>") 'krv/cycle-symbols-command)
(global-set-key (kbd "C-c s") 'krv/squeeze)

(provide 'krv-functions)
