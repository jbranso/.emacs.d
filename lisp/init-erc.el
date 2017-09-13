(use-package erc
  :init
  ;; Join the #emacs and #erc channels whenever connecting to Freenode.
  (setq erc-autojoin-channels-alist '(
                                      ("freenode.net" "#archlinux")
                                      ("ircs://irc.oftc.net:6697" "#awesome")
                                      ("freenode.net" "#deskthority")
                                      ("freenode.net" "#emacs")
                                      ("freenode.net" "#fsf")
                                      ("freenode.net" "#gnupg")
                                      ("freenode.net" "#guix")
                                      ("freenode.net" "#guile")
                                      ("freenode.net" "#hurd")
                                      ("freenode.net" "#org-mode")
                                      ;;regular meeting take place every thursday at 19:00 UTC
                                      ;; get questions answered about building your own keyboard
                                      ;; https://www.parabola.nu/
                                      ("freenode.net" "#parabola")
                                      ;;purdue users group
                                      ("freenode.net" "#purduelug")
                                      ("freenode.net" "#wordpress")
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
        erc-prompt-for-password t
        ;;erc-prompt-for-password t
        erc-hide-list '("JOIN" "PART" "QUIT")
        ;; don't let erc switch the active buffer when it connects to a new channel when erc is starting up
        ;; this gets annoying because when I'm starting up emacs, it'll switch to "#arch", then "#hurd", then "#org-mode".
        ;; it's very weird.  But after erc has loaded and those initial buffers come up, I want erc to jump to a new channel
        ;; when I try to join it
        erc-join-buffer 'bury

        ;; Interpret mIRC-style color commands in IRC chats
        erc-interpret-mirc-color t)

  ;; guixSD cannot read my gpg keys.  This way I can still use erc on GuixSD
  (if (equal system-name "parabola")
      (setq erc-prompt-for-password nil)
    (setq erc-prompt-for-password t))

  ;; don't prompt me for my password erc should know it
  erc-prompt-for-password nil
  ;;erc-prompt-for-password t

  :config
  (setq erc-join-buffer 'buffer)

  :defer t)

(provide 'init-erc)
