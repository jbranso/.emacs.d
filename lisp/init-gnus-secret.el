(setq
 user-mail-address	"bransoj@hotmail.com"
 user-full-name	"Joshua Branson")

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
