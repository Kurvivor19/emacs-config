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

(setq load-path (append load-path '("/usr/local/share/emacs/site-lisp/emms")))
(require 'emms-setup)
(emms-all)
(emms-default-players)
(require 'emms-info-libtag)
(setq emms-info-functions '(emms-info-libtag))

;; Personal short keybindings
(define-prefix-command 'user-map-f6)
(global-set-key (kbd "<f6>") 'user-map-f6)
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

;; set multimedia keys
(global-set-key (kbd "<XF86AudioNext>") 'emms-seek-forward)
(global-set-key (kbd "<XF86AudioPrev>") 'emms-seek-backward)
(global-set-key (kbd "<XF86AudioStop>") 'emms-stop)
(global-set-key (kbd "<XF86AudioPlay>") 'emms-pause)
