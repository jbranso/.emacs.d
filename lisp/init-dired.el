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

  ;; press "S" in a dired buffer to see dired sort in action
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
              ;; omit boring files: backup files, etc.
              (dired-omit-mode 1))))

(provide 'init-dired)
