
; Starting point was user configuration at:
; https://www.sandeepnambiar.com/my-minimal-emacs-setup/

(setq user-full-name "Nathan Dunn"
      user-mail-address "nathan@nathandunn.dev")

(setq gc-cons-threshold 50000000)
(setq large-file-warning-threshold 100000000)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

; Custom packages stored in my emacs repository
(add-to-list 'load-path (concat user-emacs-directory "/packages"))

(setq-default indent-tabs-mode nil)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

; Allows Using S-Up, S-Down, S-Left, S-right to switch between active windows
(windmove-default-keybindings)
(global-hl-line-mode +1)
(line-number-mode +1)
; (global-display-line-numbers-mode 1) emacs-26 only
(column-number-mode t)
(size-indication-mode t)

(setq inhibit-startup-screen t)

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config))

;; Backup files with ~ are annoying - let's put them in a temp directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

; If file changes externally, automatically reload it
(global-auto-revert-mode t)

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (show-paren-mode t)))

(use-package magit
  :bind (("C-M-g" . magit-status)))

(use-package anzu
  :ensure t
  :config
  (global-anzu-mode +1))

(use-package helm
  :ensure t
  :defer 2
  :bind
  ("M-x" . helm-M-x)
  ("C-x C-f" . helm-find-files)
  ("M-y" . helm-show-kill-ring)
  ("C-x b" . helm-mini)
  :config
  (require 'helm-config)
  (helm-mode 1)
  (setq helm-split-window-inside-p t
    helm-move-to-line-cycle-in-source t)
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 20)
  (helm-autoresize-mode 1)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (use-package smartparens helm doom-themes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package helm-gtags
  :if (locate-file "gtags" exec-path)
  :config
  (setq
    helm-gtags-ignore-case t
    helm-gtags-auto-update t
    helm-gtags-use-input-at-cursor t
    helm-gtags-pulse-at-cursor t
    helm-gtags-suggested-key-mapping t)
   (define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
   (define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
   (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
   (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
   (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
   (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
  )

; With a delay in key strokes, suggests a key stroke command
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode +1))

(use-package company
  :ensure t
  :diminish company-mode
  :config
  (add-hook 'after-init-hook #'global-company-mode))

; Syntax checking
(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package popwin
  :config
  (popwin-mode 1))


(require 'multi-term)
(if (eq system-type 'darwin)
    (progn
      (setq multi-term-program "/bin/zsh")
      (setq markdown-executable-path "/opt/homebrew/bin/pandoc")
      )
  (progn
    (setq multi-term-program "/bin/bash")
    (setq markdown-executable-path "/usr/local/bin/pandoc")
  )
 )

(custom-set-variables
 '(markdown-command markdown-executable-path)
 )


(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'markdown-mode-hook 'turn-on-auto-fill)
(setq-default fill-column 80)


(load "glsl")
; Some additional shader extensions I've seen
(add-to-list 'auto-mode-alist '("\\.vs$" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.fs$" . glsl-mode))

(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)

; New frames will not have to load the configuration from scratch
(require 'server)
(if (not (server-running-p)) (server-start))


