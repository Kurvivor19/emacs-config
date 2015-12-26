;; setup channels for autojoin on connection to freenode
(setq erc-autojoin-channels-alist '(("freenode.net" "#emacs")))

;; setup my list of nicknames
(setq erc-nick 
      (append erc-nick
              '("Kurvivor" "survivor_19")))


;; This causes ERC to connect to the Freenode network upon hitting
;; C-c e f.
(global-set-key "\C-cef" (lambda () (interactive)
                           (erc :server "irc.freenode.net" :port "6667"
                                :nick "Kurvivor" :password "exodus")))
