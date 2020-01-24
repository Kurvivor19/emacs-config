;; setup how emacs looks

;; disable splash screen
(setq inhibit-splash-screen t)

;; disable scrollbars and toolbar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(global-set-key [C-f10] 'toggle-menu-bar-mode-from-frame)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; load color scheme
(load-theme 'wombat nil nil)

;; ensure time is displayed
(display-time-mode 1)

(provide 'display-config)


