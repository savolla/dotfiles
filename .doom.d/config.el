;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Personal Info
(setq user-full-name "Oleksiy Nehlyadyuk"
      user-mail-address "savolla@protonmail.com")


;; Font Configuration
(setq doom-font (font-spec :family "Fira Code" :size 18)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 19))


;; Transparency Configuration
(add-to-list 'default-frame-alist '(alpha . (90 . 92)))


;; Theme Configuration
;; (setq doom-theme 'doom-one) ;; option 1
;; (setq doom-theme 'doom-gruvbox) ;; option 2
;; (setq doom-theme 'doom-outrun-electric) ;; option 3
;; (setq doom-theme 'doom-dracula) ;; option 4
;; (setq doom-theme 'doom-solarized-dark) ;; option 5
;; (setq doom-theme 'doom-badger) ;; option 6
;; (setq doom-theme 'doom-acario-dark) ;; option 7
(setq doom-theme 'doom-tomorrow-night) ;; option 8


;; vterm Configuration
(after! vterm
  (set-popup-rule! "*doom:vterm-popup"
    :size 0.15
    ;; :vslot -4
    :select t
    :quit nil))


; Org configuration
(setq
 org-adapt-indentation t
 org-directory "~/org/"
 org-ellipsis "..."
 org-superstar-headline-bullets-list '("⚀" "⚁" "⚂" "⚃" "⚄" "⚅")
 ;; org-id-link-to-org-use-id t ;; needed for org-roam
 org-hide-block-startup t)


;; Treemacs Configuration
(after! treemacs
  (treemacs-follow-mode 1)
  (setq treemacs-width 30)
  (setq treemacs-position 'right))


;; Company Configuration
(after! company
  (remove-hook 'evil-normal-state-entry-hook #'company-abort)) ;; prevent mini blocks disappearence
(setq company-idle-delay 0)


;; Window Split Configuration
(setq evil-vsplit-window-right t ;; automatic focus when splitted
      evil-split-window-below t) ;; automatic focus when splitted
(setq split-width-threshold 240)


;; Workspace Configuration
(map! :leader :desc "next workspace"          "TAB l" #'+workspace:switch-next ) ;; workspace next
(map! :leader :desc "previous workspace"      "TAB h" #'+workspace:switch-previous ) ;; workspace previous
(setq +workspaces-on-switch-project-behavior t) ;; always open a new workspace when opening new project


;; Splash Screen Configuraion
;; (setq fancy-splash-image (concat doom-private-dir "splash.png")) ;; set custom splash
(setq fancy-splash-image (concat doom-private-dir "gravatar-savolla.png")) ;; set custom splash
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu) ;; hide start menu
(defun doom-dashboard-widget-footer ())


;; plantuml Configuraion
(setq plantuml-output-type "png" )


;; Custom Key Bindings
;; custom keys '-'
(map! :leader :desc "custom keys"             "-") ;; custom bindings

;; code 'c'
(map! :leader :desc "code"                    "- c")
(map! :leader :desc "toggle tagbar"           "- c t" #'lsp-ui-imenu ) ;; toggle tagbar
(map! :leader :desc "toggle undo tree"        "- c u" #'undo-tree-visualize ) ;; toggle undo tree
(map! :leader :desc "run gdb"                 "- c g" #'gdb ) ;; run gdb
(map! :leader :desc "unfuck json"             "- c j" #'json-pretty-print-buffer ) ;; ranger
;; TODO: create Python specific shortcuts

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


;; disable cl is deprecated warning. TODO: delete this soon
(setq byte-compile-warnings '(cl-functions))


;; Enable ccls for all c++ files, and platformio-mode only
;; when needed (platformio.ini present in project root).
(add-hook 'c++-mode-hook (lambda ()
                           (lsp-deferred)
                           (platformio-conditionally-enable)))
