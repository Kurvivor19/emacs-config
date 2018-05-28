;; setup CC-mode
(require 'cc-mode)
(require 'ggtags)
(require 'semantic)
(require 'company)

(delete 'company-clang company-backends)

(setq c-default-style
      (cons '(c-mode . "bsd") c-default-style))


(add-hook 'c-mode-hook
          (lambda ()
            (setq c-basic-offset 4)
            (setq coding-system-for-read 'utf-8-unix)
            (setq coding-system-for-write 'utf-8-unix)))

(add-hook 'c-mode-common-hook
          'ggtags-mode)
(add-hook 'c-mode-common-hook
          'company-mode)
(add-hook 'c-mode-common-hook
          'yas/minor-mode)
(add-hook 'c-mode-common-hook
          'hs-minor-mode)
(add-hook 'c-mode-common-hook
          'semantic-mode)

(define-key c-mode-map (kbd "<C-tab>") 'company-complete)
(define-key c++-mode-map (kbd "<C-tab>") 'company-complete)

(custom-set-variables
 '(helm-gtags-prefix-key (kbd "C-c t"))
 '(helm-gtags-suggested-key-mapping t)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-auto-update t)
 '(helm-gtags-use-input-at-cursor t)
 '(helm-gtags-pulse-at-cursor t))

(require 'helm-gtags)

(add-hook 'c-mode-common-hook
          'helm-gtags-mode)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-stickyfunc-mode 1)

(provide 'c-edit)
