(require 'company)

(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "C-c o") 'company-complete)

(provide 'init-company)
