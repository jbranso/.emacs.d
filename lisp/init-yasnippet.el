(use-package yasnippet
  :defer t
  :ensure t)

  (add-to-list 'load-path "~/.emacs.d/snippets")
  (require 'yasnippet)
  (yas-global-mode 1)

(with-eval-after-load 'warnings
  (add-to-list 'warning-suppress-types '(yasnippet backquote-change)))

(provide 'init-yasnippet)
