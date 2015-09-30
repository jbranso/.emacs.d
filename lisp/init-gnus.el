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

;; When sending your first email from gnus, you might get a STARTTLS error. If you’re using homebrew in Mac OS X, you can install
;; the necessary package with brew install gnutls.

;; You can find more information in the following sections.

;; Run ‘M-x gnus’ and enjoy.


;;establishing a connection

;; let's tell gnus who we are
;;(require 'init-gnus-secret)
;; init-gnus-secret looks like:
;; (setq
;;  user-mail-address	"<your email address>"
;;  user-full-name	"<Your Full Name>")
(setq
 ;;make a default signature
 message-signature
 "Joshua Branson\nWayPoint\nWeb Developer\nweb.ics.purdue.edu/~jbranso\njbranso.me\nSent From Emacs"
 ;; add a date to the default summare line format
 gnus-summary-line-format "%d %U%R%z%I%(%[%4L: %-23,23f%]%) %s \n"
 ;; use smiley's in gnus
 gnus-treat-display-smileys t

 ;; making gnus a little faster
 ;;make startup faster

 gnus-check-new-newsgroups nil
 gnus-check-bogus-newsgroups nil
 ;; this file is often large. Why read it? What's it do?
 ;; the next two variables might be slowing it down
 ;;setting the next line to nil will slow down gnus apparently [[info:gnus#The%20Active%20File][info:gnus#The Active File]]
 ;;gnus-read-active-file nil
 ;; no need to recenter the summary buffer all the time
 gnus-auto-center-summary nil
 ;;entering the summary buffer faster
 gnus-nov-is-evil nil
 gnus-show-threads nil
 gnus-use-cross-reference nil
 ;; default encryption and signing of stuff
 ;;https://www.gnu.org/software/emacs/manual/html_node/gnus/Security.html#Security
 ;;sign and encrypt messages if you recognize the senders by default
 mm-verify-option "known"
 mm-decrypt-option "known"
 ;; reply and encrypt/sign messages if you know the user by default
 ;; https://www.gnu.org/software/emacs/manual/html_node/gnus/Security.html#Security
 gnus-message-replysign t
 gnus-message-replyencrypt t


 ;;message filters
 spam-blacklist "/home/joshua/.emacs.d/lisp/blacklist"
 spam-use-blacklist t)

(spam-initialize)


;; set up search in GNUS
;; http://www.emacswiki.org/emacs/GnusGmail#toc21
;;(require 'nnir)
(use-package nnir)


;; tell gnus to use my purdue email, and to enable searching my inbox
;; typing GG in the buffer group, lets me search the current group for a string
;; you have to hit "t" when you first open gnus
;; to get purdue working again uncomment this whole thing
;; (setq gnus-select-method
;;       '(nnimap "mymail.purdue.edu"
;; 	      ;; (nnimap-address "mymail.purdue.edu")  ; it could also be imap.googlemail.com if that's your server.
;; 	       (nnimap-server-port "993")
;; 	       (nnimap-stream ssl)
;;            (nnir-search-engine imap)
;;            )
;;       ;; The variable smtpmail-stream-type controls what form of connection the SMTP library uses. The default value is nil, which
;;       ;; means to use a plain connection, but try to switch to a STARTTLS encrypted connection if the server supports it. Other
;;       ;; possible values are: starttls to insist on STARTTLS; ssl to use TLS/SSL; and plain for encryption.
;;       smtpmail-smtp-server "smtp.purdue.edu"
;;       ;;smtpmail-default-smtp-server "smtp.purdue.edu"
;;       send-mail-function (quote smtpmail-send-it)
;;       smtpmail-stream-type 'ssl
;;       smtpmail-smtp-service 465
;;       )

;; I'm trying to get gnus to work with gmail, but no dice so far
(setq gnus-select-method
      '(nnimap "gmail"
               (nnimap-address "imap.gmail.com")  ; it could also be imap.googlemail.com if that's your server.
               (nnimap-server-port "993")
               (nnimap-stream ssl))
      )

(require 'init-gnus-secret-smtp)
;; init-gnus-secret-smtp looks like
;; (require 'smtpmail)
;; (setq message-send-mail-function 'smtpmail-send-it
;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials '(("smtp.gmail.com" 587 "<your gmail address>" nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587)

;; (setq user-mail-address "<your gmail address>")
;; (setq send-mail-function 'smtpmail-send-it)

;;more attractive summary buffer
;; http://groups.google.com/group/gnu.emacs.gnus/browse_thread/thread/a673a74356e7141f
(when window-system
  (setq gnus-sum-thread-tree-indent "  ")
  (setq gnus-sum-thread-tree-root "") ;; "● ")
  (setq gnus-sum-thread-tree-false-root "") ;; "◯ ")
  (setq gnus-sum-thread-tree-single-indent "") ;; "◎ ")
  (setq gnus-sum-thread-tree-vertical        "│")
  (setq gnus-sum-thread-tree-leaf-with-other "├─► ")
  (setq gnus-sum-thread-tree-single-leaf     "╰─► "))
(setq gnus-summary-line-format
      (concat
       "%0{%U%R%z%}"
       "%3{│%}" "%1{%d%}" "%3{│%}" ;; date
       "  "
       "%4{%-20,20f%}"               ;; name
       "  "
       "%3{│%}"
       " "
       "%1{%B%}"
       "%s\n"))
(setq gnus-summary-display-arrow t)


;; make gnus load more than 1 email in the background
;; this seems to slow stuff down in the initial connection, and it doesn't seem all that fast once everything is opened.
;; (setq
;;  gnus-asynchronous t
;;  ;; fetch 15 messages by default
;;  gnus-use-article-prefetch 15)




;;have gnus alert you when a new mail arrives
(use-package gnus-desktop-notify
  :ensure t)
;;This is supposed to let me know when I get a new email, but not really
;;http://www.thregr.org/~wavexx/software/gnus-desktop-notify.el/index.html
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
(use-package bbdb
  :ensure t)
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



(provide 'init-gnus)
