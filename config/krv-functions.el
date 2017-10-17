;;; krv-funcitions.el

;; Copyright © 2017 Ivan Truskov
;; Author Ivan Truskov
;; Some commands i have composed for personal convenience
;;; Code:
;;;###autoload

(defun krv/punto (p m)
  "With region, re-type string from that region after toggling input method.
Otherwise, toggle input method"
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 nil))
  (if (use-region-p)
      (let* ((region-string (buffer-substring p m))
             (old-input-method current-input-method)
             (input-keys
              (if (not old-input-method)
                  ;; if there is no current input method, just take character
                  (listify-key-sequence region-string)
                ;; we have imput method, try to translate characters back
                (cl-mapcan
                 (lambda (ch)
                   (let ((quail-list (quail-find-key ch)))
                     (if (equal quail-list t)
                         (list ch)
                       (cl-mapcan (lambda (str) (listify-key-sequence str))
                                  quail-list))))
                 region-string))))
        (delete-region p m)
        (toggle-input-method)
        (setq unread-command-events (nconc unread-command-events input-keys)))
    (call-interactively 'toggle-input-method)))
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
