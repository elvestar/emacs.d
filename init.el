;;; Backup
(setq
  backup-by-copying t 
  backup-directory-alist '(("." . "~/.backup"))
  delete-old-versions t 
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

(require 'package)

(add-to-list 'package-archives
              '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq package-user-dir (expand-file-name "elpa" "~/.emacs.d"))
(package-initialize)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

(require 'init-evil)
(require 'init-org)
(require 'init-company)
(require 'init-yasnippet)
(require 'init-flycheck)
(require 'init-helm)

