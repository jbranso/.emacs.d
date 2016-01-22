;;; https://github.com/roman/golden-ratio.el
(use-package golden-ratio
  :ensure t
  :config (setq golden-ratio-exclude-modes
                '( "sr-mode" "ediff-mode" "gnus-summary-mode" ))
  :diminish golden-ratio-mode)
(golden-ratio-mode 1)
(provide 'init-golden-ratio)
;;; init-golden-ratio ends here
