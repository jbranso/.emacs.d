(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(use-package yasnippet
  :defer t
  :ensure t)
(yas-global-mode 1)

(add-to-list 'warning-suppress-types '(yasnippet backquote-change))

(provide 'init-yasnippet)
