(dolist (hook '(org-mode-hook
                prog-mode-hook
                text-mode-hook))
  (add-hook hook (lambda ()
                   (abbrev-mode 1)
                   (diminish 'abbrev-mode))))

(provide 'init-abbrev)
