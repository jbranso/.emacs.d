;;; gnus-desktop-notify-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "gnus-desktop-notify" "gnus-desktop-notify.el"
;;;;;;  (22222 12293 137347 859000))
;;; Generated autoloads from gnus-desktop-notify.el

(defvar gnus-desktop-notify-mode nil "\
Non-nil if Gnus-Desktop-Notify mode is enabled.
See the command `gnus-desktop-notify-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `gnus-desktop-notify-mode'.")

(custom-autoload 'gnus-desktop-notify-mode "gnus-desktop-notify" nil)

(autoload 'gnus-desktop-notify-mode "gnus-desktop-notify" "\
Gnus Desktop Notification mode uses libnotify's 'notify-send'
program to generate popup messages or call external executables
whenever a group receives new messages through gnus-demon (see
`gnus-demon-add-handler').

  You can actually call any program by changing the
`gnus-desktop-notify-exec-program' variable, or change the
behavior entirely by setting a different
`gnus-desktop-notify-function' function.

  See the `gnus-desktop-notify' customization group for more
details.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; gnus-desktop-notify-autoloads.el ends here
