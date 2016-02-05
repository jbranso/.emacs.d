
;; turn on limum mode
;; but don't have it turned on in org mode, because it slows down org
(dolist (hook '(js2-mode-hook web-mode-hook php-mode-hook emacs-lisp-mode-hook))
  (add-hook hook #'linum-mode))

(provide 'init-linum)
