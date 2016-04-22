;;; systemd-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "systemd" "systemd.el" (22235 4225 236059 430000))
;;; Generated autoloads from systemd.el
 (add-to-list 'auto-mode-alist '("\\.automount\\'" . systemd-mode))
 (add-to-list 'auto-mode-alist '("\\.busname\\'" . systemd-mode))
 (add-to-list 'auto-mode-alist '("\\.mount\\'" . systemd-mode))
 (add-to-list 'auto-mode-alist '("\\.service\\'" . systemd-mode))
 (add-to-list 'auto-mode-alist '("\\.slice\\'" . systemd-mode))
 (add-to-list 'auto-mode-alist '("\\.socket\\'" . systemd-mode))
 (add-to-list 'auto-mode-alist '("\\.target\\'" . systemd-mode))
 (add-to-list 'auto-mode-alist '("\\.timer\\'" . systemd-mode))
 (add-to-list 'auto-mode-alist '("\\.link\\'" . systemd-mode))
 (add-to-list 'auto-mode-alist '("\\.netdev\\'" . systemd-mode))
 (add-to-list 'auto-mode-alist '("\\.network\\'" . systemd-mode))
 (add-to-list 'auto-mode-alist '("\\.override\\.conf.*\\'" . systemd-mode))

(autoload 'systemd-mode "systemd" "\
Major mode for editing systemd unit files.
See http://www.freedesktop.org/wiki/Software/systemd/ for more
information about systemd.

In addition to any hooks its parent mode might have run, this
mode runs the hook `systemd-mode-hook' at mode initialization.

Key bindings:
\\{systemd-mode-map}

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("systemd-company.el" "systemd-pkg.el")
;;;;;;  (22235 4225 382798 362000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; systemd-autoloads.el ends here
