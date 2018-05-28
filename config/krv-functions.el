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

(global-set-key (kbd "C-c s") 'krv/squeeze)

(provide 'krv-functions)
