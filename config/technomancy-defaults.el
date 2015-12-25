;;; technomancy-defaults.el

;; Copyright © 2013 Phil Hagelberg and contributors
;; Author: Phil Hagelberg
;; URL: https://github.com/technomancy/better-defaults
;; Version: 0.1.2
;; Created: 2013-04-16
;; Keywords: convenience
;; This file is NOT part of GNU Emacs.
;;; Commentary:
;; There are a number of unfortunate facts about the way Emacs works
;; out of the box. While all users will eventually need to learn their
;; way around in order to customize it to their particular tastes,
;; this package attempts to address the most obvious of deficiencies
;; in uncontroversial ways that nearly everyone can agree upon.
;; Obviously there are many further tweaks you could do to improve
;; Emacs, (like those the Starter Kit and similar packages) but this
;; package focuses only on those that have near-universal appeal.
;;; License:
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING. If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.
;;; Code:
;;;###autoload
(progn
  (setq ido-everywhere t)
  (ido-mode t)
  (setq ido-enable-flex-matching t)
  (global-set-key (kbd "C-x C-b") 'ibuffer)
  ; (global-set-key (kbd "M-z") 'zap-up-to-char)
  (global-set-key (kbd "C-s") 'isearch-forward-regexp)
  (global-set-key (kbd "C-r") 'isearch-backward-regexp)
  (global-set-key (kbd "C-M-s") 'isearch-forward)
  (global-set-key (kbd "C-M-r") 'isearch-backward)

  ;; Personal short keybindings
  (define-prefix-command 'user-map-f5)
  (global-set-key (kbd "<f5>") 'user-map-f5)
  ;; This causes ERC to connect to the Freenode network upon hitting
  ;; <f5> e
  (define-key user-map-f5 (kbd "e") (lambda () (interactive)
                           (erc :server "irc.freenode.net"
                                :nick "Kurvivor" :password "exodus")))
  ;; g for git
  (define-key user-map-f5 (kbd "g") 'magit-status)
  (show-paren-mode 1)
  (setq-default indent-tabs-mode nil)
  (setq x-select-enable-clipboard t
	x-select-enable-primary t
	save-interprogram-paste-before-kill t
	apropos-do-all t
	mouse-yank-at-point t
	require-final-newline t
	visible-bell t
	ediff-window-setup-function 'ediff-setup-windows-plain
	save-place-file (concat user-emacs-directory "places")
	backup-directory-alist `(("." . ,(concat user-emacs-directory
						 "backups"))))
  (defun select-current-line ()
    "Select the current line"
    (interactive)
    (end-of-line) ; move to end of line
    (set-mark (line-beginning-position)))
  (global-set-key (kbd "C-S-l") 'select-current-line)
  
  (add-hook 'python-mode-hook
	  (lambda ()
	    (define-key python-mode-map [remap imenu]
	      'idomenu)
            )
          )
)

(provide 'technomancy-defaults)
;;; technomancy-defaults.el ends here
