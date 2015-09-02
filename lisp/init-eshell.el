(add-hook 'eshell-mode-hook (lambda ()
                              (setq ac-sources
                                    '(
                                      ac-source-filename
                                      ac-source-dictionary
                                      ))
                              ))

(provide 'init-eshell)
