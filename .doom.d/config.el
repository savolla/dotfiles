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

;; org-roam
(add-hook 'after-init-hook 'org-roam-mode)
(after! org-roam-capture
  (set-popup-rule! "CAPTURE-*"
    :size 0.5
    ;; :vslot -4
    :select t
    :quit nil))
(setq org-roam-directory "~/txt/roam"
      ;; org-roam-directory "~/txt/zattel"
      ;; org-roam-directory "~/txt/jethros-braindump"
      org-roam-dailies-directory "~/txt/roam/fleeting"
      ;; org-roam-index-file "index.org"
      )

(setq org-roam-capture-templates
      '(
        ;; -----------------------------------------------------Note Types---------------------------------------------------------------------
        (
         "f" "fleeting" plain #'org-roam-capture--get-point
         :file-name "%<%Y%m%d%H%M%S>-fleeting"
         :head "# Copy before turning into literature note\n#+TITLE: %<%Y%m%d%H%M%S>-fleeting\n#+STARTUP: overview latexpreview inlineimages\n#+ROAM_TAGS: fleeting \n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n%?\n\n- references ::\n"
         :unnarrowed t
         )
        (
         "l" "literature" plain #'org-roam-capture--get-point
         :file-name "%<%Y%m%d%H%M%S>-literature"
         :head "# Literature = Expanded version of the Fleeting Note\n#Extra tags; argument, tip, howto, story, study, chart, people, event, place\n%x"
         :unnarrowed t
         )
        (
         "p" "permanent" plain #'org-roam-capture--get-point
         :file-name "%<%Y%m%d%H%M%S>-permanent-${slug}"
         :head "# Title must come at the end\n#+TITLE: ${title}\n#+STARTUP: overview\n#+ROAM_TAGS: permanent\n#+CREATED: %u\n#+LAST_MODIFIED:\n\n# You can link multiple Concepts and Permanent Notes!\n%?\n\n- see also ::\n#Continuation or Related notes here\n\n- references ::\n\n# Find tags by asking;\n1) Topic tag: What are related words to this note?\nContext tag: What is the main idea of this note?"
         :unnarrowed t
         )
        ;; -------------------------------------------------------------------------------------------------------------------------------------




        ;; -----------------------------------------------------Note Connection Methods---------------------------------------------------------
        (
         "k" "keyword" plain #'org-roam-capture--get-point
         :file-name "%<%Y%m%d%H%M%S>-keyword-${slug}"
         :head "#+TITLE: ${title}\n#+STARTUP: overview\n#+ROAM_TAGS: keyword\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n[[roam:${title}]]\n"
         :unnarrowed t
         )
        (
         "i" "index" plain #'org-roam-capture--get-point
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+TITLE: ${title}\n#+STARTUP: overview\n#+ROAM_TAGS: index\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n%?\n"
         :unnarrowed t
         )
        (
         "b" "bridge" plain #'org-roam-capture--get-point
         :file-name "%<%Y%m%d%H%M%S>-bridge-${slug}"
         :head "#+TITLE: \n#+STARTUP: overview\n#+ROAM_TAGS: bridge\n#+CREATED: %u\n#+LAST_MODIFIED:\n%?\n\n- see also ::\n#Continuation or Related notes here\n\n- references ::\n"
         :unnarrowed t
         )
         ;; -------------------------------------------------------------------------------------------------------------------------------------





        ;; -----------------------------------------------------Note Connection Methods---------------------------------------------------------
        (
         "m" "melody" plain #'org-roam-capture--get-point
         :file-name "%<%Y%m%d%H%M%S>-melody-${riff|lick:}"
         :head "#+TITLE: %<%Y%m%d%H%M%S>-${riff|lick:}\n#+STARTUP: overview latexpreview inlineimages\n#+ROAM_TAGS: melody permanent ${riff|lick:}\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n1 |----.----.----.----|----.----.----.----|----.----.----.----|----.----.----.----|\n2 |----.----.----.----|----.----.----.----|----.----.----.----|----.----.----.----|\n3 |----.----.----.----|----.----.----.----|----.----.----.----|----.----.----.----|\n4 |----.----.----.----|----.----.----.----|----.----.----.----|----.----.----.----|\n5 |----.----.----.----|----.----.----.----|----.----.----.----|----.----.----.----|\n6 |----.----.----.----|----.----.----.----|----.----.----.----|----.----.----.----|\n7 |----.----.----.----|----.----.----.----|----.----.----.----|----.----.----.----|\n\n+ [[roam:Melody]]"

         :unnarrowed t
         )
        (
         "c" "concept" plain #'org-roam-capture--get-point
         :file-name "%<%Y%m%d%H%M%S>-concept-${slug}"
         :head "#+TITLE: ${title}\n#+STARTUP: overview latexpreview inlineimages\n#+ROAM_TAGS: concept permanent\n#+ROAM_ALIAS: \"${title}\" \"what is ${title}\" \"what ${title} is\"\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n%?\n\n- see also ::\n# + \[\[roam:why is ${title} important\]\]\n# + \[\[roam:when to use ${title}\]\]\n# + \[\[roam:how to use ${title}\]\]\n# + \[\[roam:examples of ${title}\]\]\n# + \[\[roam:founder of ${title}\]\]\n+ [[roam:Concept]]\n\n- references ::\n"
         :unnarrowed t
         )
        (
         "q" "quote" plain #'org-roam-capture--get-point
         :file-name "%<%Y%m%d%H%M%S>-quote"
         :head "#+TITLE: %<%Y%m%d%H%M%S>-quote\n#+STARTUP: overview latexpreview\n#+ROAM_TAGS: quote permanent\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n#+begin_quote%? - #+end_quote\n\n- see also ::\n[[roam:Quotes]]\n\n- references ::\n"
         :unnarrowed t
         )
        (
        ;; (
        ;;  "a" "claim" plain #'org-roam-capture--get-point
        ;;  :file-name "%<%Y%m%d%H%M%S>-claim"
        ;;  :head "#+TITLE: ${title}\n#+STARTUP: overview\n#+ROAM_TAGS: claim\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n%?\n\n* Resources\n+ "
        ;;  :unnarrowed t
        ;;  )
        ;; (
        ;;  "m" "moc" plain #'org-roam-capture--get-point
        ;;  :file-name "%<%Y%m%d%H%M%S>-moc"
        ;;  :head "#+TITLE: ${title}\n#+STARTUP: overview\n#+ROAM_TAGS: moc\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n%?"
        ;;  :unnarrowed t
        ;;  )
        ;; (
        ;;  "h" "howto" plain #'org-roam-capture--get-point
        ;;  :file-name "%<%Y%m%d%H%M%S>-howto"
        ;;  :head "#+TITLE: ${title}\n#+STARTUP: showeverything\n#+ROAM_TAGS: howto\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n%?"
        ;;  :unnarrowed t
        ;;  )
        ;; (
        ;;  "b" "book" plain #'org-roam-capture--get-point
        ;;  :file-name "%<%Y%m%d%H%M%S>-book"
        ;;  :head "#+TITLE: ${title}\n#+AUTHOR: %?\n#+STARTUP: overview inlineimages\n#+ROAM_TAGS: book\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n* note\n* concept\n* claim\n* anecdote\n** story\n** stat\n** study\n** chart\n* name\n** place\n** people\n** event\n** date\n* tip\n* howto"
        ;;  :unnarrowed t
        ;;  )
        ;;

        ;; (
        ;;  "a" "argument-fleeting" plain #'org-roam-capture--get-point
        ;;  :file-name "fleeting/%<%Y%m%d%H%M%S>-fleeting-argument"
        ;;  :head "#+TITLE: %<%Y%m%d%H%M%S>-fleeting\n#+STARTUP: overview latexpreview inlineimages\n#+ROAM_TAGS: fleeting argument\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n-P%? :: \n\n- references ::\n"
        ;;  :unnarrowed t
        ;;  )
        ;; (
        ;;  "v" "video-fleeting" plain #'org-roam-capture--get-point
        ;;  :file-name "fleeting/%<%Y%m%d%H%M%S>-fleeting-video"
        ;;  :head "#+TITLE: %<%Y%m%d%H%M%S>-fleeting\n#+STARTUP: overview latexpreview inlineimages\n#+ROAM_TAGS: fleeting video\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n-P%?\n\n- references ::\n%x"
        ;;  :unnarrowed t
        ;;  )
        ;; (
        ;;  "p" "podcast-fleeting" plain #'org-roam-capture--get-point
        ;;  :file-name "fleeting/%<%Y%m%d%H%M%S>-fleeting-podcast"
        ;;  :head "#+TITLE: %<%Y%m%d%H%M%S>-fleeting\n#+STARTUP: overview latexpreview inlineimages\n#+ROAM_TAGS: fleeting podcast\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n-P%?\n\n- references ::\n"
        ;;  :unnarrowed t
        ;;  )
        ;; (
        ;;  "a" "article-fleeting" plain #'org-roam-capture--get-point
        ;;  :file-name "fleeting/%<%Y%m%d%H%M%S>-fleeting-article"
        ;;  :head "#+TITLE: %<%Y%m%d%H%M%S>-fleeting\n#+STARTUP: overview latexpreview inlineimages\n#+ROAM_TAGS: fleeting article\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n-P%?\n\n- references ::\n%x"
        ;;  :unnarrowed t
        ;;  )
        ;; (
        ;;  "w" "walking-fleeting" plain #'org-roam-capture--get-point
        ;;  :file-name "fleeting/%<%Y%m%d%H%M%S>-fleeting-walking"
        ;;  :head "#+TITLE: %<%Y%m%d%H%M%S>-fleeting\n#+STARTUP: overview latexpreview inlineimages\n#+ROAM_TAGS: fleeting walking\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n-P%?\n\n- references ::\n%x"
        ;;  :unnarrowed t
        ;;  )


        ;; Info Types
        ;; (
        ;;  "P" "person" plain #'org-roam-capture--get-point
        ;;  :file-name "%<%Y%m%d%H%M%S>-${slug}"
        ;;  :head "#+TITLE: ${title}\n#+STARTUP: overview latexpreview inlineimages\n#+ROAM_TAGS: person permanent name ${source(B,V,A,P,I): }\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n%?\n- website   ::\t\n- social    ::\n- mail      ::\n\n- references ::\n"
        ;;  :unnarrowed t
        ;;  )
        ;; (
        ;;  "H" "howto" plain #'org-roam-capture--get-point
        ;;  :file-name "%<%Y%m%d%H%M%S>-howto"
        ;;  :head "#+TITLE:\n#+STARTUP: overview latexpreview inlineimages\n#+ROAM_TAGS: howto permanent ${source(B,V,A,P,I): }\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n- website   ::\t\n- blog      ::\t\n- social    ::\t\n- lives     ::\n- phone     ::\n- mail      ::\n- reference ::\n\n* Who Is ${title}?\n%?\n"
        ;;  :unnarrowed t
        ;;  )
        ;; (
        ;;  "T" "tip" plain #'org-roam-capture--get-point
        ;;  :file-name "%<%Y%m%d%H%M%S>-tip"
        ;;  :head "#+TITLE:\n#+STARTUP: overview latexpreview inlineimages\n#+ROAM_TAGS: tip permanent\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n%?\n\n- references ::\n"
        ;;  :unnarrowed t
        ;;  )
        ;; (
        ;;  "N" "name" plain #'org-roam-capture--get-point
        ;;  :file-name "%<%Y%m%d%H%M%S>-${place|event:}"
        ;;  :head "#+TITLE: ${title}\n#+STARTUP: overview latexpreview inlineimages\n#+ROAM_TAGS: ${place|event:} permanent name\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n%?\n\n- references ::\n"
        ;;  :unnarrowed t
        ;;  )
        ;; (
        ;;  "E" "evidence" plain #'org-roam-capture--get-point
        ;;  :file-name "%<%Y%m%d%H%M%S>-${chart|study|story:}"
        ;;  :head "#+TITLE: ${title}\n#+STARTUP: overview latexpreview inlineimages\n#+ROAM_TAGS: ${chart|study|story:} permanent evidence\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n%?\n\n- references ::\n"
        ;;  :unnarrowed t
        ;;  )
        ;; (
        ;;  "A" "argument" plain #'org-roam-capture--get-point
        ;;  :file-name "%<%Y%m%d%H%M%S>-argument"
        ;;  :head "#+TITLE: ${title}\n#+STARTUP: overview latexpreview inlineimages\n#+ROAM_TAGS: ${chart|study|story:} permanent evidence\n#+CREATED: %u\n#+LAST_MODIFIED: %U\n\n%?\n\n- references ::\n"
        ;;  :unnarrowed t
        ;;  )
        )
      )
      )

