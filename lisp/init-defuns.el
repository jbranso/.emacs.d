(use-package s :ensure t :defer t)

(use-package dash :ensure t :defer t)

(use-package f :ensure t :defer t)
;;(require 'f)

(f-short "/home/joshua")
(f-long "~/")

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

(defun stop-httpd ()
  "This runs /home/joshua/programming/bash/stop-httpd"
  (call-process-shell-command "stop-httpd" nil nil)
  (message "httpd.service stopped."))

(defun start-httpd ()
  "This runs /home/joshua/programming/bash/start-httpd"
  (call-process-shell-command "start-httpd" nil nil)
  (message "httpd.service started."))

(defun save-this-buffer-to-portfolio-site ()
  "Write this buffer to to my portfolio site"
  (interactive)
  ;; Take the current file and save it on the live server
  (setq current-directory
        (s-chop-prefix "Directory " (pwd)))
  (write-file "/ssh:jbranso_portfolio91@ssh.phx.nearlyfreespeech.net:/home/public/")
  ;;Take the current file and save it locally, that way, after I'm done saying the local file
  ;; to the server, pwd is still ~/programming/soihub
  (write-file current-directory))

(defun purdue-delete-this-buffer-from-dev-server ()
  "Remove this file to the purdue dev server."
  (interactive)
  (require 's)
  (let (remote-file-path remote-dir local-file)
    (setq local-file buffer-file-name)
    (setq remote-dir "/ssh:jbranso@dev.www.purdue.edu:/var/www/html/root/honorscollege/")
    (setq remote-file-path (concat
                            remote-dir
                            (s-chop-prefix "/home/joshua/honorscollege/" buffer-file-name)))
    (delete-file remote-file-path)))

(defun update-my-profile-site-lets-encrypt ()
  (interactive)
  ;; What to do in the child process
  (find-file "/home/joshua/programming/org/projects/become-an-awesome-hacker.org")
  (search-forward ":CUSTOM_ID: updateLetsEncrypt")
  (search-forward "#+BEGIN_SRC sh")
  (org-ctrl-c-ctrl-c))

(defun purdue-save-this-buffer-to-dev-server ()
  "Write this buffer to the purdue dev server."
  (interactive)
  (require 's)
  (let (remote-file-path remote-dir local-file)
    (setq local-file buffer-file-name)
    (setq remote-dir "/ssh:jbranso@dev.www.purdue.edu:/var/www/html/root/honorscollege/")
    (setq remote-file-path (concat
                            remote-dir
                            (s-chop-prefix "/srv/http/honorscollege/" buffer-file-name)))
    ;; for some reason updating images doesn't really work.
    ;; I should delete them first.  Then upload them.
    (when (and (string-match "\.pdf$\\\|\.jpg$\\\|\.png$" remote-file-path)
               ;; does the file exist?
               (file-exists-p remote-file-path))
      (delete-file remote-file-path))
    (write-file remote-file-path)
    (write-file local-file)))

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

(defun purdue-deploy-to-dev-server ()
  "Rsynce my project to purdue's dev server."
  (interactive)
  (let (remote-file  remote-file-prefix)
    (setq remote-file-prefix "/ssh:jbranso@dev.www.purdue.edu:/home/users/jbranso/HTML/honorscollege/")
    (setq (concat remote-file (s-chop-prefix "/srv/http/honorscollege/" buffer-file-name)))
    (print remote-file)
    ;; (write-file remote-file)
    ;;(write-file local-file)
    )
  ;; (start-process "rsync-purdue" "*Purdue Deploy*" "rsync"
  ;;                ;; be verbose
  ;;                "-v "
  ;;                ;; recursive into directories
  ;;                "-r "
  ;;                "/srv/http/honorscollege/"
  ;;                "jbranso@dev.www.purdue.edu:/var/www/html/root/honorscollege/")
  ;; (let ((password (read-string "Enter your password: ")))
  ;;   (process-send-string "rsync-purdue" password))
  ;; (split-window-below)
  ;; (windmove-down)
  ;; (switch-to-buffer "rsync-purdue")
  )

(defun org-babel-strip-php-from-sql-block ()
  "Cleans up a sql statement from
   $sql  = 'SELECT * ';
   $sql .= 'FROM USERS ';
   $sql .= 'WHERE 1';
   into
   SELECT *
   FROM USERS
   WHERE 1 "
  (interactive)
  ;; let's first move to the top of the buffer
  (beginning-of-buffer)
  ;; now move point forward to the first char in the buffer
  (while (re-search-forward "\";" nil t)
    (replace-match ""))
  (while (re-search-forward "\$sql.*=.*?" nil t)
    (replace-match ""))
  (while (re-search-forward "\$sql.*\.=.*?" nil t)
    (replace-match ""))
  (while (re-search-forward "\$sql.*=.*\"" nil t)
    (replace-match "")))


(provide 'init-defuns)
