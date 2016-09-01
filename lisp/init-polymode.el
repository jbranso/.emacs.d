(use-package polymode :ensure t
  :init (require 'poly-org))

(add-to-list 'auto-mode-alist '("\\.org" . poly-org-mode))
