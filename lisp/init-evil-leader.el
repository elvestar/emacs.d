(global-evil-leader-mode) 
(evil-leader/set-leader ",")
(evil-leader/set-key
  "e" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  "t" 'ggtags-find-tag-dwim
  "r" 'ggtags-find-reference
  )

(provide 'init-evil-leader)
