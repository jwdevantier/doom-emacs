;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
(setq projectile-project-search-path '("~/repos" "~/repos/personal/haskell" "~/repos/github" "~/repos/github/api" "~/repos/gitlab" "~/repos/personal"))


;; means META-, opens localleader in INSERT mode
(setq doom-localleader-alt-key "M-,")

(map! (:localleader
          (:map (clojure-mode-map clojurescript-mode-map)
           (:prefix ("s" . "slurp")
              "l" #'sp-forward-slurp-sexp
              "h" #'sp-backward-slurp-sexp)
           (:prefix ("b" . "barf")
              "l" #'sp-forward-barf-sexp
              "h" #'sp-backward-barf-sexp))))

;; Dap-mode (debug application protocol)
;; -------------------------------------
;; Trying to follow https://medium.com/@apmattil/debug-go-golang-with-emacs-fbf840c0aa56
;; 1) install 'dap-mode' emacs package
;; (enable dap-mode for go-mode)
;;
;; VSCode Go Extension - do not install manually, if missing, *Messages* will
;; contain a message instructing you to M-x dap-go-setup
;; (Restart)

(defun xx-go-mode-extras ()
  "tweak go mode"

  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (dap-mode +1)
  (require 'dap-go)
  (dap-ui-mode 1)
  (map! (:localleader
         (:map (go-mode-map)
          (:prefix ("x" . "debug")
           "s" #'dap-debug
           "u" #'dap-hydra)))))

(add-hook 'go-mode-hook 'xx-go-mode-extras)
