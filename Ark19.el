;;; For my 'home system' configuration
(pdf-tools-install)
; (if (not (getenv "WORKON_HOME"))
;     (setenv "WORKON_HOME" "/home/survivor/.virtualenvs"))
; 
; ;; Standard Jedi.el setting
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
; auto compete setup

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(ac-config-default)

(setenv "EDITOR" "emacsclient")

(setq load-path (append load-path '("/usr/local/share/emacs/site-lisp/emms")))
(require 'emms-setup)
;(require 'helm-emms)
(emms-all)
(emms-default-players)
(require 'emms-info-mediainfo)
(setq emms-info-functions '(emms-info-mediainfo))

;; Personal short keybindings
(define-prefix-command 'user-map-f6)
(global-set-key (kbd "<f6>") 'user-map-f6)
;; h for helm-emms
(define-key user-map-f6 (kbd "h") 'helm-emms)
;; e for emms
(define-key user-map-f6 (kbd "e") 'emms)
;; b for browser
(define-key user-map-f6 (kbd "b") 'emms-smart-browse)
;; r for random
(define-key user-map-f6 (kbd "r") 'emms-random)
;; s for stop
(define-key user-map-f6 (kbd "s") 'emms-stop)
;; n for next
(define-key user-map-f6 (kbd "n") 'emms-next)
;; p for previous
(define-key user-map-f6 (kbd "p") 'emms-previous)
;; P for Pause
(define-key user-map-f6 (kbd "P") 'emms-pause)
;; d for display
(define-key user-map-f6 (kbd "d") 'emms-show)
;; u for shUffle
(define-key user-map-f6 (kbd "u") 'emms-shuffle)
;; l fpr playList
(define-key user-map-f6 (kbd "l") 'emms-add-playlist)

;; set multimedia keys
(global-set-key (kbd "<XF86AudioNext>") 'emms-seek-forward)
(global-set-key (kbd "<XF86AudioPrev>") 'emms-seek-backward)
(global-set-key (kbd "<XF86AudioStop>") 'emms-stop)
(global-set-key (kbd "<XF86AudioPlay>") 'emms-pause)

(setenv "GTAGSLIBPATH" "/usr/include")

(require 'c-edit)

;; parifinder-mode
;(add-to-list 'load-path "~/Development/parinfer-mode")
;(require 'parinfer-mode)
;(add-hook 'emacs-lisp-mode-hook 'parinfer-mode)

(set-language-environment 'Russian)
(set-file-name-coding-system 'utf-8)







;; dirty hack to access fornex server
(require 'tramp)
(add-to-list 'tramp-methods
             '("fornex"
               (tramp-login-program "plink")
               (tramp-login-args
                (("-l" "root")
                 ("-P" "22")
                 ("-i" "~/.ssh/id_rsa.ppk")
                 ("-ssh")
                 ("-t")
                 ;("31.172.64.10")
                 ("%h")
                 ("\"")
                 ("env 'TERM=dumb' 'PROMPT_COMMAND=' 'PS1=#$ '")
                 ("%l")
                 ("\"")))
               (tramp-remote-shell "/bin/sh")
               (tramp-remote-shell-login
                ("-l"))
               (tramp-remote-shell-args
                ("-c"))))
(setenv "fornex_builder" "/fornex:31.172.64.10|sudo:builder@31.172.64.10:")
(setenv "fornex_root" "/fornex:31.172.64.10:")
