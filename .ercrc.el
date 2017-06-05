;; setup channels for autojoin on connection to freenode

(setq erc-autojoin-channels-alist '(("freenode.net" "#emacs")))

;; setup my list of nicknames
(setq erc-nick 
      (append erc-nick
              '("survivor_19" "Kurvivor")))

