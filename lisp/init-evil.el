(require 'evil)

(add-hook 'evil-insert-state-entry-hook 'evil-emacs-state)
; (define-key evil-emacs-state-map (kbd "ESC") 'evil-normal-state) 
(define-key evil-visual-state-map (kbd "i") 'evil-emacs-state) 
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
(define-key evil-normal-state-map (kbd "M-9") 'evil-window-decrease-width)
(define-key evil-normal-state-map (kbd "M-0") 'evil-window-increase-width)
(define-key evil-normal-state-map (kbd "M--") 'evil-window-decrease-height)
(define-key evil-normal-state-map (kbd "M-=") 'evil-window-increase-height)

; DO not user <esc>!
(key-chord-define evil-emacs-state-map "kj" 'evil-normal-state)

; Enable TAB in normal state 
(define-key evil-normal-state-map (kbd "TAB") 'org-cycle)

(evil-mode 1)
(provide 'init-evil)
