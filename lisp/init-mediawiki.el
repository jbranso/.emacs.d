;;; Code:
(use-package mediawiki :ensure t
  :config (setq mediawiki-site-alist
                (append '(("Parabola" "https://wiki.parabola.nu/" "jbranso" "babbages" "Main page"))
                        mediawiki-site-alist)))

(provide 'init-mediawiki)
