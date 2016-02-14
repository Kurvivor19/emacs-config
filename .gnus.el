;;; gnus setup

(setq gnus-select-method '(nnnil "")
      gnus-secondary-select-methods '((nnimap "gmail"
                                              (nnimap-address "imap.gmail.com")
                                              (nnimap-server-port 993)
                                              (nnimap-expunge t)
                                              (nnimap-stream ssl))
                                      (nnimap "yandex"
                                              (nnimap-address "imap.yandex.ru")
                                              (nnimap-server-port 993)
                                              (nnimap-expunge t)
                                              (nnimap-stream ssl))
                                      (nnimap "mail.ru"
                                              (nnimap-address "imap.mail.ru")
                                              (nnimap-server-port 993)
                                              (nnimap-expunge t)
                                              (nnimap-stream ssl))
                                      ))
(setq gnus-summary-line-format
      "%U%R%z%I<%o>%(%[%4L: %-23,23f%]%) %s\n")
