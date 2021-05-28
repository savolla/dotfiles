;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Oleksiy Nehlyadyuk"
      user-mail-address "savolla@protonmail.com")

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
(setq org-directory "~/txt/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq select-enable-clipboard t) ;; enable system clipboard

;; vterm
(after! vterm
  (set-popup-rule! "*doom:vterm-popup"
    :size 0.15
    ;; :vslot -4
    :select t
    :quit nil))

; Org
(setq
 org-adapt-indentation t
 org-ellipsis "..."
 org-superstar-headline-bullets-list '("⚀" "⚁" "⚂" "⚃" "⚄" "⚅")
 org-hide-block-startup t)

;; Custom Key Bindings
;; custom keys '-'
(map! :leader :desc "custom keys"             "-") ;; custom bindings

;; code 'c'
(map! :leader :desc "code"                    "- c")
(map! :leader :desc "toggle tagbar"           "- c t" #'lsp-ui-imenu ) ;; toggle tagbar
(map! :leader :desc "toggle undo tree"        "- c u" #'undo-tree-visualize ) ;; toggle undo tree
(map! :leader :desc "run gdb"                 "- c g" #'gdb ) ;; run gdb
(map! :leader :desc "unfuck json"             "- c j" #'json-pretty-print-buffer ) ;; ranger

;; tabs 't'
(map! :leader :desc "tabs"                    "- t")
(map! :leader :desc "new tab"                 "- t o" #'tab-new ) ;; new tab
(map! :leader :desc "next tab"                "- t n" #'tab-next ) ;; next tab
(map! :leader :desc "kill tab"                "- t k" #'tab-kill ) ;; kill tab
(map! :leader :desc "previous tab"            "- t p" #'tab-previous ) ;; previous tab
(map! :leader :desc "list tabs"               "- t l" #'tab-list ) ;; list all tabs
(map! :leader :desc "toggle tabs"             "- t t" #'tab-bar-mode ) ;; toggle tab-bar-mode

;; utility 'u'
(map! :leader :desc "utility"                 "- u")
(map! :leader :desc "open pass"               "- u p" #'pass ) ;; passwords
(map! :leader :desc "irc"                     "- u i" #'irc ) ;; IRC
(map! :leader :desc "string sort"             "- u a" #'sort-lines ) ;; ranger
(map! :leader :desc "screenshot"              "- u s" #'org-screenshot-take)
(map! :leader :desc "babel tangle"            "- u t" #'org-babel-tangle)


;; org-roam
(map! :leader :desc "add tag"                 "a t a" #'org-roam-tag-add)
(map! :leader :desc "delete tag"              "a t d" #'org-roam-tag-delete)
(map! :leader :desc "insert link"             "a l "  #'org-roam-insert)
(map! :leader :desc "roam server"             "a s"   #'org-roam-server-mode)
(map! :leader :desc "roam find file"          "a f"   #'org-roam-find-file)

;; general
(map! :leader :desc "ranger"                  "o - " #'ranger ) ;; ranger

;; files
(map! :leader :desc "notitia"                 "- n w" #'open-notitia ) ;; open personal wiki
(map! :leader :desc "todo"                    "- n t" #'open-todo ) ;; open TODO file
(map! :leader :desc "neotree"                 "- f"   #'neotree) ;; open NERDTree :P

;; splash screen
(setq fancy-splash-image (concat doom-private-dir "splash.png")) ;; set custom splash
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu) ;; hide start menu
(defun doom-dashboard-widget-footer ())

;; transparency
(add-to-list 'default-frame-alist '(alpha . (90 . 92)))

;; themes
;; (setq doom-theme 'doom-one) ;; option 1
(setq doom-theme 'doom-gruvbox) ;; option 2
;; (setq doom-theme 'doom-outrun-electric) ;; option 3
;; (setq doom-theme 'doom-dracula) ;; option 4
;; (setq doom-theme 'doom-solarized-dark) ;; option 5

;; coding
(setq display-line-numbers-type nil)

;; font
;; FONT OPTION 1
;; (setq doom-font (font-spec :family "Input" :size 20)
;;       doom-variable-pitch-font (font-spec :family "Input" :size 20))

;; FONT OPTION 2
(setq doom-font (font-spec :family "Fira Code" :size 20)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 20))

;; plantuml
(setq plantuml-output-type "png" )

;; Treemacs
(after! treemacs
  (treemacs-follow-mode 1)
  (setq treemacs-width 30)
  (setq treemacs-position 'right))

;; Company
(after! company
  (remove-hook 'evil-normal-state-entry-hook #'company-abort)) ;; prevent mini blocks disappearence
(setq company-idle-delay 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; undo
(setq undo-limit 100 )
(setq evil-want-fine-undo t) ; undo more pleasant

;; window split options
(setq evil-vsplit-window-right t ;; automatic focus when splitted
      evil-split-window-below t) ;; automatic focus when splitted
(setq split-width-threshold 240)

;; workspace
(map! :leader :desc "next workspace"          "TAB l" #'+workspace:switch-next ) ;; workspace next
(map! :leader :desc "previous workspace"      "TAB h" #'+workspace:switch-previous ) ;; workspace previous
(setq +workspaces-on-switch-project-behavior t) ;; always open a new workspace when opening new project

;; rust
(setq
 racer-rust-src-path "/usr/bin")

;; org-roam
(setq org-roam-directory "~/txt/roam"
      org-roam-dailies-directory "~/txt/roam/daily"
      org-roam-db-update-method 'immediate)
(setq org-roam-capture-templates
      '(("f" "default" plain #'org-roam-capture--get-point (file "~/txt/roam/facts")
         :file-name "fact-%<%Y%m%d%H%M%S>"
         :head "#+TITLE: ${title}\n#+ROAM_TAGS: fact %^{org-roam-tags}\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n%?"
         :unnarrowed t
         :jump-to-captured t)

        ("c" "concept" plain #'org-roam-capture--get-point (file "~/txt/roam/concepts")
         :file-name "concept-%<%Y%m%d%H%M%S>"
         :head "#+TITLE: ${title}\n#+ROAM_TAGS: concept %^{org-roam-tags}\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n%?"
         :unnarrowed t
         :jump-to-captured t)

        ("l" "clipboard" plain #'org-roam-capture--get-point "%i%a"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+TITLE: ${title}\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n#+ROAM_TAGS: %? \n"
         :unnarrowed t
         :prepend t
         :jump-to-captured t)

        ("s" "sermon" plain #'org-roam-capture--get-point (file "~/org-roam/diary/sermon-template.txt")
         :file-name "%<%Y-%m-%d>_sermon_${slug}"
         :head "#+title: ${Title of the Message}\n#+ROAM_TAGS: Sermon\n#+DATE: %T\n#+VENUE: ${Venue}\n#+FORMAT: ${Format}\n#+STARTUP: showall\n#+DESCRIPTION: ${Main concept of service}\n#+OPTIONS: \\n:t\n"
         :unnarrowed t
         :immediate-finish t
         :jump-to-captured t)))
