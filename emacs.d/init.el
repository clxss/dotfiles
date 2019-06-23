(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(use-package company
  :init
  (setq company-idle-delay 0.1)
  :hook
  (after-init . global-company-mode)
  :bind
  (("C-n" . company-select-next)
   ("C-p" . company-select-previous)
   :map company-active-map))

(use-package lsp-mode
  :hook
  (prog-mode . lsp))

(use-package lsp-ui
  :hook
  (lsp-mode . lsp-ui-mode))

(use-package company-lsp
  :config
  (push 'company-lsp company-backends))

(use-package ccls
  :init
  (setq ccls-executable "/usr/bin/ccls")
  :hook
  ((c++-mode . (lambda() (lsp)))))

(use-package company-c-headers
  :config
  (add-to-list 'company-backends 'company-c-headers)
  (defun my-c++-mode-hook ()
    (add-to-list 'company-c-headers-path-system '"/usr/include/c++/9/"))
  :hook
  (c++-mode . my-c++-mode-hook))

(use-package flycheck
   :hook
   (prog-mode . global-flycheck-mode))

(use-package flycheck-rust
  :hook
  ((flycheck-mode . flycheck-rust-setup)
   (rust-mode . flycheck-mode)))

(use-package rust-mode
  :init
  (setq rust-format-on-save t))

(use-package nord-theme
  :config
  (when (display-graphic-p)
    (load-theme 'nord t)))

(use-package telephone-line
  :init
  (setq telephone-line-primary-left-separator 'telephone-line-cubed-left
	telephone-line-secondary-left-separator 'telephone-line-cubed-hollow-left
	telephone-line-primary-right-separator 'telephone-line-cubed-right
	telephone-line-secondary-right-separator 'telephone-line-cubed-hollow-right)
  (setq telephone-line-height 24
	telephone-line-evil-use-short-tag t)
  :config
  (telephone-line-mode t))

(use-package projectile
  :bind
  (("s-p" . projectile-command-map)
   ("C-c p" . projectile-command-map)
   :map projectile-mode-map)
  :hook
  (prog-mode . projectile-mode))

(use-package emacs
  :init
  (menu-bar-mode -1)

  (if (fboundp 'tool-bar-mode)
      (tool-bar-mode -1))

  (if (fboundp 'scroll-bar-mode)
      (scroll-bar-mode -1))

  (if (fboundp 'blink-cursor-mode)
      (blink-cursor-mode -1))
  
  (setq cursor-type 'bar)

  (global-display-line-numbers-mode)
  (setq display-line-numbers-type 'relative)

  (show-paren-mode)
  
  (global-hl-line-mode)

  (defalias 'yes-or-no-p 'y-or-n-p)

  (setq inhibit-splash-screen t
	initial-scratch-message nil)

  (prefer-coding-system 'utf-8)
  (set-language-environment "UTF-8")

  (add-to-list 'default-frame-alist '(font . "IBM Plex Mono-13"))
  (set-face-attribute 'default nil :font "IBM Plex Mono-13")
  (set-frame-font "IBM Plex Mono-13" nil t)
  
  (setq auto-save-default nil
	backup-by-copying t
	backup-directory-alist
	'(("." . "~/backups/"))
	delete-old-versions t
	kept-new-versions 6
	kept-old-versions 2
	version-control t))
