(use-package js2-mode
  :ensure t
  :defer t
  :config
  ;; Disable js2 mode's syntax error highlighting by default...
  (setq-default js2-mode-show-parse-errors nil
                js2-mode-show-strict-warnings nil)
  ;; ... but enable it if flycheck can't handle javascript
  (autoload 'flycheck-get-checker-for-buffer "flycheck")

  (defun sanityinc/disable-js2-checks-if-flycheck-active ()
    (unless (flycheck-get-checker-for-buffer)
      (set (make-local-variable 'js2-mode-show-parse-errors) t)
      (set (make-local-variable 'js2-mode-show-strict-warnings) t)))
  (add-hook 'js2-mode-hook 'sanityinc/disable-js2-checks-if-flycheck-active)

  (add-hook 'js2-mode-hook (lambda () (setq mode-name "JS2")))



  ;; (defvar preferred-javascript-indent-level 2)

  (setq-default
   ;; js2-basic-offset preferred-javascript-indent-level
   js2-bounce-indent-p nil)
  ;; make >= look like ≥
  (push '(">=" . ?≥) prettify-symbols-alist)
  (push '("<=" . ?≤) prettify-symbols-alist)
  (js2-imenu-extras-setup)

  :mode
  ("\\.js?\\'" . js2-mode))

(defun my-js-minify-function ()
  "Minifying my js files."
  (interactive)
  (async-shell-command (concat (format "closure --js  %s --js_output_file "
                                       (buffer-file-name))
                               (s-replace ".js" ".min.js" buffer-file-name)) "*js minifying*"))

(add-hook 'js2-mode-hook '(lambda ()
                            ;; I have abbrev turned on for all prog and text modes
                            ;; (abbrev-mode 1)
                            ;; (skewer-mode)
                            (ggtags-mode 1)
                            ;;(push '("function" . ?𝆑) prettify-symbols-alist)
                            (push '(">=" . ?≥) prettify-symbols-alist)
                            (push '("<=" . ?≤) prettify-symbols-alist)
                            (diminish 'ggtags-mode)
                            (add-hook 'after-save-hook 'my-js-minify-function nil t)))

(add-to-list 'display-buffer-alist (cons "\\\*js minifying\\\*" (cons #'display-buffer-no-window nil)))

(use-package rainbow-delimiters :ensure t :defer t)
(dolist (hook '(js2-mode-hook js-mode-hook json-mode-hook))
  (add-hook hook 'rainbow-delimiters-mode))

(setq inferior-js-program-command "js")

(defvar inferior-js-minor-mode-map (make-sparse-keymap))
(define-key inferior-js-minor-mode-map "\C-x\C-e" 'js-send-last-sexp)
(define-key inferior-js-minor-mode-map "\C-\M-x" 'js-send-last-sexp-and-go)
(define-key inferior-js-minor-mode-map "\C-cb" 'js-send-buffer)
(define-key inferior-js-minor-mode-map "\C-c\C-b" 'js-send-buffer-and-go)
(define-key inferior-js-minor-mode-map "\C-cl" 'js-load-file-and-go)

(define-minor-mode inferior-js-keys-mode
  "Bindings for communicating with an inferior js interpreter."
  nil " InfJS" inferior-js-minor-mode-map)

(dolist (hook '(js2-mode-hook js-mode-hook))
  (add-hook hook 'inferior-js-keys-mode))

;; ---------------------------------------------------------------------------
;; Alternatively, use skewer-mode
;; ---------------------------------------------------------------------------

;; (when (maybe-require-package 'skewer-mode)
;;   (after-load 'skewer-mode
;;     (add-hook 'skewer-mode-hook
;;               (lambda () (inferior-js-keys-mode -1)))))

(provide 'init-javascript)
