;; read these pages:
;;http://www.mostlymaths.net/2010/12/emacs-30-day-challenge-glimpse-of-bbdb.html
;; http://www.mostlymaths.net/2010/12/emacs-30-day-challenge-using-gnus-to.html
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


;;establishing a connection

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
	      ;; (nnimap-address "mymail.purdue.edu")  ; it could also be imap.googlemail.com if that's your server.
	       (nnimap-server-port "993")
	       (nnimap-stream ssl)
           (nnir-search-engine imap)
           ))

;; The variable smtpmail-stream-type controls what form of connection the SMTP library uses. The default value is nil, which
 ;; means to use a plain connection, but try to switch to a STARTTLS encrypted connection if the server supports it. Other
 ;; possible values are: starttls to insist on STARTTLS; ssl to use TLS/SSL; and plain for encryption.

(setq
 smtpmail-smtp-server "smtp.purdue.edu"
 ;;smtpmail-default-smtp-server "smtp.purdue.edu"
 send-mail-function (quote smtpmail-send-it)
 smtpmail-stream-type 'ssl
 smtpmail-smtp-service 465)

;; make gnus load more than 1 email in the background
;; this seems to slow stuff down
;; (setq
;;  gnus-asynchronous t
;;  ;; fetch 15 messages by default
;;  gnus-use-article-prefetch 15)



;; make a default signature
(setq message-signature
      "Joshua Branson\nPurdue University\nWeb Production Assistant\nweb.ics.purdue.edu/~jbranso\njbranso.me"
      gnus-summary-line-format "%d %U%R%z%I%(%[%4L: %-23,23f%]%) %s \n")



;;have gnus alert you when a new mail arrives
(require 'gnus-desktop-notify)
(gnus-desktop-notify-mode)
(gnus-demon-add-scanmail)
(gnus-demon-add-handler 'gnus-group-get-new-news 20 t)
;;alledigeely this next line is not necessary
;;(gnus-demon-init)

;; change how the summary buffer looks
;;(setq
 ;; gnus-summary-line-format '(%U%R%z%I%(%[%4L: %-23,23f%]%) %s\n))



;; get bbdb set up (insidious big brother database) it manages your mail contacts
;; http://bbdb.sourceforge.net/bbdb.html#SEC13
(require 'bbdb)
;; these string are needed to initial bbdb for gnus, message, and send mail
;;(bbdb-initialize 'gnus 'message 'sendmail 'w3)
;; if this doesn't work, use the obve code
(bbdb-initialize 'gnus 'message 'w3)

;;initialize bbdb for gnus
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)

;; use bbdb in message mode
(bbdb-insinuate-message)

;; this is not working right now.
;; (add-hook 'message-mode-hook
;;           '(lambda ()
;;              (local-set-key "s-<TAB>" 'bbdb-complete-name)))

;;allow bbdb records to allow the inclusion of URLs
;;(bbdb-insinuate-w3)

(setq bbdb/gnus-summary-prefer-real-names t
      bbdb-file "~/.emacs.d/bbdb"
      bbdb-default-area-code 765
      ;; make gnus auto create records for the email that I read
      ;; this is a bad idea, because I get junk mail
      ;; bbdb/news-auto-create-p t
      bbdb-user-mail-names "jbranso@purdue.edu"
      ;; make bbdb pop up when you are using it in gnus
      bbdb-use-pop-up t
      ;; make bbdb save the database without asking
      bbdb-offer-save  1
      bbdb-update-records-p t
      ;; gnus will recognize these email addresses as mine
      bbdb-user-mail-address-re
      (regexp-opt
       '("jbranso@purdue.edu" "bransoj@hotmail.com"))
      message-dont-reply-to-names bbdb-user-mail-address-re
      gnus-ignored-from-addresses bbdb-user-mail-address-re)

(bbdb-initialize 'gnus 'message)
(bbdb-mua-auto-update-init 'message)

;; making gnus a little faster
(setq
 ;;make startup faster
 gnus-check-new-newsgroups nil
 gnus-check-bogus-newsgroups nil
 ;;entering the summary buffer faster
 gnus-nov-is-evil nil
 gnus-show-threads nil
 gnus-use-cross-reference nil)

;; use smiley's in gnus
(setq gnus-treat-display-smileys t)


(provide 'init-gnus)
