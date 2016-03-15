;;; Code:


(evil-set-initial-state 'snake-mode 'emacs)
(evil-set-initial-state 'comint-mode 'normal)
(evil-set-initial-state 'eshell-mode 'emacs)
(evil-set-initial-state 'shell-mode 'emacs)
(evil-set-initial-state 'git-commit-mode 'emacs)
(evil-set-initial-state 'git-rebase-mode 'emacs)
(evil-set-initial-state 'git-timemachine-mode 'emacs)
(evil-set-initial-state 'term-mode 'emacs)
;; why is this not working?
(evil-set-initial-state 'info-mode 'emacs)
(evil-set-initial-state 'help-mode 'emacs)
(evil-set-initial-state 'helm-grep-mode 'emacs)
(evil-set-initial-state 'grep-mode 'emacs)
(evil-set-initial-state 'bc-menu-mode 'emacs)
(evil-set-initial-state 'rdictcc-buffer-mode 'emacs)
(evil-set-initial-state 'wdired-mode 'normal)
(evil-set-initial-state 'git-timemachine-mode 'emacs)
(evil-set-initial-state 'sx-compose-mode 'emacs)
(evil-set-initial-state 'sx-question-mode 'emacs)
(evil-set-initial-state 'sx-question-list-mode 'emacs)
(evil-set-initial-state 'erc-mode 'emacs)
(evil-set-initial-state 'paradox-menu-mode 'emacs)
(evil-set-initial-state 'woman-mode 'emacs)
(evil-set-initial-state 'pdf-view-mode 'emacs)
;; this is needed for committing git messages.  It's annoying to have to press i every time I want make a git commit
(evil-set-initial-state 'text-mode 'insert)

;; trying to make all modes that use motion state, you evil-emacs state by default
;; https://www.reddit.com/r/evilmode/comments/323xh1/is_it_possible_to_use_vi_keybindings_everywhere/
;; but it seemed to make it pretty hard to make a commit w/ magit
;; (setq evil-normal-state-modes (append evil-motion-state-modes evil-emacs-state-modes))
;; (setq evil-motion-state-modes nil)

(evil-set-initial-state 'dired-mode 'emacs)
(define-key dired-mode-map (kbd "h") #'dired-next-line)
(define-key dired-mode-map (kbd "t") #'dired-previous-line)
(define-key dired-mode-map (kbd "n") #'backward-char)
(define-key dired-mode-map (kbd "s") #'forward-char)
;; "T" is normally bound to dired-do-touch
(define-key dired-mode-map (kbd "T") #'dired-toggle-marks)
(define-key dired-mode-map (kbd "S") #'dired-sort-toggle-or-edit)


(evil-set-initial-state 'magit-branch-manager-mode 'emacs)

;; h is bound to magit-key-mode-popup-diff-options
;; H is bound to magit-diff-toggle-refine-hunk
(with-eval-after-load 'magit
  (define-key magit-status-mode-map (kbd "h") #'magit-goto-next-section)
  (define-key magit-status-mode-map (kbd "t") #'magit-goto-previous-section)

  (define-key magit-status-mode-map (kbd "H") #'magit-key-mode-popup-diff-options)
  (define-key magit-status-mode-map (kbd "T") #'magit-key-mode-popup-tagging))


;; this defines the up and down keys for gnus
;; BUT both need to define T,H to do what N and P do
(define-key gnus-group-mode-map (kbd "t") #'gnus-group-prev-unread-group)
(define-key gnus-group-mode-map (kbd "h") #'gnus-group-next-unread-group)

(define-key gnus-summary-mode-map (kbd "t") #'gnus-summary-prev-unread-article)
(define-key gnus-summary-mode-map (kbd "h") #'gnus-summary-next-unread-article)

;; I'll have to try out each one at a time and see which one works, if one does work
;;(evil-set-initial-state 'ggtags-navigation-mode 'normal)
;;(evil-set-initial-state 'ggtags-tags-mode 'normal)
;; setting this to emacs makes opening up any new buffer set the evil state to emacs
(evil-define-key 'normal org-mode-map (kbd "RET") 'org-return)
(evil-set-initial-state 'ggtags-global-mode 'emacs)

(provide 'init-evil-rebellion-clone)
