;; set up gnus to use Purdue IMAP

;; Quickstart
;; Put the following in ~/.profile (I put it in .bash_profile) :

;; export EMAIL="<EMAIL_ADDRESS>"
;; export NAME="<FULL NAME>"
;; export SMTPSERVER="smtp.gmail.com"
;; For example, if your name is John Smith and your email address is johnsmith@gmail.com:

;; export EMAIL="johnsmith@gmail.com"
;; export NAME="John Smith"
;; export SMTPSERVER="smtp.gmail.com"
;; Now put the following in your ~/.gnus file:

;; (setq gnus-select-method
;;       '(nnimap "gmail"
;; 	       (nnimap-address "imap.gmail.com")  ; it could also be imap.googlemail.com if that's your server.
;; 	       (nnimap-server-port "imaps")
;; 	       (nnimap-stream ssl)))

;; (setq smtpmail-smtp-service 587
;;       gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")
;; Put the following in your ~/.authinfo file, replacing <USER> with your email address and replacing <PASSWORD> with your password—or your application-specific password:

;; machine imap.gmail.com login <USER> password <PASSWORD> port imaps
;; machine smtp.gmail.com login <USER> password <PASSWORD> port 587
;; If you don’t wish to store your password there, just omit the “password <PASSWORD>” altogether and Gnus will prompt you when it needs your password.

;; When sending your first email from gnus, you might get a STARTTLS error. If you’re using homebrew in Mac OS X, you can install the necessary package with brew install gnutls.

;; You can find more information in the following sections.

;; Run ‘M-x gnus’ and enjoy.


(setq gnus-select-method
      '(nnimap "purdue email"
	       (nnimap-address "mymail.purdue.edu")  ; it could also be imap.googlemail.com if that's your server.
	       (nnimap-server-port "993")
	       (nnimap-stream ssl)))

(setq smtpmail-smtp-service 465)

(provide 'init-gnus)
