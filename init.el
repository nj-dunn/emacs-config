
(setq
 user-full-name "Nathan Dunn")

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
        (or (bound-and-true-p straight-base-dir) user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent
         'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq-default indent-tabs-mode t)

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; Allows Using S-Up, S-Down, S-Left, S-right to switch between active windows
(windmove-default-keybindings)
(global-hl-line-mode +1)
(line-number-mode +1)
(column-number-mode t)
(size-indication-mode t)

(setq inhibit-startup-screen t)

(set-frame-parameter nil 'alpha-background 85)
(add-to-list 'default-frame-alist '(alpha-background . 70))

;; Backup files with ~ are annoying - let's put them in a temp directory
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; If file changes externally, automatically reload it
(global-auto-revert-mode t)

;; Load Straight's newer compat before built-in packages such as Eglot
;; Otherwise they can provide Emacs' bundled compat first, leaving Magit
;; without newer shims such as `set-local` on Emacs 30
(straight-use-package 'compat)

;;;;;;;;;;;;;;;;;;;;;;;
;; LSP Configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;
(require 'eglot)
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c-or-c++-mode-hook 'eglot-ensure)

(add-to-list
 'eglot-server-programs
 '((c++-mode c-mode)
   .
   ("clangd" "-log=verbose" "-pretty" "-offset-encoding=utf-16")))

(use-package gptel
  :straight t
  :config
  (setq gptel-model 'gpt-5.6-sol
        gptel-default-mode 'markdown-mode
	gptel-backend (gptel-make-openai-oauth "OpenAI-sub"))
  )

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

(use-package ivy
  :straight t
  :bind (("C-c C-r" . ivy-resume)
	 ("C-x b" . ivy-switch-buffer)
	 ("<f6>" . ivy-resume))
  :config
  (ivy-mode)
  (setopt ivy-use-virtual-buffers t)
  (setopt enable-recursive-minibuffers t)
  ;; Enable this if you want `swiper' to use it:
  ;; (setopt search-default-mode #'char-fold-to-regexp)
  )

(use-package counsel
  :straight t
  :bind (("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file)
	 ("C-x C-/" . counsel-fzf)
	 ("<f1> f" . counsel-describe-function)
	 ("<f1> v" . counsel-describe-variable)
	 ("<f1> o" . counsel-describe-symbol)
	 ("<f1> l" . counsel-find-library)
	 ("<f2> i" . counsel-info-lookup-symbol)
	 ("<f2> u" . counsel-unicode-char)
	 :map minibuffer-local-map
	 ("C-r" . counsel-minibuffer-history)))

(use-package swiper
  :straight t
  :bind (("C-s" . swiper-isearch)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Theming and Aesthetics ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
 '(emacs-materialized-theme
   :type git
   :host github
   :repo "xenodium/emacs-materialized-theme"
   :branch "main"))
(load-theme 'materialized)
;; Materialized doesn't style tabs out of the box
(custom-set-faces
 '(tab-bar
   ((t (:inherit mode-line-active :box (:line-width 6 :color "#191919")))))
 '(tab-bar-tab
   ((t (:inherit default :weight bold :box (:line-width 6 :color "#212121")))))
 '(tab-bar-tab-inactive
   ((t (:inherit mode-line-active :box (:line-width 6 :color "#191919"))))))

;; Use simple text buttons instead of Emacs's built-in tab-bar SVG icons.
(with-eval-after-load 'tab-bar
  (setq
   tab-bar-close-button
   (propertize "  ×"
               'close-tab
               t
               'face
               'tab-bar-tab-inactive
               'help-echo
               "Close tab")
   tab-bar-new-button (propertize "  +  " 'face 'tab-bar-tab-inactive 'help-echo "New tab")))

(straight-use-package '(transpose-frame :type git :host github :repo "emacsorphanage/transpose-frame" :commit "94c8779"))

;; With a delay in key strokes, suggests a key stroke command
(use-package
  which-key
  :straight t
  :diminish which-key-mode
  :config
  (which-key-mode +1))

(use-package
  company
  :straight t
  :diminish company-mode
  :config (add-hook 'after-init-hook #'global-company-mode))

(use-package cmake-mode
  :straight t
  :mode (("CMakeLists\\.txt\\'" . cmake-mode)
	 ("\\.cmake\\'" . cmake-mode)))

;; Syntax checking
(use-package
  flycheck
  :straight t
  :diminish flycheck-mode
  :config (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package robot-mode
  :straight t
  :config
  (add-to-list 'auto-mode-alist '("\\.robot$" . robot-mode))
  (add-to-list 'auto-mode-alist '("\\.resource$" . robot-mode)))

(defvar my-terminal-shell
  (if (eq system-type 'darwin)
      "/bin/zsh"
    "/bin/bash"))

(use-package
  vterm
  :straight t
  :commands (vterm my/open-terminal)
  :bind
  ;; In order for delete key to work when using emacs in terminal mode
  ;; not needed for gui - see https://github.com/akermu/emacs-libvterm/issues/741
  (:map vterm-mode-map ([deletechar] . vterm-send-delete))
  :config
  (setq vterm-shell my-terminal-shell)
  (defun my/open-terminal (&optional _arg)
    (interactive "P")
    (vterm))
  (defalias 'ansi-term #'my/open-terminal)
  (defalias 'term #'my/open-terminal)
  (defalias 'multi-term #'my/open-terminal))



(add-to-list 'term-file-aliases '("xterm-ghostty" . "xterm-256color"))

(use-package
  multi-vterm
  :straight
  (:type git :host github :repo "suonlight/multi-vterm" :files ("*.el")))


;; This is the only easy way I've found to persist my tab bar organization
;; Emacs desktop mode frustratingly does not save tabs (at least on Emacs 30)
;; Running under tmux ruins the theme - in a way I have not been able to debug
(use-package easysession
  :straight t
  :demand t

  :config
  ;; Save every 10 minutes
  (setq easysession-save-interval (* 10 60))
  ;; Save the current session when using `easysession-switch-to'
  (setq easysession-switch-to-save-session t)
  ;;
  ;; Do not exclude the current session when switching sessions
  (setq easysession-switch-to-exclude-current nil)
  ;;
  ;; non-nil: Make `easysession-setup' load the session automatically.
  ;; (nil: session is not loaded automatically; the user can load it manually.)
  (setq easysession-setup-load-session t)

  ;; The `easysession-setup' function adds hooks:
  ;; - To enable automatic session loading during `emacs-startup-hook', or
  ;;   `server-after-make-frame-hook' when running in daemon mode.
  ;; - To save the session at regular intervals, and when Emacs exits.
  ;; (easysession-setup)
  )

(straight-use-package 'markdown-mode)

(if (eq system-type 'darwin)
    (setq markdown-executable-path "/opt/homebrew/bin/pandoc")
  (setq markdown-executable-path "/usr/local/bin/pandoc"))

(use-package
  mcp-server
  :straight
  (mcp-server
   :type git
   :host github
   :repo "rhblind/emacs-mcp-server"
   :files
   ("*.el" "tools/*.el" "mcp-wrapper.py" "mcp-wrapper.sh"))
  :config (add-hook 'emacs-startup-hook #'mcp-server-start-unix))

(use-package
  moody
  :straight t
  :config
  (defface my-moody-buffer-name
    '((t (:foreground "white" :background "black" :weight bold)))
    "Face for Moody buffer-name tab.")
  (defun my-moody-black-tab (string &optional width direction)
    (mapcar
     (lambda (part)
       (if (stringp part)
	   (propertize part 'face 'my-moody-buffer-name)
	 part))
     (moody-tab string width direction)))

  (setq-default moody-mode-line-buffer-identification
		'(:eval
		  (my-moody-black-tab
		   (car (propertized-buffer-identification
			 (format-mode-line "%b")))
		   20
		   'down)))

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


;; New frames will not have to load the configuration from scratch
(require 'server)
(if (not (server-running-p))
    (server-start))

(use-package
  agent-shell
  :straight t
  :config (keymap-set agent-shell-mode-map "C-c TAB" #'agent-shell-cycle-session-mode)
  ;; When running in terminal emacs, regular C-TAB will not reliably make it to emacs
  ;; Terminal emulator may have its own TAB bindings
  (with-eval-after-load 'agent-shell-viewport
    (keymap-set
     agent-shell-viewport-edit-mode-map
     "C-c TAB"
     #'agent-shell-viewport-cycle-session-mode)
    (keymap-set
     agent-shell-viewport-view-mode-map
     "C-c TAB"
     #'agent-shell-viewport-cycle-session-mode)))

(setq agent-shell-openai-authentication
      (agent-shell-openai-make-authentication :login t))

(if (executable-find "rg")
    (use-package rg :straight t))

(use-package
  exec-path-from-shell
  :straight t
  :config
  (when (daemonp)
    (exec-path-from-shell-initialize)))

(use-package
  apheleia
  :straight t
  :config (apheleia-global-mode +1)
  (setf (alist-get 'clang-format apheleia-formatters)
	'("clang-format" "-assume-filename"
          (or (apheleia-formatters-local-buffer-file-name)
	      (apheleia-formatters-mode-extension)
	      ".c")
          "-style=file" ; Forces looking for a local .clang-format file
          "-fallback-style=WebKit"))) ; Fallback if no config file is found

(setq user-init-directory (file-name-directory user-init-file))
(setq user-local-init-directory (file-name-concat user-init-directory "local"))
(load-file (file-name-concat user-init-directory "local/init.el"))
