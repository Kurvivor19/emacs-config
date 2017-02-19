
;; make spaces visible
(add-hook 'python-mode-hook
	  (lambda ()
            (whitespace-mode)))


;; putty paths
(setenv "PATH" (concat (getenv "PATH") ":/cygdrive/c/Program Files (x86)/PuTTY"))
(setq exec-path (append exec-path '("/cygdrive/c/Program Files (x86)/PuTTY")))

;; cmake support
(require 'cmake-mode)

;; emms support
;; path to vlc
(setenv "PATH" (concat (getenv "PATH") ":/cygdrive/c/Program Files (x86)/VideoLAN/VLC"))
(setq exec-path (append exec-path '("/cygdrive/c/Program Files (x86)/VideoLAN/VLC")))

;; allow using mediainfo
(require 'emms-setup)
(emms-all)
(emms-default-players)
(require 'emms-player-vlc)
(require 'emms-info-mediainfo)
(add-to-list 'emms-info-functions 'emms-info-mediainfo)

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
