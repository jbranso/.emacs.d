;;; Code:

(require 'register)

;; I might need to use (set-register register value)

(defun my/number-to-register (number register)
  (interactive "n number: \nMregister: ")
  ;;(number-to-register number register)
  (set-register register number))

;; gosh this is getting soo annoying and it's not working at all
;;(print register-alist)

(defun my/insert-register (register)
  (interactive "Mregister: ")
  (print register)
  (insert-register register))

(defun my/increment-register ())

(defhydra hydra-register (:color pink :hint nil)
  "
^Store^                     ^Insert^                       ^Increase^
^^^^^^----------------------------------------------------------------------
_n_umber to register        _i_nsert number register       _I_ncrease the register
C-u <number> C-x r n R
insert _N_umbers left       C-x r i R                      C-u number C-x r + r
  of Rectangle              Insert _t_ext to register
  C-x r N                   C-x r s R
"
  ;; Store
  ("n" my/number-to-register)
  ("N" rectangle-number-lines)

  ;; Insert
  ("i" my/insert-register)          ; Show (expand) everything
  ("t" copy-to-register)          ; Show (expand) everything

  ;; Increase
  ("I" my/increment-register)    ; Hide everything but the top-level headings

  ("g" nil "leave"))


;; I want to set this hydra to a keybinding.  So I don't have to remember all of the keybindings
(global-set-key (kbd "C-c C-r") 'hydra-register/body)
;; a ton of other modes try to set C-c C-r to a keybinding.  I am overriding them.
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-r") 'hydra-register/body))
(with-eval-after-load 'web-mode
  (define-key web-mode-map (kbd "C-c C-r") 'hydra-register/body))
(with-eval-after-load 'php-mode
  (define-key php-mode-map (kbd "C-c C-r") 'hydra-register/body))


(provide 'init-register)
