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

;; telega.el installation
(add-to-list 'load-path "~/Development/telega.el")
(require 'telega)

(define-key user-map-f5 (kbd "t") 'telega)

;; SLIME setup
(setq inferior-lisp-program "ecl")
(require 'slime)

(slime-setup '(slime-repl
               slime-fuzzy
               slime-fancy-inspector
               slime-indentation))

;; sbt, metals, lsp and other Scala setup
(setq exec-path (append exec-path '("/home/kurvivor/.local/share/coursier/bin")))
;; export CS_FORMER_JAVA_HOME="$JAVA_HOME"
(setenv "CS_FORMER_JAVA_HOME" (getenv "JAVA_HOME"))
;; export JAVA_HOME="/home/kurvivor/.cache/coursier/jvm/adopt@1.14.0-2"
(setenv "JAVA_HOME" "/home/kurvivor/.cache/coursier/jvm/adopt@1.14.0-2")
;; export PATH="/home/kurvivor/.cache/coursier/jvm/adopt@1.14.0-2/bin:$PATH"
(setenv "PATH" (concat "/home/kurvivor/.cache/coursier/jvm/adopt@1.14.0-2/bin:" (getenv "PATH")))

(require 'use-package)


;; Enable defer and ensure by default for use-package
;; Keep auto-save/backup files separate from source code:  https://github.com/scalameta/metals/issues/1027
(setq use-package-always-defer t
      use-package-always-ensure t
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; Enable scala-mode for highlighting, indentation and motion commands
(use-package scala-mode
  :interpreter
    ("scala" . scala-mode))

;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
  (setq sbt:program-options '("-Dsbt.supershell=false")))

(use-package lsp-mode
  ;; Optional - enable lsp-mode automatically in scala files
  :hook  (scala-mode . lsp)
         (lsp-mode . lsp-lens-mode)
  :config
  ;; Uncomment following section if you would like to tune lsp-mode performance according to
  ;; https://emacs-lsp.github.io/lsp-mode/page/performance/
  ;;       (setq gc-cons-threshold 100000000) ;; 100mb
  ;;       (setq read-process-output-max (* 1024 1024)) ;; 1mb
  ;;       (setq lsp-idle-delay 0.500)
  ;;       (setq lsp-log-io nil)
  ;;       (setq lsp-completion-provider :capf)
  (setq lsp-prefer-flymake nil))

;; Add metals backend for lsp-mode
(use-package lsp-metals)

;; Enable nice rendering of documentation on hover
;;   Warning: on some systems this package can reduce your emacs responsiveness significally.
;;   (See: https://emacs-lsp.github.io/lsp-mode/page/performance/)
;;   In that case you have to not only disable this but also remove from the packages since
;;   lsp-mode can activate it automatically.
(use-package lsp-ui)

;; Use company-capf as a completion provider.
;;
;; To Company-lsp users:
;;   Company-lsp is no longer maintained and has been removed from MELPA.
;;   Please migrate to company-capf.
(use-package company
  :hook (scala-mode . company-mode)
  :config
  (setq lsp-completion-provider :capf))

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
