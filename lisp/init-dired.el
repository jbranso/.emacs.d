;;; package --- Summary:
;;; Commentary:
;;; Code:
;;; I've changed this whole file to start using use-package. It seems to be working so far.
(use-package dired
  ;; before loading dired, set these variables
  :defer t
  :init (setq-default diredp-hide-details-initially-flag nil
              dired-dwim-target t
              ;;omit boring auto save files in dired views
              dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$")
  :config ;; after loading dired, do this stuff
  (load "dired-x")

  (use-package dired+
    :ensure t
    :defer t)

  (use-package dired-sort
    :defer t
    :ensure t)
  (define-key dired-mode-map [mouse-2] 'dired-find-file)
  (define-key dired-mode-map "/" 'helm-swoop)

  ;; http://whattheemacsd.com/setup-dired.el-01.html
  ;; I don't need dired to automatically show me all the details ie: all the permissions and stuff
  ;; If I do want the details I can use ")" to show them and "(" to hide them again
  (use-package dired-details
    :ensure t)
  (setq-default dired-details-hidden-string "--- ")
  (dired-details-install)
  (add-hook 'dired-mode-hook
            (lambda ()
              (guide-key/add-local-guide-key-sequence "%")
              ;; omit boring files: backup files, etc.
              (dired-omit-mode 1)
              )))

;;(advice-add 'dired-goto-file :after 'dired-find-file)
;;(add-function (dired-goto-file FILE) :after 'dired-find-file)
;;(add-hook 'dired-goto-file-hook 'dired-find-file)

;; (setq-default diredp-hide-details-initially-flag nil
;;               dired-dwim-target t
;;               ;;omit boring auto save files in dired views
;;               dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$")
;; (require-package 'dired+)
;; (require-package 'dired-sort)
;; (after-load 'dired
;;   ;; dired-x is dired-extra features.  It lets me omit files that are boring from the dired view
;;   ;; and other stuff
;;   (load "dired-x")
;;   (use-package dired+
;;     :defer t
;;     :ensure t)
;;   ;; this lets you sort the dired view with "s"
;;   (use-package dired-sort
;;     :ensure t)

;;   ;;This sorts files is dired. Just press "s" to see it in action.
;;   (require 'dired-sort)
;;   (when (fboundp 'global-dired-hide-details-mode)
;;     (global-dired-hide-details-mode -1))
;;   (setq dired-recursive-deletes 'top)
;;   (define-key dired-mode-map [mouse-2] 'dired-find-file)
;;   (add-hook 'dired-mode-hook
;;             (lambda ()
;;               (guide-key/add-local-guide-key-sequence "%")
;;               ;; omit boring files: backup files, etc.
;;               (dired-omit-mode 1)
;;               )))


;; add a dired advice that says after pressing j to jump to a file,
;; open that file
      ;; (defadvice kill-line (after say-ouch activte)
        ;; (message "ouch"))


(provide 'init-dired)
