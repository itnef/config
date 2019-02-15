(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
  '(blink-cursor-mode nil)
  '(column-number-mode t)
  '(inhibit-startup-screen t))

(custom-set-faces
 ;; idem
 )

(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-c C-g") 'goto-line)
