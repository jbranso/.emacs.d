;; set up org2blog
(require 'xml-rpc)
(require 'metaweblog)
(require 'org2blog-autoloads)

(setq org2blog/wp-blog-alist
      '(("jbranso.me"
         :url "http://jbranso.me/xmlrpc.php"
         :username "jbranso"
         :default-title "Hello World"
         :default-categories ("org2blog" "emacs")
         :tags-as-categories nil)
        ))

;; (require 'auth-source) ;; or nothing if already in the load-path
;; (let (credentials)
;;   ;; only required if your auth file is not already in the list of auth-sources
;;   (add-to-list 'auth-sources "~/.netrc")
;;   (setq credentials (auth-source-user-and-password "jbranso.me"))
;;   (setq org2blog/wp-blog-alist
;;         `(("jbranso.me"
;;            :url "http://jbranso.me"
;;            :username ,(car credentials)
;;            :password ,(cadr credentials)))))

(require 'web-mode)

;;  (defun web-mode-attribute-kill ()
;;   "Kill the current html attribute."
;;   (interactive)
;;   (web-mode-attribute-select)
;;   (when mark-active
;;     (kill-region (region-beginning) (region-end))))


;; I think mozRepl is buggy.
;; connect emacs to mozilla so I can reload the webpage.
(load "~/.emacs.d/elpa/mol.el")
(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

;; This will probably come in handy.
;; (defun my-setup-indent (n)
;;   ;; web development
;;   (setq coffee-tab-width n) ; coffeescript
;;   (setq javascript-indent-level n) ; javascript-mode
;;   (setq js-indent-level n) ; js-mode
;;   (setq js2-basic-offset n) ; js2-mode
;;   (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
;;   (setq web-mode-css-indent-offset n) ; web-mode, css in html file
;;   (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
;;   (setq css-indent-offset n) ; css-mode
;;   )

;; (defun my-office-code-style ()
;;   (interactive)
;;   (message "Office code style!")
;;   (setq indent-tabs-mode t) ; use tab instead of space
;;   (my-setup-indent 4) ; indent 4 spaces width
;;   )

;; (defun my-personal-code-style ()
;;   (interactive)
;;   (message "My personal code style!")
;;   (setq indent-tabs-mode nil) ; use space instead of tab
;;   (my-setup-indent 2) ; indent 2 spaces width
;;   )

;; Combine above functions with `prog-mode-hook` and `buffer-file-name`, you can do the per project setup easily.

;; I do this thing when switching project. It takes me no more than one minute. Since my project last at least three months, one minute is not a big deal.


(defun auto-reload-firefox-on-after-save-hook ()
  (add-hook 'after-save-hook
            '(lambda ()
               (interactive)
               (comint-send-string (inferior-moz-process)
                                   "setTimeout(BrowserReload(), \"1000\");"))
            'append 'local)) ; buffer-local

(add-hook 'web-mode-hook 'auto-reload-firefox-on-after-save-hook)
;;(remove-hook 'web-mode-hook 'auto-reload-firefox-on-after-save-hook)

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
(add-to-list 'auto-mode-alist '("\\.css?\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.js?\\'" . js2-mode))

(setq web-mode-engines-alist
      '(("php"  . "\\.php\\.")
        ("django"  . "\\.djhtml\\.")))

;; default html indentation
(setq web-mode-markup-indent-offset 4)
;; default css indentation
;; since I'm not using web-mode for css, I don't need this next line
;;(setq web-mode-css-indent-offset 4)
;; default script indentation (php and js)
;; since I'm not using web-mode for js2-mode, I don't need the next line
;;(setq web-mode-code-indent-offset 4)

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
                           ;;(moz-minor-mode 1)
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

(setq web-mode-ac-sources-alist
  '(("css" . (ac-source-css-property ac-source-html-bootstrap+))
    ("html" . (ac-source-words-in-buffer ac-source-abbrev ac-source-html-bootstrap+))
    ("php" . (ac-source-words-in-buffer
              ac-source-abbrev
              ac-source-html-tag
              ac-source-html-attribute
              ac-source-html-attribute-2
              ac-source-jquery
              ac-source-html-bootstrap+
              ac-source-html-bootstrap))))


(setq web-mode-code-indent-offset 4)

(provide 'init-html)
