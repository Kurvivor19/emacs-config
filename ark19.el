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
