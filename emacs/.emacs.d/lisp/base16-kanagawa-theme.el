;; base16-kanagawa-theme.el -- A base16 colorscheme

;;; Commentary:
;; Base16: (https://github.com/chriskempson/base16)

;;; Authors:
;; Scheme: Originally by rebelot (Ported by montdor [https://github.com/montdor/])
;; Template: Kaleb Elwert <belak@coded.io>

;;; Code:

(require 'base16-theme)

(defvar base16-kanagawa-colors
  '(:base00 "#1F1F28"
    :base01 "#2A2A37"
    :base02 "#223249"
    :base03 "#727169"
    :base04 "#C8C093"
    :base05 "#DCD7BA"
    :base06 "#938AA9"
    :base07 "#363646"
    :base08 "#C34043"
    :base09 "#FFA066"
    :base0A "#DCA561"
    :base0B "#98BB6C"
    :base0C "#7FB4CA"
    :base0D "#7E9CD8"
    :base0E "#957FB8"
    :base0F "#D27E99")
  "All colors for Base16 Kanagawa are defined here.")

;; Define the theme
(deftheme base16-kanagawa)

;; Add all the faces to the theme
(base16-theme-define 'base16-kanagawa base16-kanagawa-colors)

;; Mark the theme as provided
(provide-theme 'base16-kanagawa)

(provide 'base16-kanagawa-theme)

;;; base16-kanagawa-theme.el ends here
