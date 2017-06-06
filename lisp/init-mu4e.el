(add-to-list 'load-path "~/programming/mu/mu4e")
(require 'mu4e)

;; tell Emacs where my maildir is
(setq mu4e-maildir (expand-file-name "~/.mail/gmail/"))

(setq mu4e-drafts-folder "/[Gmail].Drafts")
(setq mu4e-sent-folder   "/[Gmail].Sent Mail")
(setq mu4e-trash-folder  "/[Gmail].Trash")

;; try to view the messages in html
;; (setq mu4e-view-prefer-html t mu4e-html2text-command "w3m -T text/html")

;; attempt to show images when viewing messages
(setq mu4e-view-show-images t
      mu4e-show-images t
      mu4e-view-image-max-width 800)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; This lets me know when the indexing sees something new... NOT just new mail though
;; (add-hook 'mu4e-index-updated-hook
;;           (defun new-mail-sound ()
;;             (shell-command "aplay ~/Sounds/boing.wav&")))

;; I can possibly specify actions in mu4e!  Maybe when I reply to one message it lets me send a reply
;; with a specific email address  mu4e-view-actions
;; nevermind.  I should actually do that with contexts

;; specify an attachment folder
(setq mu4e-attachment-dir "~/downloads")
;; don't save message to Sent Messages, GMail/IMAP will take care of this
(setq mu4e-sent-messages-behavior 'delete)

;; setup some handy shortcuts
(setq mu4e-maildir-shortcuts
      '(("/INBOX"             . ?i)
        ("/[Gmail].Sent Mail" . ?s)
        ("/[Gmail].Trash"     . ?t)))

(setq
 user-mail-address "jbranso91@gmail.com"
 user-full-name  "Joshua Branson"
 message-signature
 "<hr>\nJoshua Branson\nWayPoint\nWeb Developer\njbranso.me\nSent From Emacs\nhttps://www.gnu.org/software/emacs/")

(provide 'init-mu4e)
