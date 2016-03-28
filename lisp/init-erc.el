(use-package erc
  :init
  ;; Join the #emacs and #erc channels whenever connecting to Freenode.
  (setq erc-autojoin-channels-alist '(
                                      ("freenode.net" "#arch")
                                      ("freenode.net" "#emacs")
                                      ("freenode.net" "#org-mode")
                                      ;;regular meeting take place every thursday at 19:00 UTC
                                      ("freenode.net" "#hurd")
                                      ("freenode.net" "#wordpress")
                                      ;; get questions answered about building your own keyboard
                                      ("freenode.net" "#deskthority")
                                      ;; https://www.parabola.nu/
                                      ("freenode.net" "#parabola")
                                      ;;("freenode.net" "#debian-hurd")
                                      )

        ;; Rename server buffers to reflect the current network name instead
        ;; of SERVER:PORT. (e.g. "freenode" instead of "irc.freenode.net:6667"). This
        ;; is useful when using a bouncer like ZNC where you have multiple
        ;; connections to the same server.
        erc-rename-buffers t
        ;; set the default nick
        erc-nick "joshuaBPMan"
        ;; don't prompt me for my password erc should know it
        erc-prompt-for-password nil
        erc-hide-list '("JOIN" "PART" "QUIT")
        ;; don't let erc switch the active buffer when it connects to a new channel when erc is starting up
        ;; this gets annoying because when I'm starting up emacs, it'll switch to "#arch", then "#hurd", then "#org-mode".
        ;; it's very weird.  But after erc has loaded and those initial buffers come up, I want erc to jump to a new channel
        ;; when I try to join it
        erc-join-buffer 'bury
        )

  ;; Interpret mIRC-style color commands in IRC chats
  (setq erc-interpret-mirc-color t)
  (setq )
  :config
  (setq erc-join-buffer 'buffer))

;; Load authentication info from an external source.  Put sensitive
;; passwords and the like in here.
;;(load "~/.emacs.d/.erc-auth")

;; This is an example of how to make a new command.  Type "/uptime" to
;; use it.
(defun erc-cmd-UPTIME (&rest ignore)
  "Display the uptime of the system, as well as some load-related
stuff, to the current ERC buffer."
  (let ((uname-output
         (replace-regexp-in-string
          ", load average: " "] {Load average} ["
          ;; Collapse spaces, remove
          (replace-regexp-in-string
           " +" " "
           ;; Remove beginning and trailing whitespace
           (replace-regexp-in-string
            "^ +\\|[ \n]+$" ""
            (shell-command-to-string "uptime"))))))
    (erc-send-message
     (concat "{Uptime} [" uname-output "]"))))


;; This causes ERC to connect to the IRC server on your own machine (if
;; you have one) upon hitting C-c e b.  Replace MYNICK with your IRC
;; nick.  Often, people like to run bitlbee (http://bitlbee.org/) as an
;; AIM/Jabber/MSN to IRC gateway, so that they can use ERC to chat with
;; people on those networks.
;; (global-set-key "\C-ceb" (lambda () (interactive)
;;                            (erc :server "localhost" :port "6667"
;;                                 :nick "MYNICK")))

;; Make C-c RET (or C-c C-RET) send messages instead of RET.  This has
;; been commented out to avoid confusing new users.
;; (define-key erc-mode-map (kbd "RET") nil)
;; (define-key erc-mode-map (kbd "C-c RET") 'erc-send-current-line)
;; (define-key erc-mode-map (kbd "C-c C-RET") 'erc-send-current-line)

;;; Options


;; The following are commented out by default, but users of other
;; non-Emacs IRC clients might find them useful.
;; Kill buffers for channels after /part
;; (setq erc-kill-buffer-on-part t)
;; Kill buffers for private queries after quitting the server
;; (setq erc-kill-queries-on-quit t)
;; Kill buffers for server messages after quitting the server
;; (setq erc-kill-server-buffer-on-quit t)

(provide 'init-erc)
