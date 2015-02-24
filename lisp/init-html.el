(require 'web-mode)

;;  (defun web-mode-attribute-kill ()
;;   "Kill the current html attribute."
;;   (interactive)
;;   (web-mode-attribute-select)
;;   (when mark-active
;;     (kill-region (region-beginning) (region-end))))


;; I think mozRepl is buggy.
;; connect emacs to mozilla so I can reload the webpage.
;;(load "~/.emacs.d/elpa/mol.el")
;;(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(defun auto-reload-firefox-on-after-save-hook ()
  (add-hook 'after-save-hook
            '(lambda ()
               (interactive)
               (comint-send-string (inferior-moz-process)
                                   "setTimeout(BrowserReload(), \"1000\");"))
            'append 'local)) ; buffer-local

;;(add-hook 'web-mode-hook 'auto-reload-firefox-on-after-save-hook)
(remove-hook 'web-mode-hook 'auto-reload-firefox-on-after-save-hook)

;; Example - you may want to add hooks for your own modes.
;; I also add this to python-mode when doing django development.
;; this is not working... I think MozRepl is very very buggy.
;;(add-hook 'web-mode-hook 'auto-reload-firefox-on-after-save-hook)
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
                           ;;emmet mode is sooo much better than yas
                           ;; (yas-minor-mode)
                           ;;(yas-reload-all)
                           (emmet-mode)
                           (local-unset-key (kbd "C-<return>"))
                           ;;                           (define-key web-mode-map (kbd "C-c C-a k") 'web-mode-attribute-kill)
                           (define-key web-mode-map (kbd "C-<return>") '(lambda ()
                                                                          (interactive)
                                                                          (newline)
                                                                          (evil-open-above 0)))
                           (moz-minor-mode 1)
                           (push '("function" . ?𝆑) prettify-symbols-alist)
                           (push '(">=" . ?≥) prettify-symbols-alist)
                           (push '("<=" . ?≤) prettify-symbols-alist)
                           ;; I should not enable aggressive indent mode for soihub files.
                           ;; There's no need to have lots of git diffs with files.
                           (if (equal (pwd) "/home/joshua/programming/soihub/")
                               ;; if pwd is soihub, disable aggressive-indent-mode
                               (aggressive-indent-mode -1)
                             (aggressive-indent-mode))
                           ;; unset web mode's C-c C-h command, because I want to use that for 'help
                           (local-unset-key (kbd "C-c C-h"))
                           (global-set-key (kbd "C-c C-h") 'help)))

(add-to-list 'web-mode-ac-sources-alist
             '("html" . (ac-source-html-tag
                         ac-source-html-attribute
                         ac-source-html-attribute-2
                         (ac-source-jquery
                          (ac-source-html-bootstrap+)))))

(setq web-mode-code-indent-offset 4)

(provide 'init-html)
