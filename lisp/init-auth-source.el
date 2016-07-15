(use-package f :ensure t)

(when (f-file? "~/.authinfo.gpg")
  ;; only use the encrypted file.
  (setq auth-sources '("~/.authinfo.gpg"))
  ;;(require 'auth-source)
  )

(provide 'init-auth-source)
