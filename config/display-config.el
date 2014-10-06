;; setup how emacs looks

;; disable splash screen
(setq inhibit-splash-screen t)

;; disable scrollbars and toolbar
;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; load color scheme
(load-theme 'wombat nil nil)

(provide 'display-config)

