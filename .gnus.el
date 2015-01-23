;;; gnus setup

(setq gnus-select-method '(nnnil "")
      gnus-secondary-select-methods '((nnimap "gmail"
                                              (nnimap-address "imap.gmail.com")
                                              (nnimap-server-port 993)
                                              (nnimap-expunge t)
                                              (nnimap-stream ssl))
                                      (nnimap "sweb"
                                              (nnimap-address "imap.spaceweb.ru")
                                              (nnimap-server-port 993)
                                              (nnimap-expunge t)
                                              (nnimap-stream ssl))
                                      ))

