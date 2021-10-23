;;; INIT -- Init file for emacs (https://github.com/dtomvan/.config)
;;; Commentary:
;;; Tom van Dijk's init.el file.
;;; Code:

;; -- BARE METAL BOILERPLATE --
(setq inhibit-compacting-font-caches t)
(setq gc-cons-threshold 100000000)
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 800000)))
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups
(fringe-mode 20)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(save-place-mode 1)
(blink-cursor-mode 0)
(column-number-mode 1)
(add-hook 'prog-mode-hook #'hl-line-mode)
(add-hook 'text-mode-hook #'hl-line-mode)
(add-hook 'dired-mode-hook #'hl-line-mode)
(add-to-list 'default-frame-alist '(font . "Jetbrains Mono"))
(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil)
(setq indicate-empty-lines t
      indicate-buffer-boundaries 'left)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; -- ISEARCH --
(defadvice isearch-repeat (after isearch-no-fail activate)
  "Make isearch wrap."
  (unless isearch-success
    (ad-disable-advice 'isearch-repeat 'after 'isearch-no-fail)
    (ad-activate 'isearch-repeat)
    (isearch-repeat (if isearch-forward 'forward))
    (ad-enable-advice 'isearch-repeat 'after 'isearch-no-fail)
    (ad-activate 'isearch-repeat)))
;; -- WINDMOVE --
(global-set-key (kbd "<up>")    'windmove-up)   ; This works good as an anti arrows, and it
(global-set-key (kbd "<down>")  'windmove-down) ; makes Emacs more productive
(global-set-key (kbd "<left>")  'windmove-left)
(global-set-key (kbd "<right>") 'windmove-right)

;; -- STRAIGHT.EL --
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
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; -- PACKAGES --
;; --- MU ---
(use-package mu4e
  :straight ( :host github
              :repo "djcb/mu"
              :branch "master"
              :files ("mu4e/*")
              :pre-build (("./autogen.sh") ("make")))
    )
;; --- VTERM ---
(use-package vterm)
;; --- LISPY ---
(use-package lispy)
;; --- EMBARK ---
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package embark
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))
;; --- PORTH-MODE ---
(straight-use-package '(porth-mode
                        :type git
                        :host gitlab
                        :repo "tsoding/porth"
                        :files ("editor/porth-mode.el")))
(require 'porth-mode)
;; --- SCROLL GOLDEN RATIO ---
(use-package golden-ratio-scroll-screen)
(global-set-key [remap scroll-down-command] 'golden-ratio-scroll-screen-down)
(global-set-key [remap scroll-up-command] 'golden-ratio-scroll-screen-up)
;; --- LUA ---
(use-package lua-mode)
;; --- SXHKD ---
(straight-use-package
 '(sxhkd-mode :type git :host github :repo "xFA25E/sxhkd-mode"))
;; --- MULTIPLE CURSORS ---
(use-package multiple-cursors
  :config
    (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
    (global-set-key (kbd "C->")         'mc/mark-next-like-this)
    (global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
    (global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
    (global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
    (global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this))
;; --- COLOR SCHEME ---
(use-package darktooth-theme
  :config
  (load-theme 'darktooth t)
  (darktooth-modeline))
;; --- IDO ---
(require 'ido)
(ido-mode t)
;; --- MAGIT ---
(use-package magit)
;; --- HASKELL ---
(use-package haskell-mode)
(use-package lsp-haskell)
(eval-after-load 'haskell-mode
          '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))
(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t))
(custom-set-variables '(haskell-process-type 'stack-ghci))
(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile))
(eval-after-load 'haskell-cabal
  '(define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile))
(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)))
(eval-after-load 'haskell-cabal '(progn
  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))
;; --- RUST ---
(use-package flycheck
  :hook (prog-mode . flycheck-mode))

(use-package company
  :hook (prog-mode . company-mode)
  :config (setq company-tooltip-align-annotations t)
          (setq company-minimum-prefix-length 1))

(use-package lsp-mode
  :commands lsp)

(use-package lsp-ui)
(use-package toml-mode)
(use-package rust-mode
  :hook (rust-mode . lsp))
;; Add keybindings for interacting with Cargo
(use-package cargo
  :hook (rust-mode . cargo-minor-mode))
(use-package flycheck-rust
  :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
;; --- DASHBOARD ---
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo)
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))))
;; --- UNDO TREE ---
(use-package undo-tree)
(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
;; --- IVY ---
(use-package ivy
  :init
  (ivy-mode)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  ;; enable this if you want `swiper' to use it
  ;; (setq search-default-mode #'char-fold-to-regexp)
  ;; (global-set-key "\C-s" 'swiper)
  ;; (global-set-key (kbd "C-c C-r") 'ivy-resume)
  ;; (global-set-key (kbd "<f6>") 'ivy-resume)
  )

;; --- COUNSEL ---
(use-package smex)
(use-package counsel :init (counsel-mode t))
;; --- HELPFUL ---
(use-package helpful
  :after counsel
  :bind
  (
   ("C-h v" . counsel-describe-variable)
   ("C-h f" . counsel-describe-function))
  :init
  (setq counsel-describe-function-function #'helpful-callable)
  (setq counsel-describe-variable-function #'helpful-variable))
;; --- STRIPES ---
(use-package stripes
  :config
  (setq stripes-unit 1))

;; -- TABS --
;; Create a variable for our preferred tab width
(setq custom-tab-width 4)
;; (global-set-key (kbd "TAB") 'insert-identation-with-len)
(defun insert-identation-with-len () (interactive) (insert (make-string custom-tab-width ? )))

;; Two callable functions for enabling/disabling tabs in Emacs
(defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

;; Hooks to Enable Tabs
(add-hook 'prog-mode-hook 'enable-tabs)
;; Hooks to Disable Tabs
(add-hook 'lisp-mode-hook 'disable-tabs)
(add-hook 'emacs-lisp-mode-hook 'disable-tabs)

;; Language-Specific Tweaks
(setq-default python-indent-offset custom-tab-width) ;; Python
(setq-default js-indent-level custom-tab-width)      ;; Javascript

;; Making electric-indent behave sanely
(setq-default electric-indent-inhibit t)

;; Make the backspace properly erase the tab instead of
;; removing 1 space at a time.
(setq backward-delete-char-untabify-method 'hungry)

;; (OPTIONAL) Shift width for evil-mode users
;; For the vim-like motions of ">>" and "<<".
(setq-default evil-shift-width custom-tab-width)

;; WARNING: This will change your life
;; (OPTIONAL) Visualize tabs as a pipe character - "|"
;; This will also show trailing characters as they are useful to spot.
(setq whitespace-style '(face tabs tab-mark trailing))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-tab ((t (:foreground "#636363")))))

;; -- LINE NUMBERS --
(global-display-line-numbers-mode t)
(use-package restart-emacs)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("a454e493a390a749e6cd1345adb72aaf977eae564473bf5578472dd486afc43f" default))
 '(display-line-numbers-type 'visual)
 '(golden-ratio-scroll-highlight-delay '(0.15 . 0.1))
 '(golden-ratio-scroll-highlight-flag nil)
 '(stripes-unit 1)
 '(sxhkd-mode-reload-config nil)
 '(vc-follow-symlinks t nil nil "Otherwise it's gonna ask you e-ver-y-sin-gle-time"))
(put 'dired-find-alternate-file 'disabled nil)
