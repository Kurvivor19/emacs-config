;; packages-init.el
;; handles loading of packages

(require 'package)
(dolist (source '(("melpa" . "http://melpa.org/packages/")
		  ("melpa-stable" . "http://stable.melpa.org/packages/")))
  (add-to-list 'package-archives source t))
(package-initialize)


;; install some packages automatically
;; based on ESK

(require 'cl-lib)

(defvar mine-packages (list 'idle-highlight-mode
			    'magit
			    'autopair
			    'buffer-move
			    'elpy
			    'company
			    'company-jedi
			    'helm
			    'helm-dash
			    'projectile
			    'emms
			    'helm-projectile
			    'org-journal
			    'cmake-mode
			    'cmake-project
                            'ggtags
			    )
  "Libraries that should be installed by default.")

(defun auto-elpa-install ()
  "Install all starter-kit packages that aren't installed."
  (interactive)
  (dolist (package mine-packages)
    (unless (or (member package package-activated-list)
                (functionp package))
      (message "Installing %s" (symbol-name package))
      (let ((debug-on-init nil))
	(with-demoted-errors (package-install package))))))

(defun check-if-online? ()
  "See if we're online.

Windows does not have the network-interface-list function, so we
just have to assume it's online."
  ;; TODO how could this work on Windows?
  (if (and (functionp 'network-interface-list)
           (network-interface-list))
      (cl-some (lambda (iface)
		 (unless (equal "lo" (car iface))
                         (member 'up (cl-first (last (network-interface-info
						      (car iface)))))))
            (network-interface-list))
    t))

;; On your first run, this should pull in all the base packages.
(when (check-if-online?)
  (unless package-archive-contents (package-refresh-contents))
  (auto-elpa-install))

(provide 'packages-init)
