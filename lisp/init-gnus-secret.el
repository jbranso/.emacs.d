(setq
 user-mail-address	"bransoj@hotmail.com"
 user-full-name	"Joshua Branson")

(setq gnus-select-method
      '(nnimap "imap-mail.outlook.com"
               ;; (nnimap-address "mymail.purdue.edu")  ; it could also be imap.googlemail.com if that's your server.
               ;;(nnimap-server-port "993")
               ;;(nnimap-stream ssl)
               ;;(nnir-search-engine imap)
               ))

(setq gnus-secondary-select-methods
      ;; '((nnimap "mymail.purdue.edu"))
      '(())
      )

(require 'smtpmail)
;; smtp hotmail uses STARTTLS
(setq message-send-mail-function 'smtpmail-send-it
      ;;smtpmail-starttls-credentials '(("smtp-mail.outlook.com" 587 nil nil))
      ;;smtpmail-auth-credentials '(("smtp-mail.outlook.com" 587 "bransoj@hotmail.com" nil))
      ;;smtpmail-default-smtp-server "smtp-mail.outlook.com"
      smtpmail-smtp-server "smtp-mail.outlook.com"
      smtpmail-smtp-service 587)

;; (setq nnmail-expiry-target "Deleted")

(setq nnmail-expiry-target 'nnmail-fancy-expiry-target
      nnmail-fancy-expiry-targets
      '((to-from "bransoj@hotmail.com" "Deleted")
        ("subject" "IMPORTANT" "nnfolder:IMPORTANT.%Y.%b")
        ("from" ".*" "Deleted")))

(provide 'init-gnus-secret)
