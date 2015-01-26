(require 'web-mode)

(defun web-mode-attribute-kill ()
  "Kill the current html attribute."
  (interactive)
  (web-mode-attribute-select)
  (when mark-active
    (kill-region (region-beginning) (region-end))))

(define-key web-mode-map (kbd "C-c C-a k") 'web-mode-attribute-kill)

;; I'd like to start using use-package, but it does not seem to be working.
;; (require 'use-package)
;; (use-package web-mode
;;   :mode ("\\.html\\'" . web-mode)
;;   :mode ("\\.php\\'" . web-mode)
;;   :init
;;   (progn
;;     (defun web-mode-attribute-kill ()
;;       "Kill the current html attribute."
;;       (interactive)
;;       (web-mode-attribute-select)
;;       (when mark-active
;;         (kill-region (region-beginning) (region-end)))))
;;   :bind  ("C-c C-a k" . web-mode-attribute-kill))

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php?\\'" . web-mode))

(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'")
        ("php"  . "\\.php\\.")
        ("django"  . "\\.djhtml\\.")))

(require 'emmet-mode)

(add-hook 'web-mode-hook (lambda ()
                           (flyspell-prog-mode)
                           ;;emmet mode is sooo much better than yas
                           ;; (yas-minor-mode)
                           ;;(yas-reload-all)
                           (emmet-mode)
                           (push '("function" . ?𝆑) prettify-symbols-alist)
                           (push '(">=" . ?≥) prettify-symbols-alist)
                           (push '("<=" . ?≤) prettify-symbols-alist)
                           (aggressive-indent-mode)
                           (auto-fill-mode)))

(add-to-list 'web-mode-ac-sources-alist
             '("html" . (ac-source-html-tag
                         ac-source-html-attribute
                         ac-source-html-attribute-2
                         (ac-source-jquery
                          (ac-source-html-bootstrap+)))))

;; (add-to-list 'ac-sources
;;              ac-source-html-tag
;;              ac-source-html-attribute
;;              ac-source-css-property
;;              ac-source-html-bootstrap
;;              ;;this package has almost nothing in it.
;;              ;; or does it?
;;              ;;ac-source-html-bootstrap+
;;              )
(provide 'init-html)
