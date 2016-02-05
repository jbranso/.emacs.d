(require 'bookmark)
(defhydra hydra-bookmark (:color pink :hint nil)
  "
^Edit^                   ^Jump^                    ^Set^
^^^^^^------------------------------------------------------
_e_: edit bookmarks     _j_ump to bookmark         _s_: set bookmark
_r_: rename             _J_ump to gnus bookmark    _S_: set a gnus bookmark
"
  ;; Edit
  ("e" edit-bookmarks)                ; Up
  ("r" helm-bookmark-rename)                ; Up

  ;; Jump
  ("j" bookmark-jump)          ; Show (expand) everything
  ("J" gnus-bookmark-jump )          ; Show (expand) everything

  ;; Set
  ("s" bookmark-set)    ; Hide everything but the top-level headings
  ("S" gnus-bookmark-set)    ; Hide everything but the top-level headings

  ("z" nil "leave"))


;; I want to set this hydra to a keybinding.  So I don't have to remember all of the keybindings
(global-set-key (kbd "C-c C-b") 'hydra-bookmark/body)
;; a ton of other modes try to set C-c C-b to a keybinding.  I am overriding them.
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-b") 'hydra-bookmark/body))
(with-eval-after-load 'web-mode
  (define-key web-mode-map (kbd "C-c C-b") 'hydra-bookmark/body))
(with-eval-after-load 'php-mode
  (define-key php-mode-map (kbd "C-c C-b") 'hydra-bookmark/body))

(provide 'init-bookmark)