(setq select-enable-clipboard t) ;; enable system clipboard

;; vterm
(after! vterm
  (set-popup-rule! "*doom:vterm-popup"
    :size 0.15
    ;; :vslot -4
    :select t
    :quit nil))

;; org-roam-server
(setq org-roam-server-host "127.0.0.1"
      org-roam-server-port 8080
      org-roam-server-authenticate nil
      org-roam-server-export-inline-images t
      org-roam-server-serve-files nil
      org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
      org-roam-server-network-poll t
      org-roam-server-network-arrows nil
      org-roam-server-network-label-truncate t
      org-roam-server-network-label-truncate-length 60
      org-roam-server-network-label-wrap-length 20)

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

;; (defun org-roam-convert-to-literature-note ()
;; (shell-command "mv" buffer-file-name "%<%Y%m%d%H%M%S>-literature.org"))

;; org-roam
(map! :leader :desc "add tag"                 "a a"   #'org-roam-tag-add)
(map! :leader :desc "insert link"             "a i"   #'org-roam-insert)
(map! :leader :desc "roam server"             "a s"   #'org-roam-server-mode)
(map! :leader :desc "roam find file"          "a f"   #'org-roam-find-file)
(map! :leader :desc "backlinks"               "a b"   #'org-roam-buffer-toggle-display)
(map! :leader :desc "capture"                 "a c"   #'org-roam-capture)
(map! :leader :desc "jump to top"             "a j"   #'org-roam-jump-to-index)
;; (map! :leader :desc "convet to literature"    "a l"   #'org-roam-convert-to-literature-note)


;; deft
(setq deft-directory "~/txt/roam"
      deft-extensions '("md" "org")
      deft-recursive t)

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

