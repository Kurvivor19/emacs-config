;;; gnus setup

(setq user-mail-address "trus19@gmail.com")
(setq user-full-name "Ivan Truskov")

(setq gnus-select-method '(nnnil "")
      gnus-secondary-select-methods '((nnimap "gmail"
                                              (nnimap-address "imap.gmail.com")
                                              (nnimap-inbox "INBOX")
                                              (nnimap-server-port 993)
                                              (nnimap-expunge t)
                                              (nnimap-stream ssl)
                                              (nnimap-split-methods nnimap-split-fancy)
                                              (nnimap-split-fancy
                                               (|
                                                 (from ".*reply.*" "gmail.notifications")
                                                 (from ".*notif.*" "gmail.notifications")
                                                 (from ".*hetzner\\.com.*" "gmail.notifications")
                                                 (from ".*edx\\.org" "gmail.notifications")
                                                 (from ".*paypal\\.com" "gmail.notifications")
                                                 (to "emacs-orgmode@gnu.org" "gmail.feed")
                                                 ("Reply-To" ".*reply.*" "gmail.notifications")
                                                 "gmail.rest")))
                                                  
                                      (nnimap "yandex"
                                              (nnimap-address "imap.yandex.ru")
                                              (nnimap-server-port 993)
                                              (nnimap-expunge t)
                                              (nnimap-stream ssl))
                                      (nnimap "mail.ru"
                                              (nnimap-address "imap.mail.ru")
                                              (nnimap-inbox "INBOX")
                                              (nnimap-server-port 993)
                                              (nnimap-expunge t)
                                              (nnimap-stream ssl)
                                              (nnimap-split-methods nnimap-split-fancy)
                                              (nnimap-split-fancy
                                               (|
                                                (from ".*@warforge\\.ru.*" "mailru.notifications")
                                                (from ".*@myheritage\\.com.*" "mailru.notifications")
                                                (from ".*@playdekgames.com" "mailru.notifications")
                                                (from ".*@beeline\\.ru.*" "mailru.notifications")
                                                (from "*.forum.tinycorelinux.net.*" "mailru.notifications")
                                                (from ".*Alpha Centauri 2.*" "mailru.notifications")
                                                (any ".*nadezhda0705@ya\\.ru.*" "mailru.education")
                                                (from ".*CodeProject.*" "mailru.feed")
                                                (from ".*sourceforge\\.net.*" "mailru.feed")
                                                "mailru.rest")))
                                                
                                      (nntp "news.gwene.org")))                                            
                                      
(setq gnus-summary-line-format
      "%U%R%z%I<%o>%(%[%4L: %-23,23f%]%) %s\n")
