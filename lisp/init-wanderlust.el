(autoload 'wl "wl" "Wanderlust" t)

(require 'init-wanderlust-secret)
(setq wl-from "Joshua Branson <jbranson@setyourwaypoint.com>"

      ;;all system folders (draft, trash, spam, etc) are placed in the
      ;;[Gmail]-folder, except inbox. "%" means it's an IMAP-folder
      wl-default-folder "%inbox"
      wl-draft-folder   "%[Gmail]/Drafts"
      wl-trash-folder   "%[Gmail]/Trash"
      wl-fcc            "%[Gmail]/Sent"

      ;; mark sent messages as read (sent messages get sent back to you and
      ;; placed in the folder specified by wl-fcc)
      wl-fcc-force-as-read    t

      ;;for when auto-compleating foldernames
      wl-default-spec "%")


(provide 'init-wanderlust)
