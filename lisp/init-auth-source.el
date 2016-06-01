(use-package f :ensure t)

(cond ((or (f-file? "~/.authinfo") (f-file? "~/.netrc") (f-file? "~/.authinfo.gpg"))
       (require 'auth-source) ))

(provide 'init-auth-source)
