;-*-coding:utf-8-*-
;;; preload packages that are likely to be used all the time

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
;; activte windmove for simpler window movement
(require 'windmove)
(windmove-default-keybindings)

;; enable quick yes
(require 'quick-yes)

;; sceleton-pair annoys me
;; so, i will use electrics
(setq skeleton-pair nil)
(require 'autopair)
(autopair-global-mode)

;; ensure ahg is loaded
;; (eval-after-load "vc-hg"
;;   '(require 'ahg))

;; (add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))

;; change gnus configuration file location to keep it inside repository dir
(setq gnus-init-file (concat dotfiles-dir ".gnus.el"))

;; set command for ispell-buffer
(global-set-key (kbd "C-x M-$") 'ispell-buffer)
;; allow company-jedi
(require 'company)
(require 'company-jedi)
(add-to-list 'company-backends 'company-jedi)

(require 'idomenu)

;; setup CC-mode
(require 'cc-mode)
(setq c-default-style
      (cons '(c-mode . "bsd") c-default-style))
(add-hook 'c-mode-hook
          (lambda ()
            (setq c-basic-offset 4)
            (setq coding-system-for-read 'utf-8-unix)
            (setq coding-system-for-write 'utf-8-unix)))

;; from http://quantumtheory.physik.unibas.ch/people/shalaev/linux/_emacs.html
;; setup calendar
(setq calendar-week-start-day 1)  ; start week from monday
(setq european-calendar-style 't)  ; dates in dd/mm fromat
;; set up holidays
; (setq general-holidays nil)
(setq hebrew-holidays nil)
(setq islamic-holidays nil)
(setq holiday-christian-holidays nil)
(setq holiday-bahai-holidays nil)
(setq holiday-oriental-holidays nil)

(setq other-holidays
      '((holiday-fixed 5 01 "День международной солидарности трудащихся")
        (holiday-fixed 2 23 "День Защитника Отечества")
        (holiday-fixed 3 8 "Международный женский день")
        (holiday-fixed 11 7 "Годовщина Октябрьской Социалистической революции")
        (holiday-fixed 4 12 "День космонавтики")
        (holiday-fixed 5 09 "День Победы в Великой Отечественной войне")

        (holiday-julian 3 25 "Благовещение Пресвятой Богородицы")
        (holiday-julian 6 29 "День святых первоверховных апостолов Петра и Павла")
        (holiday-julian 8 6 "Преображение Господне")

        (holiday-float 10 0 1 "День учителя")))

(add-hook 'calendar-today-visible-hook 'calendar-mark-today)
(add-hook 'calendar-initial-window-hook 'calendar-mark-holidays)

;; setup diary
(require 'org)
(setq diary-file (concat org-directory "/anniversaries.txt"))

(provide 'packages-preload)
