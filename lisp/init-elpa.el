(require 'package)


;;; Standard package repositories

;; don't use marmalade.  They are down all the time and not reliable
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; emacs should not be using http to download packages
;; https://glyph.twistedmatrix.com/2015/11/editor-malware.html

(add-to-list 'package-archives '("gnu"   . "http://elpa.gnu.org/packages/"))

;;; Also use Melpa for most packages
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org"   . "http://orgmode.org/elpa/"))

;;tell emacs where my certificates are
;; (let ((trustfile
;;        (replace-regexp-in-string
;;         "\\\\" "/"
;;         (replace-regexp-in-string
;;          "\n" ""
;;          (shell-command-to-string "python -m certifi")))))
;;   (setq tls-program
;;         (list
;;          (format "gnutls-cli%s --x509cafile %s -p %%p %%h"
;;                  (if (eq window-system 'w32) ".exe" "") trustfile)))
;;   (setq gnutls-verify-error t)
;;   (setq gnutls-trustfiles (list trustfile)))

;; This is some test code that if it gives you errors tells you that emacs is NOT using tls properly
;; I'm getting errors so tls is not working right
 ;; (if (condition-case e
 ;;         (progn
 ;;           (url-retrieve "https://wrong-host.badssl.com/"
 ;;                         (lambda (retrieved) t))
 ;;           (url-retrieve "https://self-signed.badssl.com/"
 ;;                         (lambda (retrieved) t))
 ;;           t)
 ;;       ('error nil))
 ;;     (error "tls misconfigured")
 ;;   (url-retrieve "https://badssl.com"
 ;;                 (lambda (retrieved) t)))

;; No one uses melpa stable apparently according to the melpa maintainer Steve Purcell and original author of this config.
;;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

;; I am adding this repo to install sun-rise commander
;; It expands upon dired and lets you manage copying files from one directory to another
;; You can use it to copy files remotely.  Very cool.
;; (add-to-list 'package-archives '("SC" . "http://joseito.republika.pl/sunrise-commander/"))

;;; On-demand installation of packages

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))


(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install package `%s': %S" package err)
     nil)))


;;; Fire up package.el
(setq package-enable-at-startup nil)
(package-initialize)



;;(require-package 'fullframe)
;;(fullframe list-packages quit-window)


;;(require-package 'cl-lib)
;;(require 'cl-lib)

(defun sanityinc/set-tabulated-list-column-width (col-name width)
  "Set any column with name COL-NAME to the given WIDTH."
  (cl-loop for column across tabulated-list-format
           when (string= col-name (car column))
           do (setf (elt column 1) width)))

(defun sanityinc/maybe-widen-package-menu-columns ()
  "Widen some columns of the package menu table to avoid truncation."
  (when (boundp 'tabulated-list-format)
    (sanityinc/set-tabulated-list-column-width "Version" 13)
    (let ((longest-archive-name (apply 'max (mapcar 'length (mapcar 'car package-archives)))))
      (sanityinc/set-tabulated-list-column-width "Archive" longest-archive-name))))

(add-hook 'package-menu-mode-hook 'sanityinc/maybe-widen-package-menu-columns)

;; This sets up el-get
;; but I don't use it so???
;;(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
;;     (goto-char (point-max))
;;     (eval-print-last-sexp)))

;; (add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;; (el-get 'sync)

(provide 'init-elpa)
