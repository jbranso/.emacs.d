;;this function creates a hot-key M-x gtd that will open my gtd file
(defun gtd ()
  "This command opens ~/things_to_do.org"
  (interactive)
  (find-file "~/programming/org/gtd/gtd.org"))

;; this function will open my init file for me
(defun init.el ()
  "init-file opens ~/.emacs"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun init-evil ()
  "loads my viper initialization file"
  (interactive)
  (load "~/.emacs.d/lisp/init-evil.el")
  (find-file "~/.emacs.d/lisp/init-evil.el"))

;; This file will open rc.lua
(defun rc.lua ()
  "This command opens ~/.config/awesome/rc.lua"
  (interactive)
  (find-file "~/.config/awesome/rc.lua"))

;; This file will open emacs.texi
(defun emacs.texi ()
  "This command opens ~/manuals/cheatsheats/emacs.texi"
  (interactive)
  (find-file "~/manuals/cheatsheats/emacs.texi"))

;; This file will open gawk.texi
(defun gawk.texi ()
  "This command opens ~/manuals/cheatsheats/gawk.texi"
  (interactive)
  (find-file "~/manuals/cheatsheats/gawk.texi"))

;; This file will open definitions.el
(defun init-defuns ()
  "This command opens ~/.emacs.d/definitions.el"
  (interactive)
  (find-file "~/.emacs.d/lisp/init-defuns.el"))

(defun systemd.texi ()
  "This command opens ~/manuals/systemd.texi"
  (interactive)
  (find-file "~/manuals/systemd.texi"))

;;test awesome
(defun test-awesome ()
  "this run /home/joshua/programming/bash/test-awesome.bash"
  (interactive)
  (start-process "testing-awesome" "test-of-awesome" "test-awesome.bash"))
;; you can use start-process like this:
;; (start-process NAME BUFFER PROGRAM &rest PROGRAM-ARGS))

;; open index.php
(defun soihub-index ()
  "This opens /home/joshua/programming/soihub/index.php"
  (interactive)
  (find-file "/home/joshua/programming/soihub/index.php"))


;;sh into soihub and pull stuff from master
(defun soihub-update-dev-server ()
  "This runs /home/joshua/programming/bash/soihub"
  (interactive)
  (call-process-shell-command "soihub" nil nil)
  (message "soihub process finished."))


;; this writes the current file to the live soihub server
(defun soihub-save-this-buffer-to-live-server ()
  "Write this buffer to soihub"
  (interactive)
  ;; this when statement probably doesn't need to be here.
  (when (string-match "_[-a-z_A-Z0-9]*\\.php\\|[-a-z_A-Z0-9]*\\.php" buffer-file-name)
    (setq php-file-name (match-string 0 buffer-file-name) ))
  (write-file "/ssh:jbranso@locutus.cs.purdue.edu:/home/isi-wiki/soi/"))


(provide 'init-defuns)
