(setq-default grep-highlight-matches t
              grep-scroll-output t)

;; I don't know what any of this does, but I'm sure it's cool.
(when (executable-find "ag")
  (use-package ag
    :ensure t)
  (use-package wgrep-ag
    :ensure t)
  (setq-default ag-highlight-search t))


(provide 'init-grep)
