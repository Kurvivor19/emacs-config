;; setup org-mode

;; ensure we do have org mode
(require 'org)

;; probably a duplicate, anyway
;; ensure org files are opened in org mode
(add-to-list 'auto-mode-alist '("\\.org\\'". org-mode))

;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cc" 'org-capture)

;; todo keywords
(setq org-todo-keywords
      (quote ((sequence "LATER(l)" "TODO(t!)" "CHECK(k!)" "|" "DONE(d)")
              (sequence "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))

;; ensure TODOs respect hierarchy
(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies nil)
(setq org-log-done 'time)

;; capture setup
;; org-directory is supposed to be customized
(setq org-default-notes-file (concat org-directory "/notes.org"))

;; capture templates
(setq org-capture-templates
 '(("t" "Todo" entry (file+headline org-default-notes-file "Tasks")
        "* TODO %?\n  %t\n  %a\n" :kill-buffer)
   ("n" "Note" entry (file+headline org-default-notes-file "Notes")
        "* %? :NOTE:\n  At %u from %a\n" :kill-buffer)
   ("r" "Kill-ring note" entry (file+headline org-default-notes-file "Notes")
        "* %? :NOTE:\n  %c\n  %u (from %a)\n" :kill-buffer)
   ("b" "Clipboard note" entry (file+headline org-default-notes-file "Notes")
        "* %? :NOTE:\n  %c\n  %u\n" :kill-buffer)
   ("k" "Quick note (kill ring)" entry (file+headline org-default-notes-file "Notes")
        "* %c :NOTE:\n  %u (from %a)\n" :kill-buffer :immediate-finish)
   ("w" "Quick note (clipboard)" entry (file+headline org-default-notes-file "Notes")
        "* %x :NOTE:\n  %u\n" :kill-buffer :immediate-finish)))

;; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((org-agenda-files . (:maxlevel . 3)))))

;; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

;; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

;; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

;; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)

;; set agenda view to restore windows on exit
(setq org-agenda-restore-windows-after-quit t)
(setq org-agenda-window-setup 'current-window)
(setq org-agenda-include-diary t)

;; custom agenda view(s)
(setq org-agenda-custom-commands
      '(("n" "Agenda and all TODO's"
         ((agenda "")
          (alltodo "")))
        ("d" "Undated tasks" alltodo ""
         ((org-agenda-todo-ignore-with-date t)))))

(require 'cl)
(defun krv/toggle-tag (tag)
  "Set or remove TAG for current headline
TAG if removed, if present among tags or added last if it is not"
  ;; do not bother with tags table here
  (interactive  "sTag to switch: ")
  (save-excursion
    (save-match-data
      ;; this moves back to heading
      (org-back-to-heading)
      (let ((current-tags (org-get-tags-string)))
        (if (string-match tag current-tags)
            ;; remove tag that was found
            (org-set-tags-to
             (cl-remove tag (split-string current-tags ":" t "[[:blank:]]")
                        :test 'string-match))
          (org-set-tags-to (concat current-tags ":" tag)))))))

(defun krv/org-toggle-focus ()
  "Toggle :FOCUS: tag on current org heading"
  (interactive)
  (krv/toggle-tag "FOCUS"))

(add-hook 'org-mode-hook (lambda()
                           (define-key
                             org-mode-map (kbd "C-c f")
                             'krv/org-toggle-focus)))


;; setup org-journal
(setq org-journal-dir (concat org-directory "/journal/"))
(require 'org-journal)
;; disable C-c C-j for new journal entry
;; accidentally creating 
(global-set-key (kbd "C-c C-j") 'idomenu)

(provide 'org-local)
