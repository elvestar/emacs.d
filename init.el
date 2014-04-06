;;; backup
(setq
  backup-by-copying t 
  backup-directory-alist '(("." . "~/.backup"))
  delete-old-versions t 
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;;; line number
(add-hook 'org-mode-hook 'linum-mode)
(add-hook 'c++-mode-hook 'linum-mode)
(setq linum-format "%3d ")

;;; auto-fill-mode is a minor mode, so (auto-fill-mode 1) will not active it
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'c++-mode-hook 'turn-on-auto-fill)
(add-hook 'c-mode-hook 'turn-on-auto-fill)
(setq default-fill-column 80)

;;; winner mode
(winner-mode)

(require 'package)

(add-to-list 'package-archives
              '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq package-user-dir (expand-file-name "elpa" "~/.emacs.d"))
(package-initialize)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

(require 'init-org)

(require 'init-key-chord)
(require 'init-evil)
(require 'init-evil-leader)

(require 'init-yasnippet)
(require 'init-flycheck)
(require 'init-helm)
(require 'init-smex)
(require 'init-window-numbering)

;; TODO
; (require 'init-magit)

;; TODO
; (require 'init-auto-complete)
; (require 'init-auto-complete-clang)

;; TODO
; (require 'init-helm-gtags)


(require 'init-projectile)
(require 'init-helm-projectile)


(provide 'init)
;;; init.el ends here
