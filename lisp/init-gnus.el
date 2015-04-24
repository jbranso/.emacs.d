;; set up gnus to use Purdue IMAP

;; You can find the following guide here: http://www.emacswiki.org/emacs/GnusGmail#toc1
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

;; let's tell gnus who we aref
(setq user-mail-address	"jbranso@purdue.edu"
	  user-full-name	"Joshua Branson")

;; set up search in GNUS
;; http://www.emacswiki.org/emacs/GnusGmail#toc21
(require 'nnir)

;; tell gnus to use my purdue email, and to enable searching my inbox
;; typing GG in the buffer group, lets me search the current group for a string
(setq gnus-select-method
      '(nnimap "mymail.purdue.edu"
	       (nnimap-address "mymail.purdue.edu")  ; it could also be imap.googlemail.com if that's your server.
	       (nnimap-server-port "993")
	       (nnimap-stream ssl)
           (nnir-search-engine imap)
           ))

;; (setq message-send-mail-function 'message-smtpmail-send-it
;;       smtpmail-smtp-server "smtp.purdue.edu"
;;       smtpmail-stream-type 'ssl
;;       smtpmail-smtp-service 465)

;; The variable smtpmail-stream-type controls what form of connection the SMTP library uses. The default value is nil, which
 ;; means to use a plain connection, but try to switch to a STARTTLS encrypted connection if the server supports it. Other
 ;; possible values are: starttls to insist on STARTTLS; ssl to use TLS/SSL; and plain for encryption.

(setq
 smtpmail-smtp-server "smtp.purdue.edu"
 ;;smtpmail-default-smtp-server "smtp.purdue.edu"
 send-mail-function (quote smtpmail-send-it)
 smtpmail-stream-type 'ssl
 smtpmail-smtp-service 465)

;; make a default signature
(setq message-signature
      "Joshua Branson\nPurdue University\nWeb Production Assistant\nweb.ics.purdue.edu/~jbranso\njbranso.me"
      gnus-summary-line-format "%d %U%R%z%I%(%[%4L: %-23,23f%]%) %s \n")


;; change how the summary buffer looks
;;(setq
 ;; gnus-summary-line-format '(%U%R%z%I%(%[%4L: %-23,23f%]%) %s\n))

(provide 'init-gnus)
