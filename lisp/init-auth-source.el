(use-package f :ensure t)

(cond
 ((string-equal system-name "antelope")
  (setq epg-gpg-program "gpg"))
 ((string-equal system-name "parabola")
  (setq epg-gpg-program "gpg2"))
 ((string-equal system-name "GuixSD")
  (setq epg-gpg-program "gpg")))

(when (f-file? "~/.authinfo.gpg")
  ;; only use the encrypted file.
  (setq auth-sources '("~/.authinfo.gpg"))
  ;;(require 'auth-source)
  )

(provide 'init-auth-source)
