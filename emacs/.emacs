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
(column-number-mode 1)
(set-frame-font "Jetbrains Mono")
(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil)
(setq indicate-empty-lines t
      indicate-buffer-boundaries 'left)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

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
;; --- COLOR SCHEME ---
(straight-use-package
 '(nano-emacs :type git :host github :repo "rougier/nano-emacs"))
(use-package mini-frame)
(setq nano-font-size 10)
(require 'nano-theme-dark)
(require 'nano-base-colors)
(require 'nano-faces)
(nano-faces)
(require 'nano-theme)
(nano-theme)
(require 'nano-modeline)
(nano-modeline)
(require 'nano-help)
(global-unset-key (kbd "M-h"))
(require 'nano-defaults)
(menu-bar-mode 0)
(tool-bar-mode 0)
(blink-cursor-mode 0)
;; --- IDO ---
(require 'ido)
(ido-mode t)
;; --- RUST ---
(use-package rust-mode)
;; --- DASHBOARD ---
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo)
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))))
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
(use-package smex
  :init (global-set-key (kbd "M-x") 'smex))
;; (use-package counsel
;;   :init
;;   (counsel-mode)
;;   )
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
 '(whitespace-tab ((t (:foreground "#636363")))))
(setq whitespace-display-mappings
      '((tab-mark 9 [124 9] [92 9]))) ; 124 is the ascii ID for '\|'
(global-whitespace-mode) ; Enable whitespace mode everywhere

;; -- LINE NUMBERS --
(global-linum-mode t)
(require 'linum)
(add-hook 'prog-mode-hook 'linum-mode)
(defvar my-linum-format-string "%3d")

(add-hook 'linum-before-numbering-hook 'my-linum-get-format-string)

(defun my-linum-get-format-string ()
  (let* ((width (1+ (length (number-to-string
                             (count-lines (point-min) (point-max))))))
         (format (concat "%d (%" (number-to-string width) "d)")))
    (setq my-linum-format-string format)))

(defvar my-linum-current-line-number 0)

(setq linum-format 'my-linum-relative-line-numbers)

(defun my-linum-relative-line-numbers (line-number)
  (let ((offset (- line-number my-linum-current-line-number))
        (current (line-number-at-pos)))
    (propertize (format my-linum-format-string current offset) 'face 'linum)))

(defadvice linum-update (around my-linum-update)
  (let ((my-linum-current-line-number (line-number-at-pos)))
    ad-do-it))
(ad-activate 'linum-update)
