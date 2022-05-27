(setq inhibit-compacting-font-caches t)
(setq gc-cons-threshold 100000000)
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 800000)))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(global-auto-revert-mode)

(setq straight-use-package-by-default t)
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

(set-face-attribute 'default nil :font "FiraCode Nerd Font" :height 143 :foundry "CTDB")

(straight-use-package 'use-package)
;; Use package alias
(defun use-p ()
    (interactive)
    (call-interactively 'straight-use-package)
  )

;; Theme
(fringe-mode 10)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(add-hook 'fundamental-mode-hook 'hl-line-mode)
(add-hook 'prog-mode-hook 'hl-line-mode)

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-tokyo-night t)

  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (setq doom-themes-treemacs-theme "doom-atom")
  (doom-themes-treemacs-config)
  (doom-themes-org-config))
(when window-system
  (use-package fira-code-mode
    :custom (fira-code-mode-disabled-ligatures '("#{" "#(" "#_" "#_("))
    :hook prog-mode)
  (let* ((variable-tuple
	  (cond 
	   ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
	   ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
	   ((x-list-fonts "Verdana")         '(:font "Verdana"))
	   ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
	   (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
	 )

    `(set-face-attribute 'org-level-8 nil ,@variable-tuple :weight "bold")
    `(set-face-attribute 'org-level-7 nil ,@variable-tuple :weight "bold")
    `(set-face-attribute 'org-level-6 nil ,@variable-tuple :weight "bold")
    `(set-face-attribute 'org-level-5 nil ,@variable-tuple :weight "bold")
    `(set-face-attribute 'org-level-4 nil ,@variable-tuple :weight "bold" :height 1.1)
    `(set-face-attribute 'org-level-3 nil ,@variable-tuple :weight "bold" :height 1.15)
    `(set-face-attribute 'org-level-2 nil ,@variable-tuple :weight "bold" :height 1.2)
    `(set-face-attribute 'org-level-1 nil ,@variable-tuple :weight "bold" :height 1.25)
    `(set-face-attribute 'org-document-title nil ,@variable-tuple :height 1.2 :underline t)
    )

  (custom-theme-set-faces
   'user
   '(variable-pitch ((t (:family "Source Sans Pro" :height 150 :weight thin))))
   '(fixed-pitch ((t ( :family "Fira Code Retina" :height 140)))))
  )

;; Get vimmy
(setq evil-want-keybinding nil)
(use-package undo-tree)
(setq undo-tree-auto-save-history t)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
(global-undo-tree-mode t)
(setq evil-undo-system 'undo-tree)
(use-package evil)
(use-package evil-collection)
(evil-collection-init)
(use-package evil-indent-plus)
(setq evil-want-C-g-bindings t)
(evil-mode 1)
;; Folds
(use-package vimish-fold
  :ensure
  :after evil)

(use-package evil-vimish-fold
  :ensure
  :after vimish-fold
  :hook ((prog-mode conf-mode text-mode org-mode) . evil-vimish-fold-mode))

;; Line numbers
(use-package nlinum-relative)
(nlinum-relative-setup-evil)
(add-hook 'prog-mode-hook 'nlinum-relative-mode)
(setq nlinum-relative-redisplay-delay 0)
(setq nlinum-relative-current-symbol "")
(setq nlinum-relative-offset 0)
(global-nlinum-relative-mode)

;; COMMIT IT
(use-package magit
  :bind (("C-c g" . magit-status)))

;; LISP
(use-package lispy)
(add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))

;; Tree sitter = free color schemes
(use-package tree-sitter
  :hook ((rust-mode . tree-sitter-hl-mode))
  )
(use-package tree-sitter-langs)
(global-tree-sitter-mode)

;; Rust
(use-package rust-mode)
(straight-use-package 'company-mode)
(global-company-mode t)
(use-package flycheck)
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-l")
  :hook ((rust-mode . lsp) (lua-mode . lsp))
  :commands lsp)

;; Lua
(use-package lua-mode)

;; Which key
(use-package which-key)
(which-key-mode t)

;; Fuzzy
(use-package selectrum)
(selectrum-mode +1)

(straight-use-package 'prescient)
(straight-use-package 'company-prescient)
(straight-use-package 'selectrum-prescient)
(company-prescient-mode)
(selectrum-prescient-mode)
(prescient-persist-mode)
(use-package marginalia
  :config
  (marginalia-mode))

(use-package embark
  :bind
  (("C-," . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings))
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))
(use-package counsel)
(setq counsel-fzf-cmd "fd --type f | fzf -f \"%s\"")
(global-set-key (kbd "C-x f") 'counsel-fzf)

;; ORG MODE
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-hide-emphasis-markers t)
(use-package org-bullets
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
(font-lock-add-keywords 'org-mode
			'(("^ *\\([-]\\) "
			   (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (custom-theme-set-faces
   'user
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-document-info ((t (:foreground "dark orange"))))
   '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
   '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
   '(org-link ((t (:foreground "royal blue" :underline t))))
   '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-property-value ((t (:inherit fixed-pitch))) t)
   '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
   '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
   '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))


(add-hook 'org-mode-hook 'variable-pitch-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

(setq org-startup-indented t
      org-bullets-bullet-list '("*")
      org-ellipsis "  " ;; folding symbol
      org-pretty-entities t
      org-hide-emphasis-markers t
      ;; show actually italicized text instead of /italicized text/
      org-agenda-block-separator ""
      org-fontify-whole-heading-line t
      org-fontify-done-headline t
      org-fontify-quote-and-verse-blocks t
      org-cycle-separator-lines -1
      org-startup-folded t)

(defun org-table-transform-in-place ()
  "Just like `ORG-TABLE-EXPORT', but instead of exporting to a
  file, replace table with data formatted according to user's
  choice, where the format choices are the same as
  org-table-export."
  (interactive)
  (unless (org-at-table-p) (user-error "No table at point"))
  (org-table-align)
  (let* ((format
      (completing-read "Transform table function: "
               '("orgtbl-to-tsv" "orgtbl-to-csv" "orgtbl-to-latex"
                 "orgtbl-to-html" "orgtbl-to-generic"
                 "orgtbl-to-texinfo" "orgtbl-to-orgtbl"
                 "orgtbl-to-unicode")))
     (curr-point (point)))
    (if (string-match "\\([^ \t\r\n]+\\)\\( +.*\\)?" format)
    (let ((transform (intern (match-string 1 format)))
          (params (and (match-end 2)
               (read (concat "(" (match-string 2 format) ")"))))
          (table (org-table-to-lisp
              (buffer-substring-no-properties
               (org-table-begin) (org-table-end)))))
      (unless (fboundp transform)
        (user-error "No such transformation function %s" transform))
      (save-restriction
        (with-output-to-string
          (delete-region (org-table-begin) (org-table-end))
          (insert (funcall transform table params) "\n")))
      (goto-char curr-point)
      (beginning-of-line)
      (message "Tranformation done."))
      (user-error "Table export format invalid"))))

(define-key org-mode-map (kbd "\C-x |") 'org-table-transform-in-place)

;; (setq org-super-agenda-groups
;;        '(;; Each group has an implicit boolean OR operator between its selectors.
;;          (:name "Today"  ; Optionally specify section name
;;                 :time-grid t  ; Items that appear on the time grid
;;                 :todo "TODAY")  ; Items that have this TODO keyword
;;          (:name "Important"
;;                 :priority "A")
;;          (:name "Deadlines"
;;                 :auto-group t
;;                 :deadline t)
;;          ))

;; (let ((org-super-agenda-groups
;;        '((:auto-group t))))
;;   (org-agenda-list))

;; KUTLIN
(use-package kotlin-mode)

(put 'dired-find-alternate-file 'disabled nil)
(setq vc-follow-symlinks t)
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")

(use-package restart-emacs)

