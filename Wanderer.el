
;; make spaces visible
(add-hook 'python-mode-hook
	  (lambda ()
            (whitespace-mode)))

;; setup git environment variables
(setenv "PLINK_PROTOCOL" "ssh")

;; putty paths
(setenv "PATH" (concat (getenv "PATH") ":/cygdrive/c/Program\\ Files\\ (x86)/PuTTY"))
(setq exec-path (append exec-path '("/cygdrive/c/Program Files (x86)/PuTTY")))
