;; set up yasnippet.

(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(use-package yasnippet
  :ensure t)
(yas-global-mode 1)
;; (diminish 'yas-global-mode)
;; I don't want yas globally on, because emmet mode works better in for html, and css
;; however, if I can change yas-expand key to something other than tab, then I should turn this back on.
;; because then I can have snippets for javascript, jquery, and php!
;;(yas-global-mode 1)

(provide 'init-yasnippet)
