;;; Colourise CSS colour literals
(when (maybe-require-package 'rainbow-mode)
  (dolist (hook '(css-mode-hook html-mode-hook sass-mode-hook))
    (add-hook hook 'rainbow-mode)))



;;; SASS and SCSS
(use-package sass-mode)
(use-package scss-mode)
(setq-default scss-compile-at-save nil)



;;; LESS
(use-package less-css-mode)
;; I don't think I've ever used skewer-mode.
;; (when (featurep 'js2-mode)
;;   (use-package skewer-less))


;;; Use eldoc for syntax hints
(require-package 'css-eldoc)
(autoload 'turn-on-css-eldoc "css-eldoc")
(add-hook 'css-mode-hook 'turn-on-css-eldoc)

;;(add-to-list 'ac-sources 'ac-source-css-property)
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.

(provide 'init-css)
