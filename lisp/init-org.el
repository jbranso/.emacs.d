(use-package org :ensure t
  :config
  ;; org-mode has a command to add a table I think via C-c \  org-match-sparse-tree
  (define-key org-mode-map (kbd "C-c \\") #'delete-horizontal-space))

(provide 'init-org)
