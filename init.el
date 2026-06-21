
					; Starting point was user configuration at:
					; https://www.sandeepnambiar.com/my-minimal-emacs-setup/

(setq user-full-name "Nathan Dunn"
      user-mail-address "nathan@nathandunn.dev")

(setq gc-cons-threshold 50000000)
(setq large-file-warning-threshold 100000000)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)


(setq package-enable-at-startup nil)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

					; Custom packages stored in my emacs repository
(add-to-list 'load-path (concat user-emacs-directory "/packages"))

(setq-default indent-tabs-mode t)

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

(set-frame-parameter nil 'alpha-background 85)
(add-to-list 'default-frame-alist '(alpha-background . 70))

;; Backup files with ~ are annoying - let's put them in a temp directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

					; If file changes externally, automatically reload it
(global-auto-revert-mode t)

(require 'eglot)
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c-or-c++-mode-hook 'eglot-ensure)

(add-to-list 'eglot-server-programs
             '((c++-mode c-mode) . ("clangd" "-log=verbose" "-pretty" "-offset-encoding=utf-16")))

(straight-use-package 'gptel)
(setq gptel-default-mode 'markdown-mode)

(use-package smartparens
    :straight t
    :diminish smartparens-mode
    :config
    (progn
      (require 'smartparens-config)
      (smartparens-global-mode 1)
      (show-paren-mode t)))

(use-package magit
    :straight t
    :bind (("C-x g" . magit-status)))

(use-package anzu
    :straight t
    :config
    (global-anzu-mode +1))

(use-package helm
    :straight t
    :defer 2
    :bind
    ("M-x" . helm-M-x)
    ("C-x C-f" . helm-find-files)
    ("M-y" . helm-show-kill-ring)
    ("C-x b" . helm-mini)
    :config
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
 '(custom-safe-themes
   '("b1e991696e0f8c0b0e17ca9048ba567cde123c865e2721283de6e98defc3d102"
     "cee5c56dc8b95b345bfe1c88d82d48f89e0f23008b0c2154ef452b2ce348da37"
     "ac893acecb0f1cf2b6ccea5c70ea97516c13c2b80c07f3292c21d6eb0cb45239"
     "59c36051a521e3ea68dc530ded1c7be169cd19e8873b7994bfc02a216041bf3b"
     "296dcaeb2582e7f759e813407ff1facfd979faa071cf27ef54100202c45ae7d4"
     "a3a71b922fb6cbf9283884ac8a9109935e04550bcc5d2a05414a58c52a8ffc47"
     "ae20535e46a88faea5d65775ca5510c7385cbf334dfa7dde93c0cd22ed663ba0"
     "00d7122017db83578ef6fba39c131efdcb59910f0fac0defbe726da8072a0729"
     "36c5acdaf85dda0dad1dd3ad643aacd478fb967960ee1f83981d160c52b3c8ac"
     "ea4dd126d72d30805c083421a50544e235176d9698c8c541b824b60912275ba1"
     "8c7e832be864674c220f9a9361c851917a93f921fedb7717b1b5ece47690c098"
     "3cdd0a96236a9db4e903c01cb45c0c111eb1492313a65790adb894f9f1a33b2d"
     "9013233028d9798f901e5e8efb31841c24c12444d3b6e92580080505d56fd392"
     "a9eeab09d61fef94084a95f82557e147d9630fbbb82a837f971f83e66e21e5ad"
     "88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e" default))
 '(markdown-command markdown-executable-path)
 '(package-selected-packages
   '(company doom-themes ef-themes eglot flycheck gnu-elpa-keyring-update helm
     magit smartparens treemacs use-package which-key yaml-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(straight-use-package
 '(emacs-materialized-theme :type git :host github :repo "xenodium/emacs-materialized-theme" :branch "main"))
(load-theme 'materialized)

					; With a delay in key strokes, suggests a key stroke command
(use-package which-key
    :straight t
    :diminish which-key-mode
    :config
    (which-key-mode +1))

(use-package company
    :straight t
    :diminish company-mode
    :config
    (add-hook 'after-init-hook #'global-company-mode))

					; Syntax checking
(use-package flycheck
    :straight t
    :diminish flycheck-mode
    :config
    (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package robot-mode
    :straight t
    )
(add-to-list 'auto-mode-alist '("\\.robot$" . robot-mode))
(add-to-list 'auto-mode-alist '("\\.resource$" . robot-mode))

(defvar my-terminal-shell
  (if (eq system-type 'darwin) "/bin/zsh" "/bin/bash"))

(use-package vterm
    :straight t
    :commands (vterm my/open-terminal)
    :config
    (setq vterm-shell my-terminal-shell)
    (defun my/open-terminal (&optional _arg)
      (interactive "P")
      (vterm))
    (defalias 'ansi-term #'my/open-terminal)
    (defalias 'term #'my/open-terminal)
    (defalias 'multi-term #'my/open-terminal))

(use-package multi-vterm
    :straight (:type git :host github :repo "suonlight/multi-vterm"
		     :files("*.el"))
    )

					; In order for delete key to work when using emacs in terminal mode
					; not needed for gui - see https://github.com/akermu/emacs-libvterm/issues/741
(define-key vterm-mode-map [deletechar] #'vterm-send-delete)

(straight-use-package 'markdown-mode)

(if (eq system-type 'darwin)
    (setq markdown-executable-path "/opt/homebrew/bin/pandoc")
    (setq markdown-executable-path "/usr/local/bin/pandoc"))


(use-package mcp-server
    :straight (mcp-server
               :type git
               :host github
               :repo "rhblind/emacs-mcp-server"
               :files ("*.el" "tools/*.el" "mcp-wrapper.py" "mcp-wrapper.sh"))
    :config
    (add-hook 'emacs-startup-hook #'mcp-server-start-unix))

(use-package moody
    :straight t
    :config
    (setq-default mode-line-format
		  '(""
		    mode-line-front-space
		    mode-line-client
		    mode-line-frame-identification
		    mode-line-buffer-identification
		    " "
		    mode-line-position
		    (vc-mode vc-mode)
		    (multiple-cursors-mode mc/mode-line)
		    mode-line-modes
		    mode-line-end-spaces))
    (moody-replace-mode-line-buffer-identification)
    (moody-replace-vc-mode))

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

(use-package agent-shell
    :straight t
    :config
    (keymap-set agent-shell-mode-map "C-c TAB" #'agent-shell-cycle-session-mode)
					; When running in terminal emacs, regular C-TAB will not reliably make it to emacs
					; Terminal emulator may have its own TAB bindings
    (with-eval-after-load 'agent-shell-viewport
      (keymap-set agent-shell-viewport-edit-mode-map "C-c TAB" #'agent-shell-viewport-cycle-session-mode)
      (keymap-set agent-shell-viewport-view-mode-map "C-c TAB" #'agent-shell-viewport-cycle-session-mode)))

(setq agent-shell-openai-authentication
      (agent-shell-openai-make-authentication :login t))

(if (executable-find "rg")
    (use-package rg  :straight t))


(straight-use-package 'apheleia
		      :config
		      (apheleia-global-mode +1)
		      (setf  (alist-get 'clang-format apheleia-formatters)
			     '("clang-format" 
			       "-assume-filename" (or (apheleia-formatters-local-buffer-file-name) 
						   (apheleia-formatters-mode-extension) 
						   ".c")
			       "-style=file"               ; Forces looking for a local .clang-format file
			       "-fallback-style=WebKit"))  ; Fallback if no config file is found
		      )
