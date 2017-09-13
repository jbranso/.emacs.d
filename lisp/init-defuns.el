(use-package s :ensure t :defer t)

(use-package dash :ensure t :defer t)

(defun gtd ()
  "This command opens ~/things_to_do.org"
  (interactive)
  (find-file "~/programming/org/gtd/gtd.org"))

(defun init.el ()
  "init-file opens ~/.emacs"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun init-evil ()
  "loads my viper initialization file"
  (interactive)
  (load "~/.emacs.d/lisp/init-evil.el")
  (find-file "~/.emacs.d/lisp/init-evil.el"))

(defun rc.lua ()
  "This command opens ~/.config/awesome/rc.lua"
  (interactive)
  (find-file "~/.config/awesome/rc.lua"))

(defun emacs.texi ()
  "This command opens ~/manuals/cheatsheats/emacs.texi"
  (interactive)
  (find-file "~/manuals/cheatsheats/emacs.texi"))

(defun gawk.texi ()
  "This command opens ~/manuals/cheatsheats/gawk.texi"
  (interactive)
  (find-file "~/manuals/cheatsheats/gawk.texi"))

(defun systemd.texi ()
  "This command opens ~/manuals/systemd.texi"
  (interactive)
  (find-file "~/manuals/systemd.texi"))

(defun test-awesome ()
  "this run /home/joshua/programming/bash/test-awesome.bash"
  (interactive)
  (start-process "testing-awesome" "test-of-awesome" "test-awesome.bash"))

(defun purdue-view-this-buffer-in-browser ()
  "View the current file in your browser.  Since anything under community is now wordpress, then if the user wants to
view o community page, show him the qa server."
  (interactive)
  (require 's)
  (let (url dev-string qa-string)
    (setq dev-string "https://dev.honors.purdue.edu/")
    (setq qa-string  "https://qa.honors.purdue.edu/")
    (if (s-match "community" buffer-file-name)
        (setq url (concat qa-string (s-chop-prefix "/srv/http/honorscollege/" buffer-file-name)))
      (setq url (concat dev-string  (s-chop-prefix "/srv/http/honorscollege/" buffer-file-name))))
    (browse-url url)))

(defun purdue-view-this-buffer-locally ()
  "View the current file in your browser.  Since anything under community is now wordpress, then if the user wants to
view o community page, show him the qa server."
  (interactive)
  (require 's)
  (let (url local-string)
    (setq local-string "localhost/honorscollege/")
    (setq url (concat local-string  (s-chop-prefix "/srv/http/honorscollege/" buffer-file-name)))
    (browse-url url)))

(provide 'init-defuns)
