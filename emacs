

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(agda2-program-args
   (quote
    ("--include-path=." "--include-path=/home/user/software/agda/lib/prim/Agda" "--include-path=/home/user/software/agda/lib/stdlib")))
 '(blink-cursor-mode nil)
 '(c-basic-offset 4)
 '(column-number-mode t)
 '(electric-indent-mode nil)
 '(inhibit-startup-screen t)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (z3-mode intero ghc-imported-from ghc flymake-hlint flymake-haskell-multi flycheck-haskell ac-haskell-process rainbow-delimiters ensime markdown-preview-mode markdown-mode auto-complete haskell-mode))))

; (require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)


(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(package-initialize)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-c C-g") 'goto-line)

(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))

; https://stackoverflow.com/questions/8095715/emacs-auto-complete-mode-at-startup
(require 'auto-complete)
(defun auto-complete-mode-maybe ()
  "No maybe for you. Only AC!"
  (unless (minibufferp (current-buffer))
    (auto-complete-mode 1)))
(global-auto-complete-mode t)
(put 'scroll-left 'disabled nil)

(set-variable (quote scheme-program-name) "gambitc")

; (add-hook ’haskell-mode-hook ’interactive-haskell-mode)
