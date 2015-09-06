(setq-default grep-highlight-matches t
              grep-scroll-output t)

;; I don't know what any of this does, but I'm sure it's cool.
(when (executable-find "ag")
  (require-package 'ag)
  (require-package 'wgrep-ag)
  (setq-default ag-highlight-search t))


(provide 'init-grep)
