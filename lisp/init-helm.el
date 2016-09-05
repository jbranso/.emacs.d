
;; (use-package helm
;;   :bind (:map helm-mode-map
;;               ("C-c h" . helm-execute-persistent-action)))

;; (use-package helm
;;   :ensure t
;;   ;; apperently this next line causes some serious errors
;;   ;;  :diminish helm-mode
;;   )
;; Before we load any helm things, need to load helm-flx so it uses flx instead of helm's fuzzy matching.
(use-package helm-flx
  :ensure t
  :defer t
  :init (helm-flx-mode +1))
;; according to the github repo this next line is all that I need to install helm
(require 'helm-config)
;; I've installed helm-ag, which might be cool.

(setq
 ;;don't let helm swoop guess what you want to search... It is normally wrong and annoying.
 helm-swoop-pre-input-function #'(lambda () (interactive))
 ;; tell helm to use recentf-list to look for files instead of file-name-history
 helm-ff-file-name-history-use-recentf t
 ;; let helm show 2000 files in helm-find-files
 ;; since I let recent f store 2000 files
 helm-ff-history-max-length 1000
 ;; I've set helm's prefix key in init-editing utils
 ;; don't let helm index weird output files from converting .tex files to pdf for example
 helm-ff-skip-boring-files t
 ;;make helm use the full frame. not needed.
 ;; helm-full-frame t
 ;; enable fuzzy mating in M-x
 ;;helm-M-x-fuzzy-match t
 ;;helm-recentf-fuzzy-match t
 ;;helm-apropos-fuzzy-match t
;;the more of these sources that I have, the slower helm will be
 helm-for-files-preferred-list '(
                                 helm-source-buffers-list
                                 helm-source-recentf
                                 helm-source-bookmarks
                                 helm-source-file-cache
                                 helm-source-files-in-current-dir
                                 ;;helm-source-locate
                                 ;;helm-source-projectile-files-in-all-projects-list
                                 ;;helm-source-findutils
                                 ;;helm-source-files-in-all-dired
                                 ))


(helm-mode 1)

;; for whatever reason, helm is looking for files with "C-x f" and not "C-x C-f"
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; (define-key helm-find-files-map (kbd "C-f") 'helm-execute-persistent-action)
;; the next command will add another C-j command for helm
;;(define-key helm-map (kbd "C-f") 'helm-execute-persistent-action)
;; I am removing C-t which toggles where on the screen helm pops up when I do this next line
;;(define-key helm-map (kbd "C-t") 'helm-execute-persistent-action)
;;(define-key helm-map (kbd "s-t") 'helm-execute-persistent-action)
;;(define-key helm-top-map (kbd "C-k") 'helm-kill-this-unruly-process)
;;(define-key helm--minor-mode-map (kbd "C-f") 'helm-execute-persistent-action)
;;I should define some cool helm mini commands

;; (global-set-key (kbd "C-c h")
;;                 (defhydra hydra-helm (:color pink)
;;                   "helm"
;;                   ("r" helm-resume)))

;; (defhydra hydra-test (hint :nil)
;;   ("r" helm-resume))

;; (defhydra hydra-zoom (global-map "<f2>")
;;   "zoom"
;;   ("g" text-scale-increase "in")
;;   ("l" text-scale-decrease "out"))

;; how do I get this to work?
;; (define-key helm-find-files-map (kbd "s-h") 'helm-next-line)

(provide 'init-helm)
