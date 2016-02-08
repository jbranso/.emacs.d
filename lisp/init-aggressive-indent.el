;;; Code:

(dolist (hook '(js2-mode-hook cc-mode css-mode emacs-lisp-mode-hook))
  (add-hook hook #'aggressive-indent-mode))

(provide 'init-aggressive-indent)
