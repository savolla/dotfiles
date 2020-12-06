;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Languages ###################################################################
;; go
(setq lsp-gopls-hover-kind "FullDocumentation")

;; python
;; rust
(setq rustic-format-on-save t)
(setq lsp-rust-all-features t)
(setq lsp-rust-cfg-test t)
;;#######################################################################################



;; IRC config ###########################################################################
;; (set-irc-server! "chat.freenode.net"
;;   `(:tls t
;;     :port 6697
;;     :nick "savolla"
;;     :sasl-username ,(+pass-get-user "irc/freenode.net")
;;     :sasl-password (lambda (&rest _) (+pass-get-secret "irc/freenode.net"))
;;     :channels ("#emacs")))
(use-package erc
 :custom
 (erc-autojoin-channels-alist '(("freenode.net" "#archlinux" "#bash" "#bitcoin"
                                 "#emacs" "#gentoo" "#i3" "#latex" "#org-mode" "#python")))
 (erc-autojoin-timing 'ident)
 (erc-fill-function 'erc-fill-static)
 (erc-fill-static-center 22)
 (erc-hide-list '("JOIN" "PART" "QUIT"))
 (erc-lurker-hide-list '("JOIN" "PART" "QUIT"))
 (erc-lurker-threshold-time 43200)
 (erc-prompt-for-nickserv-password nil)
 (erc-server-reconnect-attempts 5)
 (erc-server-reconnect-timeout 3)
 (erc-track-exclude-types '("JOIN" "MODE" "NICK" "PART" "QUIT"
                            "324" "329" "332" "333" "353" "477"))
 :config
 (add-to-list 'erc-modules 'notifications)
 (add-to-list 'erc-modules 'spelling)
 (erc-services-mode 1)
 (erc-update-modules))
;;#######################################################################################




;; Custom Key Bindings ##################################################################
;; custom keys '-'
(map! :leader :desc "custom keys"       "-") ;; custom bindings

;; code 'c'
(map! :leader :desc "code"              "- c")
(map! :leader :desc "toggle tagbar"     "- c t" #'lsp-ui-imenu ) ;; toggle tagbar
(map! :leader :desc "toggle undo tree"  "- c u" #'undo-tree-visualize ) ;; toggle undo tree
(map! :leader :desc "run gdb"           "- c g" #'gdb ) ;; run gdb

;; tabs 't'
(map! :leader :desc "tabs"              "- t")
(map! :leader :desc "new tab"           "- t o" #'tab-new ) ;; new tab
(map! :leader :desc "next tab"          "- t n" #'tab-next ) ;; next tab
(map! :leader :desc "kill tab"          "- t k" #'tab-kill ) ;; kill tab
(map! :leader :desc "previous tab"      "- t p" #'tab-previous ) ;; previous tab
(map! :leader :desc "list tabs"         "- t l" #'tab-list ) ;; list all tabs
(map! :leader :desc "toggle tabs"       "- t t" #'tab-bar-mode ) ;; toggle tab-bar-mode

;; utility 'u'
(map! :leader :desc "utility"     "- u")
(map! :leader :desc "open pass"   "- u p" #'pass ) ;; passwords
(map! :leader :desc "irc"         "- u i" #'irc ) ;; IRC
(map! :leader :desc "ranger"      "o - " #'ranger ) ;; ranger

;; workspace navigation
(map! :leader :desc "next workspace"         "TAB l" #'+workspace:switch-next ) ;; workspace next
(map! :leader :desc "previous workspace"     "TAB h" #'+workspace:switch-previous ) ;; workspace previous

;; org-roam
(map! :leader :desc "tagging"           "n r t")
(map! :leader :desc "add tag"           "n r t a" #'org-roam-tag-add)
(map! :leader :desc "delete tag"        "n r t d" #'org-roam-tag-delete)
(map! :leader :desc "roam server"       "n r G" #'org-roam-server-mode)

;;#######################################################################################





;; Appearance ###########################################################################

;; splash screen
(setq fancy-splash-image (concat doom-private-dir "splash.png")) ;; set custom splash
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu) ;; hide start menu
(defun doom-dashboard-widget-footer ())

;; transparency
(add-to-list 'default-frame-alist '(alpha . (82 . 92)))

;; themes
;; (setq doom-theme 'doom-one) ;; option 1
;; (setq doom-theme 'doom-gruvbox) ;; option 2
;; (setq doom-theme 'doom-outrun-electric) ;; option 3
(setq doom-theme 'doom-dracula) ;; option 4

;; coding
(setq display-line-numbers-type nil)

;; font
;; FONT OPTION 3
(setq-default line-spacing 0.25)
(setq doom-font (font-spec :family "Pragmata Pro Mono" :size 18 :weight 'light)
      doom-big-font (font-spec :family "Pragmata Pro Mono" :size 30)
      doom-serif-font (font-spec :family "Pragmata Pro Mono" :weight 'light)
      doom-variable-pitch-font (font-spec :family "Pragmata Pro Mono" :size 19))

;; (setq doom-font (font-spec :family "FiraCode NF" :size 20))

;; FONT OPTION 1
;; (setq doom-font (font-spec :family "monospace" :size 16 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 17))

;; FONT OPTION 2
;; (setq doom-font (font-spec :family "Fira Code" :size 17)
;;       doom-variable-pitch-font (font-spec :family "Fira Code" :size 17))

;;#######################################################################################




;; Utility ##############################################################################

;; vterm
(after! vterm
  (set-popup-rule! "*doom:vterm-popup"
    :size 0.15
    ;; :vslot -4
    :select t
    :quit nil))

;; Anki
(setq anki-editor-create-decks t)

;; Org
(setq
 org-adapt-indentation nil ;; [fn::suspect]
 org-directory "~/txt/"
 org-ellipsis " ▼ "
 org-superstar-headline-bullets-list '("☰" "☱" "☲" "☳" "☴" "☵" "☶" "☷" "☷" "☷" "☷")
 org-beamer-theme "[progressbar=foot]metropolis"
 org-beamer-frame-level 2
 org-hide-block-startup t)

(after! org
  (setq
   org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))
   org-log-done 'time))
(after! org
  (setq
   org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("@omscs" . ?o))
   org-fast-tag-selection-single-key t))
(setq org-imenu-depth 6) ;;
(custom-set-faces! ;; set heading size
  '(outline-1 :weight extra-bold :height 1.12)
  '(outline-2 :weight bold :height 1.10)
  '(outline-3 :weight bold :height 1.08)
  '(outline-4 :weight semi-bold :height 1.06)
  '(outline-5 :weight semi-bold :height 1.04)
  '(outline-6 :weight semi-bold :height 1.02)
  '(outline-8 :weight semi-bold)
  '(outline-9 :weight semi-bold))

(after! org (setq org-export-headline-levels 6))

(eval-after-load "org" ;; enable github flavored markdown
  '(require 'ox-gfm nil t))

;; Projectile
(setq projectile-project-search-path '("~/dev/")) ;; auto discover projects
(defun +private/projectile-invalidate-cache (&rest _args) ;; clear caches when switching branches
  (projectile-invalidate-cache nil))
(advice-add 'magit-checkout
            :after #'+private/projectile-invalidate-cache)
(advice-add 'magit-branch-and-checkout
            :after #'+private/projectile-invalidate-cache)

;; Deft
(setq deft-directory org-roam-directory)

;; Treemacs
(after! treemacs
  (treemacs-follow-mode 1)
  (setq treemacs-width 30))

;; Company
(after! company
  (remove-hook 'evil-normal-state-entry-hook #'company-abort)) ;; prevent mini blocks disappearence
(setq company-idle-delay 0)

;; Magit
(setq forge-topic-list-limit '(30 . 6)) ;; limit the number of topics

;; org-roam
(setq org-roam-index-file "notitia.org" )
(setq org-roam-capture-templates
      '(("d" "default" plain (function org-roam-capture--get-point)
         "%?"
         :file-name "${slug}"
         :head "#+TITLE: ${title}\n"
         :unnarrowed t)))
(setq org-roam-directory "~/txt/roam" )

(defun jsravn--open-org-roam ()
  "Called by `org-mode-hook' to call `org-roam' if the current buffer is a roam file."
  (remove-hook 'window-configuration-change-hook #'jsravn--open-org-roam)
  (when (org-roam--org-roam-file-p)
    (unless (eq 'visible (org-roam--current-visibility)) (org-roam))))

(after! org-roam
  (add-hook 'org-mode-hook
            (lambda ()
              (add-hook 'window-configuration-change-hook #'jsravn--open-org-roam))))

;; roam graph
(use-package org-roam-server
  :ensure t
  :config
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
        org-roam-server-network-label-wrap-length 20))
;;#######################################################################################



;; Editing ##############################################################################

;; undo
(setq evil-want-fine-undo t) ; undo more pleasant

;; autosave
(setq auto-save-visited-interval 30) ; Save after 30s of idle time.
(auto-save-visited-mode t)
(add-hook! '(doom-switch-buffer-hook
             doom-switch-window-hook)
  (if (buffer-file-name) (save-some-buffers t))) ; avoid saving when switching to a non-file buffer
(add-function :after after-focus-change-function
              (lambda () (save-some-buffers t)))

;; column filling
;;(setq-default fill-column 80) ;; max 80 characters per line
;; (add-hook! '(text-mode-hook prog-mode-hook conf-mode-hook)
;;            #'display-fill-column-indicator-mode)

;; window split options
(setq evil-vsplit-window-right t ;; automatic focus when splitted
      evil-split-window-below t) ;; automatic focus when splitted
(setq split-width-threshold 240)
(setq select-enable-clipboard t) ;; enable system clipboard

;; workspace
(setq +workspaces-on-switch-project-behavior t) ;; always open a new workspace when opening new project

;; zen mode
(after! writeroom-mode
  (setq +zen-text-scale 0
        +zen-mixed-pitch-modes nil
        writeroom-mode-line t
        writeroom-width 160))

;; pretty code
(setq +pretty-code-symbols nil) ;; just use pretty-code for the ligatures

;;#######################################################################################




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
;;

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-tomorrow-night)
;;

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.


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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#1E2029" "#ff6c6b" "#98be65" "#ECBE7B" "#51afef" "#c678dd" "#46D9FF" "#bbc2cf"])
 '(custom-safe-themes
   (quote
    ("bc836bf29eab22d7e5b4c142d201bcce351806b7c1f94955ccafab8ce5b20208" "2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "e1ef2d5b8091f4953fe17b4ca3dd143d476c106e221d92ded38614266cea3c8b" "632694fd8a835e85bcc8b7bb5c1df1a0164689bc6009864faed38a9142b97057" "912cac216b96560654f4f15a3a4d8ba47d9c604cbc3b04801e465fb67a0234f0" "e2acbf379aa541e07373395b977a99c878c30f20c3761aac23e9223345526bcc" default)))
 '(elfeed-feeds (quote ("https://feeds.feedburner.com/metalinjection")))
 '(fci-rule-color "#5B6268")
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
 '(objed-cursor-color "#ff6c6b")
 '(package-selected-packages
   (quote
    (plantuml-mode terminal-toggle howm nlinum-relative nlinum-hl)))
 '(pdf-view-midnight-colors (cons "#bbc2cf" "#282c34"))
 '(rustic-ansi-faces
   ["#282c34" "#ff6c6b" "#98be65" "#ECBE7B" "#51afef" "#c678dd" "#46D9FF" "#bbc2cf"])
 '(vc-annotate-background "#282c34")
 '(vc-annotate-color-map
   (list
    (cons 20 "#98be65")
    (cons 40 "#b4be6c")
    (cons 60 "#d0be73")
    (cons 80 "#ECBE7B")
    (cons 100 "#e6ab6a")
    (cons 120 "#e09859")
    (cons 140 "#da8548")
    (cons 160 "#d38079")
    (cons 180 "#cc7cab")
    (cons 200 "#c678dd")
    (cons 220 "#d974b7")
    (cons 240 "#ec7091")
    (cons 260 "#ff6c6b")
    (cons 280 "#cf6162")
    (cons 300 "#9f585a")
    (cons 320 "#6f4e52")
    (cons 340 "#5B6268")
    (cons 360 "#5B6268")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun jsravn--org-inline-css-hook (exporter)
  "Insert custom inline css to automatically set the
   background of code to whatever theme I'm using's background"
  (when (eq exporter 'html)
    (setq
     org-html-head-extra
     (concat
      (if (s-contains-p "<!––tec/custom-head-start-->" org-html-head-extra)
          (s-replace-regexp "<!––tec/custom-head-start-->.*<!––tec/custom-head-end-->" "" org-html-head-extra)
        org-html-head-extra)
      (format "<!––tec/custom-head-start-->
<style type=\"text/css\">
   :root {
      --theme-bg: %s;
      --theme-bg-alt: %s;
      --theme-base0: %s;
      --theme-base1: %s;
      --theme-base2: %s;
      --theme-base3: %s;
      --theme-base4: %s;
      --theme-base5: %s;
      --theme-base6: %s;
      --theme-base7: %s;
      --theme-base8: %s;
      --theme-fg: %s;
      --theme-fg-alt: %s;
      --theme-grey: %s;
      --theme-red: %s;
      --theme-orange: %s;
      --theme-green: %s;
      --theme-teal: %s;
      --theme-yellow: %s;
      --theme-blue: %s;
      --theme-dark-blue: %s;
      --theme-magenta: %s;
      --theme-violet: %s;
      --theme-cyan: %s;
      --theme-dark-cyan: %s;
   }
</style>"
              (doom-color 'bg)
              (doom-color 'bg-alt)
              (doom-color 'base0)
              (doom-color 'base1)
              (doom-color 'base2)
              (doom-color 'base3)
              (doom-color 'base4)
              (doom-color 'base5)
              (doom-color 'base6)
              (doom-color 'base7)
              (doom-color 'base8)
              (doom-color 'fg)
              (doom-color 'fg-alt)
              (doom-color 'grey)
              (doom-color 'red)
              (doom-color 'orange)
              (doom-color 'green)
              (doom-color 'teal)
              (doom-color 'yellow)
              (doom-color 'blue)
              (doom-color 'dark-blue)
              (doom-color 'magenta)
              (doom-color 'violet)
              (doom-color 'cyan)
              (doom-color 'dark-cyan))
      "
<link rel='stylesheet' type='text/css' href='https://fniessen.github.io/org-html-themes/styles/readtheorg/css/htmlize.css'/>
<link rel='stylesheet' type='text/css' href='https://fniessen.github.io/org-html-themes/styles/readtheorg/css/readtheorg.css'/>
<script src='https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js'></script>
<script type='text/javascript' src='https://fniessen.github.io/org-html-themes/styles/lib/js/jquery.stickytableheaders.min.js'></script>
<script type='text/javascript' src='https://fniessen.github.io/org-html-themes/styles/readtheorg/js/readtheorg.js'></script>
<style>
   pre.src {
     background-color: var(--theme-bg);
     color: var(--theme-fg);
     scrollbar-color:#bbb6#9992;
     scrollbar-width: thin;
     margin: 0;
     border: none;
   }
   div.org-src-container {
     border-radius: 12px;
     overflow: hidden;
     margin-bottom: 24px;
     margin-top: 1px;
     border: 1px solid#e1e4e5;
   }
   pre.src::before {
     background-color:#6666;
     top: 8px;
     border: none;
     border-radius: 5px;
     line-height: 1;
     border: 2px solid var(--theme-bg);
     opacity: 0;
     transition: opacity 200ms;
   }
   pre.src:hover::before { opacity: 1; }
   pre.src:active::before { opacity: 0; }
   pre.example {
     border-radius: 12px;
     background: var(--theme-bg-alt);
     color: var(--theme-fg);
   }
   code {
     border-radius: 5px;
     background:#e8e8e8;
     font-size: 80%;
   }
   kbd {
     display: inline-block;
     padding: 3px 5px;
     font: 80% SFMono-Regular,Consolas,Liberation Mono,Menlo,monospace;
     line-height: normal;
     line-height: 10px;
     color:#444d56;
     vertical-align: middle;
     background-color:#fafbfc;
     border: 1px solid#d1d5da;
     border-radius: 3px;
     box-shadow: inset 0 -1px 0#d1d5da;
   }
   table {
     max-width: 100%;
     overflow-x: auto;
     display: block;
     border-top: none;
   }
   a {
       text-decoration: none;
       background-image: linear-gradient(#d8dce9, #d8dce9);
       background-position: 0% 100%;
       background-repeat: no-repeat;
       background-size: 0% 2px;
       transition: background-size .3s;
   }
   \#table-of-contents a {
       background-image: none;
   }
   a:hover, a:focus {
       background-size: 100% 2px;
   }
   a[href^='#'] { font-variant-numeric: oldstyle-nums; }
   a[href^='#']:visited { color:#3091d1; }
   li .checkbox {
       display: inline-block;
       width: 0.9em;
       height: 0.9em;
       border-radius: 3px;
       margin: 3px;
       top: 4px;
       position: relative;
   }
   li.on > .checkbox { background: var(--theme-green); box-shadow: 0 0 2px var(--theme-green); }
   li.trans > .checkbox { background: var(--theme-orange); box-shadow: 0 0 2px var(--theme-orange); }
   li.off > .checkbox { background: var(--theme-red); box-shadow: 0 0 2px var(--theme-red); }
   li.on > .checkbox::after {
     content: '';
     height: 0.45em;
     width: 0.225em;
     -webkit-transform-origin: left top;
     transform-origin: left top;
     transform: scaleX(-1) rotate(135deg);
     border-right: 2.8px solid#fff;
     border-top: 2.8px solid#fff;
     opacity: 0.9;
     left: 0.10em;
     top: 0.45em;
     position: absolute;
   }
   li.trans > .checkbox::after {
       content: '';
       font-weight: bold;
       font-size: 1.6em;
       position: absolute;
       top: 0.23em;
       left: 0.09em;
       width: 0.35em;
       height: 0.12em;
       background:#fff;
       opacity: 0.9;
       border-radius: 0.1em;
   }
   li.off > .checkbox::after {
    content: '✖';
    color:#fff;
    opacity: 0.9;
    position: relative;
    top: -0.40rem;
    left: 0.17em;
    font-size: 0.75em;
  }
   span.timestamp {
       color: #003280;
       background: #647CFF44;
       border-radius: 3px;
       line-height: 1.25;
   }
   \#table-of-contents { overflow-y: auto; }
   blockquote p { margin: 8px 0px 16px 0px; }
   \#postamble .date { color: var(--theme-green); }
   ::-webkit-scrollbar { width: 10px; height: 8px; }
   ::-webkit-scrollbar-track { background:#9992; }
   ::-webkit-scrollbar-thumb { background:#ccc; border-radius: 10px; }
   ::-webkit-scrollbar-thumb:hover { background:#888; }
</style>
<!––tec/custom-head-end-->
"
      ))))

(add-hook 'org-export-before-processing-hook 'jsravn--org-inline-css-hook)

(setq org-html-text-markup-alist
      '((bold . "<b>%s</b>")
        (code . "<code>%s</code>")
        (italic . "<i>%s</i>")
        (strike-through . "<del>%s</del>")
        (underline . "<span class=\"underline\">%s</span>")
        (verbatim . "<kbd>%s</kbd>")))
