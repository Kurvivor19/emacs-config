;; preload packages that are likely to be used all the time

;; remember file places between sessions
(require 'saveplace)
(setq-default save-place t)

;; add variety of commands to open files
(require 'ffap)

;; provide unique buffer names for identically named files
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; translate escape sequences into color changes
(require 'ansi-color)

;; enable list of recent files in the menu
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key (kbd "C-x M-r") 'recentf-open-files)

;; enable opening of remote buffers
(require 'tramp)

;; provide easier way of moving buffers
(require 'buffer-move)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

(provide 'packages-preload)









