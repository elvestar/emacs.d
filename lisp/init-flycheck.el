(require 'flycheck)
(add-hook 'after-init-hook 'global-flycheck-mode)

(setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)
      flycheck-idle-change-delay 0.8)

(provide 'init-flycheck)
