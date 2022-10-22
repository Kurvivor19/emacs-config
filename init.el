;; Author: Ivan Viktorovich Truskov
;; emacs initialisation script
;; based on emacs-starter-kit ny technomancy

;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

;; Load path etc.

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;; next line commented to avoidwarning messages on startup
; (add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "/config"))

(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq custom-file (concat dotfiles-dir "custom.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))

;; use customizations
(load custom-file)

(package-initialize)

(require 'packages-init)
(require 'packages-preload)
(require 'display-config)
(require 'technomancy-defaults)
(require 'krv-functions)
(require 'irc-opener)

(elpy-enable)

;; System-specific config loading from ESK
(setq system-specific-config (concat dotfiles-dir (system-name) ".el"))
(if (file-exists-p system-specific-config) (load system-specific-config))

;; set up org mode usage
(require 'org-local)

(server-start)
;; Open list of recent files as initial buffer
(recentf-mode 1)
(recentf-open-files)

(projectile-mode)
(helm-projectile-on)

;(require 'c-edit)
