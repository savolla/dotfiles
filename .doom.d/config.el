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
 org-id-link-to-org-use-id t ;; needed for org-roam
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
(map! :leader :desc "add tag"                 "a a"   #'org-roam-tag-add)
(map! :leader :desc "insert link"             "a i"   #'org-roam-insert)
(map! :leader :desc "roam server"             "a s"   #'org-roam-server-mode)
(map! :leader :desc "roam find file"          "a f"   #'org-roam-find-file)
(map! :leader :desc "backlinks"               "a b"   #'org-roam-buffer-toggle-display)
(map! :leader :desc "capture"                 "a c"   #'org-roam-capture)

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
(after! org-roam-capture
  (set-popup-rule! "CAPTURE-*"
    :size 0.9
    ;; :vslot -4
    :select t
    :quit nil))
(setq org-roam-directory "~/txt/roam"
      org-roam-dailies-directory "~/txt/roam/daily"
      org-roam-completion-ignore-case t
      org-roam-enable-headline-linking t
      org-roam-index-file "index.org"
      )
(setq org-roam-capture-templates
      '(
        (
         "f" "fact" plain #'org-roam-capture--get-point
         :file-name "%<%Y%m%d%H%M%S>-fact"
         :head "#+TITLE: ${title}\n#+ROAM_TAGS: fact %?\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n- source :: ${source}\n\n"
         :unnarrowed t
         :jump-to-captured t
        )
        (
         "d" "daily" plain #'org-roam-capture--get-point
         :file-name "daily/%<%Y%m%d%H%M%S>-daily"
         :head "#+TITLE: %<%Y%m%d%H%M%S>-daily\n#+ROAM_TAGS: daily\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n- source ::\n\n%?"
         :unnarrowed t
        )
        (
         "t" "tip" plain #'org-roam-capture--get-point
         :file-name "%<%Y%m%d%H%M%S>-tip"
         :head "#+TITLE: ${title}\n#+ROAM_TAGS: fact %?\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n- source ::\n\n#+begin_quote\n\n#+end_quote"
         :unnarrowed t
        )
        (
         "c" "concept" plain #'org-roam-capture--get-point
         :file-name "${title}"
         :head "#+TITLE: ${title}\n#+ROAM_TAGS: concept\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n- source :: ${source}\n\n* what is it?\n%?\n* why is important?\n* when to use?\n* how to use?\n"
         :unnarrowed t
        )
        (
         "p" "person" plain #'org-roam-capture--get-point
         :file-name "person/${title}"
         :head "#+TITLE: ${title}\n#+ROAM_TAGS: person\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n- source :: ${source}\n\n* who is it?\n%?\n*contact information\n"
         :unnarrowed t
        )
        ;; (
        ;;  "s" "snippet" plain #'org-roam-capture--get-point
        ;;  :file-name "snippet-%<%Y%m%d%H%M%S>"
        ;;  :head "#+TITLE: ${title}\n#+ROAM_TAGS: ${language} snippet howto\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n- source :: ${source}\n\n#+begin_src ${language}\n%?\n#+end_src"
        ;;  :unnarrowed t
        ;;  :jump-to-captured t
        ;; )
        ;; (
        ;;  "Q" "quote" plain #'org-roam-capture--get-point
        ;;  :file-name "concept-%<%Y%m%d%H%M%S>"
        ;;  :head "#+TITLE: ${title}\n#+ROAM_TAGS: quote %^{tags}\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n- source :: ${source}\n\n#+begin_quote\n%?\n#+end_quote"
        ;;  :unnarrowed t
        ;;  :jump-to-captured t
        ;; )
        ;; (
        ;;  "h" "howto" plain #'org-roam-capture--get-point
        ;;  :file-name "howto-%<%Y%m%d%H%M%S>"
        ;;  :head "#+TITLE: ${title}\n#+ROAM_TAGS: howto %^{tags}\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n- source :: ${source}\n\n#+begin_quote\n%?\n#+end_quote"
        ;;  :unnarrowed t
        ;;  :jump-to-captured t
        ;; )
       )
      )
