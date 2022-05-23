;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-



;; Personal Info
(setq user-full-name "Oleksiy Nehlyadyuk"
      user-mail-address "savolla@protonmail.com")


;; Font Configuration
(setq doom-font (font-spec :family "Fira Code" :size 20)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 20))


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
;; (setq doom-theme 'doom-tomorrow-night) ;; option 8
;; (setq doom-theme 'doom-oceanic-next) ;; option 9
(setq doom-theme 'doom-old-hope) ;; option 10


;; vterm Configuration
(after! vterm
  (set-popup-rule! "*doom:vterm-popup"
    :size 0.15
    ;; :vslot -4
    :select t
    :quit nil))

; Hugo configuration
(setq org-hugo-base-dir "~/project/org/hugo-md" )

; Org configuration
(setq
 org-adapt-indentation t
 ;; org-directory "~/project/notitia"
 org-ellipsis "..."
 ;; org-superstar-headline-bullets-list '("⚀" "⚁" "⚂" "⚃" "⚄" "⚅")
 ;; org-id-link-to-org-use-id t ;; needed for org-roam
 org-startup-with-inline-images t
 org-startup-with-latex-preview t
 org-directory "~/project/org"
 )

;; roam configuration

(setq
 org-roam-directory "~/project/braindump"
 org-roam-completion-everywhere t
 org-roam-capture-templates
 '(
   ("d" "default" plain
   "%?"
   :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
   :unnarrowed t)

   ("x" "fix" plain
   "%?"
   :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: :fix:")
   :unnarrowed t)

   ("b" "book" plain
   "%?"
   :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: :book:\n* fact\n* tip\n* howto\n* concept\n* snippet\n* listof")
   :unnarrowed t)

   ("h" "how to" plain
   "%?"
   :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: :how_to:")
   :unnarrowed t)

   ("o" "who" plain
   "%?"
   :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: :who_is:")
   :unnarrowed t)

   ("w" "what is" plain
   "%?"
   :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: :what_is:\n* fact\n* tip\n* howto\n* concept\n* snippet\n* listof")
   :unnarrowed t)))

;; Treemacs Configuration
(after! treemacs
  (treemacs-follow-mode 1)
  (setq treemacs-width 30)
  (setq treemacs-position 'right))

;; Deft Configuration
(setq deft-directory "~/project/braindump"
      deft-extensions '("org")
      deft-recursive t)

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
;; (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu) ;; hide start menu
(defun doom-dashboard-widget-footer ())


;; plantuml Configuraion
(setq plantuml-output-type "png" )
(setq org-plantuml-jar-path "~/resource/bin/plantuml-1.2022.5.jar" )

;; Custom Key Bindings
;; custom keys '-'
(map! :leader :desc "savolla"             "d") ;; custom bindings

;; code 'c'
(map! :leader :desc "code"                    "d c")
(map! :leader :desc "toggle tagbar"           "d c t" #'lsp-ui-imenu ) ;; toggle tagbar
(map! :leader :desc "toggle undo tree"        "d c u" #'undo-tree-visualize ) ;; toggle undo tree
(map! :leader :desc "run gdb"                 "d c g" #'gdb ) ;; run gdb
(map! :leader :desc "unfuck json"             "d c j" #'json-pretty-print-buffer ) ;; ranger
;; TODO: create Python specific shortcuts

;; tabs 't'
(map! :leader :desc "tabs"                    "d t")
(map! :leader :desc "new tab"                 "d t o" #'tab-new ) ;; new tab
(map! :leader :desc "next tab"                "d t n" #'tab-next ) ;; next tab
(map! :leader :desc "kill tab"                "d t k" #'tab-kill ) ;; kill tab
(map! :leader :desc "previous tab"            "d t p" #'tab-previous ) ;; previous tab
(map! :leader :desc "list tabs"               "d t l" #'tab-list ) ;; list all tabs
(map! :leader :desc "toggle tabs"             "d t t" #'tab-bar-mode ) ;; toggle tab-bar-mode

;; utility 'u'
(map! :leader :desc "utility"                 "d u")
(map! :leader :desc "open pass"               "d u p" #'pass ) ;; passwords
(map! :leader :desc "irc"                     "d u i" #'irc ) ;; IRC
(map! :leader :desc "string sort"             "d u a" #'sort-lines ) ;; ranger
(map! :leader :desc "screenshot"              "d u s" #'org-screenshot-take)
(map! :leader :desc "babel tangle"            "d u t" #'org-babel-tangle)

;; disable cl is deprecated warning. TODO: delete this soon
(setq byte-compile-warnings '(cl-functions))


;; Enable ccls for all c++ files, and platformio-mode only
;; when needed (platformio.ini present in project root).
(add-hook 'c++-mode-hook (lambda ()
                           (lsp-deferred)))

;; org-noter configuration
(setq org-noter-auto-save-last-location t)


;; run commands on startup
;; (+workspace-rename "agenda")
(defun startup-script ()
  "savolla's personal script"
  (find-file "~/org/todo.org")
  (evil-window-split)
  (find-file "~/org/journal.org")
  ;; (+workspace:new)
  )

;; (startup-script)
