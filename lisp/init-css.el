;;; Colourise CSS colour literals
(use-package rainbow-mode :ensure t)
(dolist (hook '(css-mode-hook html-mode-hook sass-mode-hook))
  (add-hook hook 'rainbow-mode))



;;; SASS and SCSS
(use-package sass-mode :ensure t)
(use-package scss-mode :ensure t)
(setq-default scss-compile-at-save nil)



;;; LESS
(use-package less-css-mode :ensure t)
;; I don't think I've ever used skewer-mode.
;; (when (featurep 'js2-mode)
;;   (use-package skewer-less))


;;; Auto-complete CSS keywords
(after-load 'auto-complete
  (dolist (hook '(css-mode-hook sass-mode-hook scss-mode-hook))
    (add-hook hook 'ac-css-mode-setup)))


;;; Use eldoc for syntax hints
(require-package 'css-eldoc)
(autoload 'turn-on-css-eldoc "css-eldoc")
(add-hook 'css-mode-hook 'turn-on-css-eldoc)

;;(add-to-list 'ac-sources 'ac-source-css-property)
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.

(provide 'init-css)
