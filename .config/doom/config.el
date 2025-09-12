;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; dashboard
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "")))
(defun my-weebery-is-always-greater ()
  (let* ((banner '(
                   "                        ██  ██        "
                   "                        ██  ██        "
                   "  ████████████  ██████████  ██  ██████"
                   "  ██  ██▄▄████  ████  ████  ██  ██▄▄██"
                   "████  ██  ██  ██  ████████████████  ██"
                   ))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property

     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))
(setq +doom-dashboard-ascii-banner-fn #'my-weebery-is-always-greater)

;; personal info
(setq user-full-name "Kuzey Koç"
      user-mail-address "savolla@protonmail.com")

(setq display-line-numbers-type t)


;; font configuration
(setq doom-font (font-spec :family "IosevkaTerm Nerd Font Mono" :size 24)
      doom-variable-pitch-font (font-spec :family "IosevkaTerm Nerd Font Mono" :size 24))

;; Ensure new frames use the same font
;; fix new frames open with very small font
(defun my/apply-doom-font-to-new-frame (frame)
  (with-selected-frame frame
    (when doom-font
      (set-frame-font doom-font t t))))
(add-hook 'after-make-frame-functions #'my/apply-doom-font-to-new-frame)

;; theme
(setq doom-theme 'doom-gruvbox)

;; make darker background in gruvbox
(after! doom-themes
  (custom-set-faces!
    '(default :background "#000000")))



;;; relative line numbers
(setq display-line-numbers-type 'relative)

;;; disable current line hightlight
(setq global-hl-line-modes nil)

;;; thicken window separator
(setq window-divider-default-right-width 2
      window-divider-default-bottom-width 2)

;;; change color of separator
(custom-set-faces! '(vertical-border :foreground "#877b75"))

;;; enable line wrapping globally
(global-visual-line-mode t)

;; evil
;; better j k experience skip pressing "g j" or "g k"
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

(setq evil-escape-key-sequence "jk") ;; escape from evil mode using j+k keys
(setq evil-move-cursor-back nil) ;; don't move cursor back when exiting insert mode
(setq evil-move-beyond-eol t) ;; can place cursor at the end of line. huge qol improvement
(setq evil-want-fine-undo t) ;; track history better
(define-key evil-normal-state-map (kbd "L") 'evil-end-of-line) ;; shift + l go to end of line
(define-key evil-normal-state-map (kbd "H") 'evil-first-non-blank) ;; shift + h go to start of line

;;; save 's' from evil-snipe
(after! evil-snipe
  ;; Disable evil-snipe overriding 's' and 'S' in normal mode
  (evil-snipe-mode -1)
  (evil-snipe-override-mode -1))
(define-key evil-normal-state-map (kbd "s") 'evil-substitute) ;; delete current char and enter in insert mode


;; change cursor colors by mode
(setq evil-insert-state-cursor '(box "#00FF00")
      evil-visual-state-cursor '(box "orange")
      evil-normal-state-cursor '(box "#E2E8EF"))

;; company
(after! company
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection) ;; use tab to complete (does not work in tui)
  (setq company-selection-wrap-around 1) ;; cycle through options
  (setq company-idle-delay 0.1) ;; get completion buffer faster
  )

;; corfu
;; (after! corfu
;;   (setq +corfu-want-tab-prefer-expand-snippets t)
;;   (map! :map corfu-map
;;         ;;;; use tab to accept completion (does not work in tui)
;;         :i [tab] #'corfu-complete                ;; accept completion
;;         :i "TAB" #'corfu-complete
;;         :i "C-j" #'corfu-next                    ;; next completion
;;         :i "C-k" #'corfu-previous                ;; previous completion
;;         :i "C-s" #'corfu-insert-separator        ;; insert blank space (+orderless)
;;         ))


;; treemacs
(after! treemacs
  (treemacs-follow-mode 1)
  (setq treemacs-width 25)
  (setq treemacs-position 'right)
  (setq treemacs-text-scale -1) ;; enable if using emacs gui
  (setq treemacs-git-mode 'extended)
  )
(map! :leader :desc "open treemacs" "o p"   #'+treemacs/toggle )


;; llm
(setq
 gptel-model 'deepseek-r1:8b
 gptel-backend (gptel-make-ollama "ollama"
                 :host "localhost:11434"
                 :stream t
                 :models '(deepseek-r1:8b)))


;; vterm
;;; vterm configuration for NixOS and tmux integration

;; NixOS-specific shell path configuration
(let ((zsh-path (shell-command-to-string "readlink -f $(which zsh)")))
  (setq explicit-shell-file-name (string-trim zsh-path))
  (setq vterm-shell (string-trim zsh-path)))

(setq vterm-environment '("TERM=xterm-256color"))
(setq vterm-timer-delay 0.005) ;; Reduce delay for better responsiveness

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; vterm popup configuration (Doom Emacs specific)
(after! vterm
  (set-popup-rule! "*doom:vterm-popup"
    :size 0.35
    :select t
    :quit nil))

;; Avoid prompt when killing vterm buffers with running processes
(remove-hook 'kill-buffer-query-functions 'process-kill-buffer-query-function)

;; Allow tmux prefix (M-o) passthrough
(with-eval-after-load 'vterm
  (define-key vterm-mode-map (kbd "M-o") #'vterm--self-insert))

;; tmux integration
(defvar-local my/vterm-tmux-started nil
  "Whether tmux has already been started in this vterm buffer.")

(defun my/vterm-start-tmux ()
  "Start tmux session in vterm once, avoiding nesting."
  (unless my/vterm-tmux-started
    (setq my/vterm-tmux-started t)
    (let ((workspace (persp-name (get-current-persp))))
      (vterm-send-string
       (format "sh -c 'unset TMUX; exec tmux new-session -A -s \"%s\"'" workspace))
      (vterm-send-return))))

(defun my/vterm-setup ()
  "Custom setup for `vterm-mode`."
  (visual-line-mode -1) ;; Disable line wrap for better zsh modeline rendering
  (run-with-timer 0.3 nil #'my/vterm-start-tmux))

(add-hook 'vterm-mode-hook #'my/vterm-setup)

;; send zsh auto completion command (disabled bc I want to use navigations in non-tmux vterm buffers as well)
;; (evil-define-key 'normal vterm-mode-map "l" 'vterm-send-right)
;; (evil-define-key 'normal vterm-mode-map "h" 'vterm-send-left)
;; (evil-define-key 'normal vterm-mode-map "k" 'vterm-send-up)
;; (evil-define-key 'normal vterm-mode-map "j" 'vterm-send-down)

;; (evil-define-key 'normal vterm-mode-map "l"
;;   (lambda () (interactive) (vterm-send-key "right")))

;; workspaces
(map! :leader :desc "switch to previous workspace" "TAB h"   #'+workspace:switch-previous )
(map! :leader :desc "switch to next workspace"     "TAB l"   #'+workspace:switch-next )
(map! :leader :desc "last workspace"               "TAB TAB" #'+workspace/other )
(map! :leader :desc "display workspaces"           "TAB SPC" #'+workspace/display )


;; buffers
;; (map! :leader :desc "kill buffer and window"       "b k" #'savolla/kill-buffer-and-window ) ;; problematic. completely delete
(map! :leader :desc "switch buffer"
      "b l" #'consult-buffer)
(map! :leader :desc "last buffer"
      "b b" #'evil-switch-to-windows-last-buffer)


;; tabs
(map! :n "t" #'centaur-tabs-forward )
(map! :n "T" #'centaur-tabs-backward )

(setq
 tab-bar-close-button-show nil
 tab-bar-new-button-show nil
 tab-bar-separator "|"
 )

;;; centaur tabs
(setq
 centaur-tabs-style "alternate"
 centaur-tabs-height 35

 ;; display highlight bar bottom
 centaur-tabs-set-bar 'under
 x-underline-at-descent-line t

 ;; disable "X" close button
 centaur-tabs-close-button " "

 ;; disable new tab button
 centaur-tabs-show-new-tab-button nil

 ;; make new tabs open to the right
 centaur-tabs-adjust-buffer-order 'right

 ;; don't gray out file icons
 centaur-tabs-gray-out-icons 'buffer
 ;; centaur-tabs-gray-out-icons nil
 )

;; disable groupings for tabs
(defun my/centaur-tabs-buffer-groups ()
  "Disable grouping in centaur-tabs. All buffers go in the same group."
  '("Default"))

(setq centaur-tabs-buffer-groups-function 'my/centaur-tabs-buffer-groups)

;; transparency
(add-to-list 'default-frame-alist '(alpha-background . 70))




;; window
(setq evil-vsplit-window-right t) ;; automatic focus when splitted
(setq evil-split-window-below t) ;; automatic focus when splitted
(setq split-width-threshold 240)



;; development
;; emmet
;; hooks
(add-hook 'html-mode-hook  'emmet-mode) ;; enable emmet in html mode
(add-hook 'css-mode-hook  'emmet-mode) ;; enable emmet's css abbreviation.
(add-hook 'rjsx-mode-hook  'emmet-mode) ;; enable emmet in rjsx mode
(add-hook 'js-jsx-mode-hook  'emmet-mode) ;; enable emmet in jsx mode
;; keybinds
(map! :map emmet-mode-keymap
      :i "<C-return>" #'emmet-expand-line
      :i "<tab>" #'emmet-next-edit-point
      :i "<backtab>" #'emmet-prev-edit-point
      )
(setq emmet-expand-jsx-className? t) ;; default nil

;; make default tab size in js/ts modes (fix prettier enter 4 spaces tab)
;; (setq typescript-indent-level 2)

;; epub
(use-package nov
  :ensure t
  :mode ("\\.epub\\'" . nov-mode))

;; tailwind
(use-package! lsp-tailwindcss
  :after lsp-mode
  :init
  (setq lsp-tailwindcss-add-on-mode t
        lsp-tailwindcss-server-version "0.14.8"
        lsp-tailwindcss-skip-config-check t))


;; org-mode ~~~~~~~~~~~~~~~~~~
(setq org-attach-id-dir "~/resource/notes/org/attachments")
(setq org-directory "~/resource/notes/org")

;;; org mode hooks ~~~~~~~~~~~~~~~~~~
(add-hook 'after-save-hook #'my/org-mode-hugo-auto-export)

;; prevent org babel from running code blocks when exporting ~~~~~
(setq org-export-babel-evaluate nil)

;; enable breadcrumbs in org view~~~~~~~~~~~~~~~
(use-package! org-sticky-header
  :hook (org-mode . org-sticky-header-mode)
  :config
  (setq org-sticky-header-full-path 'full      ;; show full heading path
        org-sticky-header-outline-path-separator " > "
        org-sticky-header-always-show-header t))


(after! org
  ;; org specific bindings
  (map! :map org-mode-map "<f5>" #'org-anki-sync-entry)

  (setq org-ellipsis " ")
  (setq org-lowest-priority ?F) ;; set todo priorities from A to F
  (setq org-modern-star '("◉" "◉" "◉" "◉" "◉"))
  (setq org-modern-list '((?- . "•") (?+ . "➤") (?* . "→")))
  (setq org-startup-folded 'overview) ;; auto fold all headings
  (setq org-fontify-archived-trees nil) ;; Optional: disables fontifying archived trees

  ;;; make latex previews bigger
  (plist-put org-format-latex-options :scale 2.0)

  ;;; better image rendering
  (setq org-preview-latex-default-process 'dvisvgm)
  (plist-put org-format-latex-options :background "Transparent")

  ;; enable latex previews globally
  (setq org-startup-with-latex-preview t)

  (setq org-todo-keywords '
        (
         (sequence "TODO(t)" "DOING(o!)" "NEXT(n)" "ZETTEL(z)"
                   "ARTICLE(a)" "REPEAT(R)" "DEADLINE(D)" "SCHEDULED(S)"
                   "HABIT(h)" "LATER(l@/!)" "WAIT(w@/!)"
                   "|"
                   ;; "DONE(d@/!)" "CANCEL(c@/!)"
                   "DONE(d!)" "CANCEL(c@/!)"
                   )
         (sequence "CONTEXT" "|" "REVIEW")
         ))


  (setq org-todo-keyword-faces
        '(("TODO" . (:foreground "#00FF00" :weight bold)) ;; task
          ("DOING" . (:foreground "#FF0000" :weight bold)) ;; now doing
          ("NEXT" . (:foreground "#FF00FF" :weight bold)) ;; will continue to this after DOING
          ("WAIT" . (:foreground "yellow" :weight bold)) ;; wait for somebody
          ("LATER" . (:foreground "yellow" :weight bold)) ;; I'm gonna do it later
          ("SCHEDULED" . (:foreground "yellow" :weight bold)) ;; event etc.
          ("REPEAT" . (:foreground "green" :weight bold)) ;; looped tasks
          ("DEADLINE" . (:foreground "red" :weight bold)) ;; do this before time ends
          ("DONE" . (:foreground "#666666" :weight bold)) ;; finished task
          ("HABIT" . (:foreground "#00FFFF" :weight bold))
          ("CONTEXT" . (:foreground "#FFFFFF" :weight bold))
          ("CANCEL" . (:foreground "#666666" :weight bold))) ;; cancelled task
        )
  )

;; when I hit 'z n' I want to hide all drawers and do other things automatically
(defun my/org-hide-drawers-after-indirect-buffer (&rest _args)
  "Hide drawers in the indirect Org buffer."
  (when (derived-mode-p 'org-mode)
    (org-fold-hide-drawer-all) ;; hide all PROPERTY drawers
    (evil-goto-line) ;; navigate to bottom
    (evil-insert) ;; enter into insert mode
    ))
(advice-add 'org-tree-to-indirect-buffer :after #'my/org-hide-drawers-after-indirect-buffer)

;; hide all source blocks by default
(defun my/org-hide-all-blocks-on-open ()
  "Hide all blocks when opening an Org file."
  (org-fold-hide-block-all))
(add-hook 'org-mode-hook #'my/org-hide-all-blocks-on-open)

;; fold task after it marked as DONE
(defun my/org-fold-on-done ()
  "Fold the current heading when marked as DONE."
  (when (string= org-state "DONE")
    (org-cycle 'fold)))  ;; fold the current subtree
(add-hook 'org-after-todo-state-change-hook #'my/org-fold-on-done)

;; tangle source codes on save automatically
(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t)
  )


;; disable word completion in org/markdown modes
(defun savolla/adjust-org-company-backends ()
  (remove-hook 'after-change-major-mode-hook '+company-init-backends-h)
  (setq-local company-backends nil))
(add-hook! org-mode (savolla/adjust-org-company-backends))
(add-hook! markdown-mode (savolla/adjust-org-company-backends))

;; disable org headings being bold
(custom-set-faces
 ;; Org-mode header levels in regular weight
 '(org-level-1 ((t (:inherit outline-1 :weight normal))))
 '(org-level-2 ((t (:inherit outline-2 :weight normal))))
 '(org-level-3 ((t (:inherit outline-3 :weight normal))))
 '(org-level-4 ((t (:inherit outline-4 :weight normal))))
 '(org-level-5 ((t (:inherit outline-5 :weight normal))))
 '(org-level-6 ((t (:inherit outline-6 :weight normal))))
 '(org-level-7 ((t (:inherit outline-7 :weight normal))))
 '(org-level-8 ((t (:inherit outline-8 :weight normal))))
 )

;; enable org transclusion
;; (use-package! org-transclusion
;;   :hook (org-mode . org-transclusion-mode))

;;; parse all zettels and write them into zettelkasten.org
(defun savolla/generate-zettels-list ()
  "Scan org-roam/daily files for :z: tagged headings and update zettels.org grouped by other tags.
Excludes unwanted tags and properly resets transclusion state before regenerating."
  (interactive)
  (let* ((zettel-file "~/resource/notes/org/roam/zettelkasten/zettels.org")
         (zettel-dir "~/resource/notes/org/roam/daily")
         (excluded-tags '("contact" "ARTICLE" "outdated"))  ;; Tags to exclude
         (zettel-files (directory-files-recursively zettel-dir "\\.org$"))
         (zettel-groups (make-hash-table :test 'equal)))

    ;; Search each file for :z: tagged headlines
    (dolist (file zettel-files)
      (with-current-buffer (find-file-noselect file)
        (org-with-wide-buffer
         (org-element-map (org-element-parse-buffer) 'headline
           (lambda (hl)
             (let ((tags (org-element-property :tags hl)))
               (when (and tags (member "z" tags))
                 (let* ((title (org-element-property :raw-value hl))
                        (begin (org-element-property :begin hl)))
                   (goto-char begin)
                   (let ((id (org-entry-get (point) "ID")))
                     (when id
                       (let ((zettel (format "#+transclude: [[id:%s][%s]] :level 2" id title)))
                         ;; Remove excluded tags and 'z', then group under the rest
                         (dolist (tag (seq-remove (lambda (t) (member t (cons "z" excluded-tags))) tags))
                           (let ((existing (gethash tag zettel-groups)))
                             (puthash tag (cons zettel existing) zettel-groups)))))))))))))

      ;; Write output to zettels.org
      (with-current-buffer (find-file-noselect zettel-file)
        ;; Clean up transclusion mode
        (when (bound-and-true-p org-transclusion-mode)
          (org-transclusion-remove-all)
          (org-transclusion-mode -1))

        (let ((inhibit-read-only t)) ;; Bypass read-only
          (erase-buffer)
          ;; Insert export and style headers
          (insert "#+TITLE: Zettels\n")
          (insert "#+OPTIONS: toc:nil num:nil author:nil timestamp:nil\n")
          (insert "#+EXPORT_FILE_NAME: zettels.html\n")
          (insert "#+HTML_HEAD: <style>ul { list-style-type: disc; margin-left: 1.5em; }</style>\n")
          (insert "#+HTML_HEAD: <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n")
          (insert "#+HTML_HEAD: <meta charset=\"utf-8\">\n")
          (insert "#+HTML_HEAD_EXTRA: <link rel=\"stylesheet\" href=\"/css/zettels.css\">\n")
          (insert "#+LANGUAGE: en\n\n")

          ;; Insert grouped zettels by tag
          (maphash
           (lambda (tag zettels)
             (insert (format "* %s\n" tag))
             (dolist (z (reverse (delete-dups zettels)))
               (insert z "\n")))
           zettel-groups)

          (save-buffer)

          ;; Optionally re-enable transclusion (comment out if undesired)
          (org-transclusion-mode 1)
          (org-transclusion-add-all)
          )))))

;;; make gifs and images displayed better
(setq org-startup-with-inline-images t)
(setq org-image-actual-width nil)

;; export pdfs with syntax hightighting
(setq org-latex-src-block-backend 'engraved)

;; org-anki
(customize-set-variable 'org-anki-default-deck "Default")

;;; insert devops flashcard
(defun insert-basic-flashcard-into-devops-deck ()
  "Insert a timestamped Anki flashcard at the same heading level, with Front/Back as child headings."
  (interactive)
  ;; (org-end-of-subtree)
  (org-insert-heading)
  (let ((title (format-time-string "%Y-%m-%d %H:%M ")))
    (insert title)
    ;; (insert " :_f:devops:")
    (insert "\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: devops\n:END:")
    (org-id-get-create)

    ;; Insert Front and Back subheadings
    (org-insert-subheading t)
    (insert "Front")
    (let ((insert-point (point))) ;; save location after Front heading
      (org-insert-heading t)
      (insert "Back\n")
      ;; Fold properties drawer
      (save-excursion
        (org-cycle-hide-drawers 'all))
      ;; Go back to insert-point
      (goto-char insert-point)
      (end-of-line)
      (interactive)
      (evil-org-open-below)
      )))

(defun insert-basic-flashcard-into-camunda-deck ()
  "Insert a timestamped Anki flashcard at the same heading level, with Front/Back as child headings."
  (interactive)
  ;; (org-end-of-subtree)
  (org-insert-heading)
  (let ((title (format-time-string "%Y-%m-%d %H:%M ")))
    (insert title)
    ;; (insert " :_f:devops:camunda")
    (insert "\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: camunda\n:END:")
    (org-id-get-create)

    ;; Insert Front and Back subheadings
    (org-insert-subheading t)
    (insert "Front")
    (let ((insert-point (point))) ;; save location after Front heading
      (org-insert-heading t)
      (insert "Back\n")
      ;; Fold properties drawer
      (save-excursion
        (org-cycle-hide-drawers 'all))
      ;; Go back to insert-point
      (goto-char insert-point)
      (end-of-line)
      (interactive)
      (evil-org-open-below)
      )))


;; org-noter
(setq org-noter-separate-notes-from-heading t) ;; aesthetics. leave spece between notes
(setq org-noter-always-create-frame nil) ;; prevent new frames
(setq org-noter-auto-save-last-location t) ;; resume where you left off
(setq org-noter-notes-search-path '("~/resource/notes/org/roam/resources/")) ;; default notes location

;; hugo

;; dirvish
;;; set currently selected image as wallpaper
(defun savolla/dired-set-wallpaper ()
  "Set the currently selected file in dired as wallpaper using feh."
  (interactive)
  (let ((file (dired-get-file-for-visit)))
    (when (and file (file-exists-p file))
      (start-process "feh-wallpaper" nil "feh" "--bg-scale" file))))

;;; go to wallpapers
(defun savolla/dired-go-to-favorites-wallpapers ()
  "Open dired in ~/resource/images/wallpapers/favorites."
  (interactive)
  (dired "~/resource/images/wallpapers/favorites"))

;;; bindings
;;;; set currently selected img as wallpaper
(map! :after dired :map dired-mode-map :desc "set wallpaper" :localleader "w" #'savolla/dired-set-wallpaper)
;;;; set currently selected img as wallpaper
(map! :after dired :map dired-mode-map :desc "go to wallpapers" :localleader "g w" #'savolla/dired-go-to-favorites-wallpapers)


;; journal
(map! :leader :desc "journal"                                    "j")
(map! :leader :desc "timestamped journal entry"                  "j j"   #'savolla/org-insert-header-with-timestamp )
(map! :leader :desc "task entry"                                 "j t"   #'savolla/org-insert-header-with-todo )
(map! :leader :desc "context entry"                              "j c"   #'savolla/insert-org-context-heading )
(map! :leader :desc "repeated deadline task"                     "j d"   #'savolla/org-insert-repeated-deadline-task )
(map! :leader :desc "repeated scheduled task"                    "j s"   #'savolla/org-insert-repeated-scheduled-task )
(map! :leader :desc "insert zettel"                              "j z"   #'savolla/org-insert-zettel )
(map! :leader :desc "insert contact"                             "j C"   #'savolla/org-insert-contact )

;; flashcards
(map! :leader :desc "flashcard"                                  "j f")
(map! :leader :desc "devops"                                     "j f d")
(map! :leader :desc "basic"                                      "j f d b" #'insert-basic-flashcard-into-devops-deck)
(map! :leader :desc "devops"                                     "j f c")
(map! :leader :desc "camunda"                                    "j f c b" #'insert-basic-flashcard-into-camunda-deck)

;; journal date navigation
(map! :leader :desc "go to"                                      "j g")
(map! :leader :desc "current day"                                "j g c" #'org-roam-dailies-goto-today)
(map! :leader :desc "yesterday"                                  "j g y" #'org-roam-dailies-goto-yesterday)
(map! :leader :desc "tomorrow"                                   "j g t" #'org-roam-dailies-goto-tomorrow)
(map! :leader :desc "pick date"                                  "j g g" #'org-roam-dailies-goto-date)

;; nixos specific
(map! :leader :desc "nixos"                                      "j n")
(map! :leader :desc "rebuild nixos"                              "j n r" #'savolla/nixos-rebuild)

;; silence warning when using snippet completions in org source blocks
(with-eval-after-load 'org-element
  (setq warning-suppress-types '((org-element))))

;; disable gray background of org code blocks
(custom-set-faces!
  '(org-block :background "#1c1b19")
  '(org-block-background :background unspecified)
  '(org-src :background unspecified))

;; org roam
;; (setq org-roam-directory "~/resource/notes/org/roam")
;; (setq org-roam-dailies-directory "~/resource/notes/org/roam/daily")
(setq org-roam-database-connector 'sqlite3) ;; important for querying the db

;; disable breadcrumbs in org-roam-node-find buffer and disable clutter
;; (setq org-roam-node-display-template "${title} ${tags}")
(after! org-roam
  (setq org-roam-node-display-template
        (concat
         (propertize "${doom-hierarchy}" 'face 'font-lock-keyword-face)
         " "
         (propertize "${doom-tags}" 'face '(:inherit org-tag :box nil)))))

;; enable org-roam-ql after org roam
;; (use-package! org-roam-ql
;;   :after org-roam
;;   :commands (org-roam-ql-search org-roam-ql-nodes org-dblock-write:org-roam-ql))

(use-package! org-roam-ql
  :after org-roam
  :config
  ;; Bind "v" in org-roam-mode-map to org-roam-ql-buffer-dispatch
  (map! :map org-roam-mode-map
        "v" #'org-roam-ql-buffer-dispatch)

  ;; Bind "C-c n i" in minibuffer-local-map to org-roam-ql-insert-node-title
  (map! :map minibuffer-local-map
        "C-c n i" #'org-roam-ql-insert-node-title))


;; org link references
(map! :leader :desc "copy id"                                    "j C" #'org-store-link)
(map! :leader :desc "paste id"                                   "j P" #'org-insert-link)


;; org habit
(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60)


;; org agenda
(setq system-time-locale "C") ;; Force English for time-related formatting

;; run org-super-agenda-view after org agenda starts

(setq org-agenda-current-time-string "  NOW ")
(setq org-agenda-prefix-format '(
                                 (agenda . "%?-2i %s %b %t ")
                                 (tags . " %s")  ; disable timestamp in all tasks view
                                 ))

(setq org-agenda-files
      (directory-files-recursively "~/resource/notes/org/roam/" "\\.org$"))

;; remove clutter from agenda view
(setq org-agenda-prefix-format
      '((agenda . "%?-12t %s")
        (todo . " ")
        (tags . " ")
        (search . " ")))

(setq org-agenda-hide-tags-regexp ".*") ; hide all tags in org agenda view

;; org agenda view:
(setq org-agenda-custom-commands
      '(("b" "2-day Agenda"
         ((todo "DOING|NEXT|WAIT" ((org-agenda-overriding-header " 󱌣  Currently Working")))

          (agenda "" ((org-agenda-overriding-header "") ; make current date as header
                      (org-agenda-start-day "0d") ; start from today
                      (org-agenda-span 2) ; display 2 days
                      (org-deadline-warning-days 14))) ; remind upcoming deadlines before 2 weeks

          ;; personal contexts
          (tags "+_c+personal+project-_j-_z-_f-_r-_F/-TODO|-DONE"
                ((org-agenda-overriding-header "󱗾 Personal Contexts")
                 (org-agenda-skip-function
                  (lambda ()
                    (unless (org-entry-get (point) "ID")
                      (or (outline-next-heading) (point-max)))))))

          ;; work contexts
          (tags "+_c+work-_j-_z-_f-_r-_F/-TODO|-DONE"
                ((org-agenda-overriding-header "󱗾 Work Contexts")
                 (org-agenda-skip-function
                  (lambda ()
                    (unless (org-entry-get (point) "ID")
                      (or (outline-next-heading) (point-max)))))))

          ))

        ("z" "Zettelkasten Notes" tags "zetteltrack")

        ("g" "GenInterns Project Overview"
         ((tags
           "+@geninterns+_c+work+genyazılım/DOING|WAIT|NEXT"
           ((org-agenda-overriding-header "Currently Doing")))

          (tags
           "+@geninterns+_c+work+genyazılım/TODO|LATER"
           ((org-agenda-overriding-header "Tasks")))

          (tags
           "+@geninterns+_c+work+genyazılım/DONE|CANCELED"
           ((org-agenda-overriding-header "Archived"))))
         )

        ))



;; emms
(emms-all)
(emms-default-players)
(emms-mode-line 1)
(emms-playing-time 1)
(setq emms-browser-covers #'emms-browser-cache-thumbnail-async)
(setq emms-mode-line-format " %s")

;; Source my music from my server:
(setq emms-source-file-default-directory "~/resource/music/genres"
      emms-playlist-buffer-name "*music*"
      emms-info-asynchronously t
      emms-source-file-directory-tree-function 'emms-source-file-directory-tree-find
      emms-playlist-mode-popup-enabled t
      )

;; keybinds for emms
;;; emms screens
(map! :leader :desc "music" "m" )
(map! :leader :desc "open emms browser" "j m b"   #'emms-browser )
(map! :leader :desc "open emms playlist" "j m p"   #'emms-playlist-mode-go )
;;; music control
(map! :leader :desc "start/stop playback" "j m s"   #'emms-pause )
(map! :leader :desc "seek backward" "j m h"   #'emms-seek-backward )
(map! :leader :desc "seek forward" "j m l"   #'emms-seek-forward )
(map! :leader :desc "next song" "j m L"   #'emms-next )
(map! :leader :desc "previous song" "j m H"   #'emms-previous )


;; calc
(map! :leader :desc "calc" "o c" #'calc) ;; run calc

;; workspace rotation
(map! :leader :desc "rotate clockwise"                           "w r" #'savolla/rotate-workspace-clockwise)
(map! :leader :desc "rotate counter clockwise"                   "w R" #'savolla/rotate-workspace-couter-clockwise)



;; elfeed
(require 'elfeed-goodies)
(elfeed-goodies/setup)
(setq elfeed-goodies/tag-column-width 0) ;; hide tags
(setq elfeed-goodies/feed-source-column-width 16)
(setq elfeed-goodies/entry-pane-position :bottom) ;; display feed preview bottom
(setq elfeed-goodies/entry-pane-size 0.5) ;; set  preview pane 50%

;; auto preview feed content in preview buffer as you go
(evil-define-key 'normal elfeed-show-mode-map
  (kbd "J") 'elfeed-goodies/split-show-next
  (kbd "K") 'elfeed-goodies/split-show-prev
  )
(evil-define-key 'normal elfeed-search-mode-map
  (kbd "J") 'elfeed-goodies/split-show-next
  (kbd "K") 'elfeed-goodies/split-show-prev
  )

;; define your feeds
(setq elfeed-feeds
      '(
        ;; youtube
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCO-_F5ZEUhy0oKrSa69DLMw" youtube politics) ;; 140journos
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCC8t2yUG8VsN1MwEF-SEn_w" youtube leisure) ;; akın altan
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCDTSUkdlbcgEU-IGH_mHgmw" youtube science) ;; bebar bilim
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCGAmpBtWveYp0-3v9npnhvQ" youtube horror) ;; chilling scares
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCg6gPGh8HU2U01vaFCAsvmQ" youtube tech) ;; chris titus tech
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCpi_jv70749NkAmkdugyiPQ" youtube politics news) ;; dw türkçe
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCatnasFAiXUvWwH8NlSdd3A" youtube science) ;; evrim ağacı
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCsBjURrPoezykLs9EqgamOA" youtube tech) ;; fireship
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCXuqSBlHAE6Xw-yeJA0Tunw" youtube tech) ;; linux tech tips
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UC91V6D3nkhP89wUb9f_h17g" youtube horror) ;; meatcanyon
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCtPrkXdtCM5DACLufB9jbsA" youtube horror) ;; mrballen
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UC0dFN4m1vmOsPymPXBTGgyg" youtube leisure) ;; nate's film reviews
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCA7X5unt1JrIiVReQDUbl_A" youtube gaming) ;; path of exile
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UC8nZUXCwCTffxthKLtOp6ng" youtube gaming) ;; splattercatgaming
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCD6VugMZKRhSyzWEWA9W2fg" youtube gaming) ;; ssethtzeentach
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCjr2bPAyPV7t35MvcgT3W8Q" youtube privacy tech) ;; the hated one
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCt7fwAhXDy3oNFTAzF2o8Pw" youtube music) ;; theneedledrop
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UC_zBdZ0_H_jn41FDRG7q4Tw" youtube tech nixos) ;; vimjoyer
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCYT-ywSiWtPK_lf-dM-Kp9A" youtube politics) ;; şule aydın
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCCFVFyadjMuaR5O89yRToew" youtube tech) ;; virbox
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UC9x0AN7BWHpCDHSm9NiJFJQ" youtube tech) ;; NetworkChuck
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCEAbqW0HFB_UxZoUDO0kJBw" youtube tech) ;; Aitrepreneur
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCsnGwSIHyoYN0kiINAGUKxg" youtube tech) ;; wolfgang's channel
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCUMwY9iS8oMyWDYIe6_RmoA" youtube tech) ;; no boilerplate
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UC2eYFnH61tmytImy1mTYvhA" youtube tech philosophy) ;; luke smith
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCLdX8z-5vOwn_n_CNevRJtQ" youtube tech) ;; alphab91
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCN5tDO2rjUxk2-hyWxS00XA" youtube tech embedded) ;; bootlin
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCkEp_OUCCx-UU3A9-y62NiA" youtube philosophy) ;; diamond tema
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCkf4VIqu3Acnfzuk3kRIFwA" youtube tech) ;; gotbletu
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCmGSJVG3mCRXVOP4yZrU1Dw" youtube politics) ;; johnny harris
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCK0wWfg2_bqWOQFFNWp58mw" youtube gaming) ;; kitfox games
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCp7s4i-Zo_f_Jc9A-fINa7g" youtube tech) ;; savolla
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCmXmlB4-HJytD7wek0Uo97A" youtube tech) ;; jsmastery
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCWpk9PSGHoJW1hZT4egxTNQ" youtube leisure) ;; ruhi çenet
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCHnyfMqiRRG1u-2MsSQLbXA" youtube science) ;; veritasium
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UC7YOGHUfC1Tb6E4pudI9STA" youtube tech) ;; mental outlaw

        ;; news
        ("https://www.reddit.com/r/Turkey.rss" news reddit politics) ;; r/Turkey
        ("https://hnrss.org/newest" hackernews news tech) ;; hackernews

        ;; blogs
        ))
(after! elfeed
  (elfeed-update) ;; update all the feeds once elfeed starts
  )

;; set important keybindings
(map! :leader :desc "elfeed" "o e"   #'elfeed )
(map! :after elfeed :desc "update feeds" :localleader "u" #'elfeed-update)
(map! :after elfeed :desc "open video in mpv" :localleader "v" #'elfeed-tube-mpv)
(map! :after elfeed :desc "open in browser" :localleader "o" #'elfeed-search-browse-url)

;; filter
(map! :map elfeed-search-mode-map :desc "filter" :localleader "f")
;; show all reddit feeds
(map! :map elfeed-search-mode-map :desc "reddit" :localleader "f r" (lambda () (interactive) (elfeed-search-set-filter "@6-months-ago +unread +reddit")))
;; show all youtube feeds
(map! :map elfeed-search-mode-map :desc "youtube" :localleader "f y" (lambda () (interactive) (elfeed-search-set-filter "@6-months-ago +unread +youtube")))
;; show all hackernews feeds
(map! :map elfeed-search-mode-map :desc "hackernews" :localleader "f h" (lambda () (interactive) (elfeed-search-set-filter "@6-months-ago +unread +hackernews")))
;; show all horror feeds
(map! :map elfeed-search-mode-map :desc "horror" :localleader "f H" (lambda () (interactive) (elfeed-search-set-filter "@6-months-ago +unread +horror")))
;; show all news feeds
(map! :map elfeed-search-mode-map :desc "news" :localleader "f n" (lambda () (interactive) (elfeed-search-set-filter "@6-months-ago +unread +news")))
;; show all science feeds
(map! :map elfeed-search-mode-map :desc "science" :localleader "f s" (lambda () (interactive) (elfeed-search-set-filter "@6-months-ago +unread +science")))
;; show all tech feeds
(map! :map elfeed-search-mode-map :desc "tech" :localleader "f t" (lambda () (interactive) (elfeed-search-set-filter "@6-months-ago +unread +tech")))
;; show all politics feeds
(map! :map elfeed-search-mode-map :desc "politics" :localleader "f p" (lambda () (interactive) (elfeed-search-set-filter "@6-months-ago +unread +politics")))
;; show all leisure feeds
(map! :map elfeed-search-mode-map :desc "leisure" :localleader "f p" (lambda () (interactive) (elfeed-search-set-filter "@6-months-ago +unread +leisure")))
;; show all gaming feeds
(map! :map elfeed-search-mode-map :desc "gaming" :localleader "f g" (lambda () (interactive) (elfeed-search-set-filter "@6-months-ago +unread +gaming")))

;; elfeed custom faces by tags
;;; youtube
(defface elfeed-tag-youtube-face
  '((t :foreground "red"))
  "Face for YouTube entries in Elfeed.")

;;; reddit
(defface elfeed-tag-reddit-face
  '((t :foreground "orange" ))
  "Face for Reddit entries in Elfeed.")

(with-eval-after-load 'elfeed
  (add-to-list 'elfeed-search-face-alist '(youtube elfeed-tag-youtube-face))
  (add-to-list 'elfeed-search-face-alist '(reddit elfeed-tag-reddit-face)))


;; centered cursor
;; (defun savolla/set-scroll-margin-locally ()
;;   "Set `scroll-margin` to 10 only in certain modes."
;;   (setq-local scroll-margin 10)
;;   (setq-local scroll-conservatively 101))

;; ;;; make evil-scroll-up/down respect centered cursor's margin
;; (setq scroll-preserve-screen-position t)

;; ;;; use centered cursor only in programming and text modes
;; (add-hook 'prog-mode-hook #'savolla/set-scroll-margin-locally)
;; (add-hook 'text-mode-hook #'savolla/set-scroll-margin-locally)

;; misc
;;; fix links don't open from emacs
(setq browse-url-browser-function 'browse-url-xdg-open)
;;; enable transparency in tui mode
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))
(add-hook 'window-setup-hook 'on-after-init)
(on-after-init)

;; disable doom emacs quit confirmation
(setq confirm-kill-emacs nil)

;; enable auto saving
(setq auto-save-default t)

;; repeat last command/shortcut with comma
(map! :n "," #'repeat)

;; resize windows easily
(map! :n "C-<up>" #'evil-window-increase-height)
(map! :n "C-<down>" #'evil-window-decrease-height)
(map! :n "C-<right>" #'evil-window-decrease-width)
(map! :n "C-<left>" #'evil-window-increase-width)

;; adjust font easily
(map! "C-S-<prior>" #'doom/increase-font-size)
(map! "C-S-<next>" #'doom/decrease-font-size)
(map! "C-S-<home>" #'doom/reset-font-size)


;; which-key
(setq which-key-idle-delay 0.2) ;; make which-key menu start faster


;; performance
;; lsp optimizations
(after! lsp-mode
  (setq lsp-idle-delay 0.5
        lsp-enable-symbol-highlighting nil
        lsp-headerline-breadcrumb-enable nil
        lsp-modeline-diagnostics-enable nil
        lsp-ui-doc-enable nil))
;; Increase GC threshold during startup and reset afterwards
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold 100000000)))



;; startup
(defun my-startup-setup ()
  (run-at-time "1 sec" nil  ; Delay to avoid conflicts during startup
               (lambda ()
                 ;; rename first workspace to tmux
                 ;; (+workspace-rename "main" "tmux")

                 ;; launch tmux session
                 ;; (scratch-buffer)
                 ;; (visual-line-mode nil) ;; disable wrap to tmux looks good
                 ;; (vterm-mode)
                 ;; (vterm-send-string "attach-all-tmux-sessions")
                 ;; (vterm-send-return)


                 ;; create a new workspace for journal
                 ;; (+workspace/new-named "journal")
                 (+workspace-rename "main" "journal")
                 ;; (+zen/toggle) ;; toggle big mode for better visibility
                 "Set up a custom startup window layout."
                 (interactive)
                 ;; Start by opening the journal
                 (delete-other-windows)
                 (find-file "~/resource/notes/org/roam/index.org")
                 (org-roam-dailies-goto-today)

                 ;; Split right: Currently working tasks (agenda "o")
                 (let ((right (split-window-right)))
                   (select-window right)
                   (org-agenda nil "b")

                   ;; ;; Split below for daily agenda (agenda "d")
                   ;; (let ((bottom-right (split-window-below)))
                   ;;   (select-window bottom-right)
                   ;;   (org-agenda nil "d")

                   ;;   ;; Split below again for all todos (agenda "c")
                   ;;   (let ((bottom-todos (split-window-below)))
                   ;;     (select-window bottom-todos)
                   ;;     (org-agenda nil "c")

                   ;;     ;; Adjust window sizes manually if needed
                   ;;     (balance-windows)
                   ;;     )
                   ;;   )

                   ;; Go back to left (journal)
                   (other-window -1)
                   (end-of-buffer)
                   )
                 )))

;; Run the setup after Emacs starts
(add-hook 'emacs-startup-hook 'my-startup-setup)



;; custom functions
(defun my/org-mode-hugo-auto-export ()
  "Automatically export to Hugo-compatible Markdown on save if the Org file is for ox-hugo."
  (when (and (eq major-mode 'org-mode)
             (string-match-p "HUGO_BASE_DIR" (buffer-string))) ; only if it's a Hugo post
    (org-hugo-export-wim-to-md)))

(defun savolla/org-insert-header-with-timestamp ()
  "Insert a timestamped Org heading at the same level within the current subtree."
  (interactive)
  (org-end-of-subtree) ;; Move to end of current subtree
  (org-insert-heading) ;; Insert heading at same level
  (insert (format-time-string "%Y-%m-%d %H:%M ")) ;; Insert timestamp
  (end-of-line) ;; Move to new line ready for content
  (insert ":_j:") ;; add j tag for journal entry indicator
  (insert "\n") ;; descent one line down
  (evil-insert-state) ;; Switch to insert mode (evil)
  (org-id-get-create)) ;; create ID for org-roam can query this entry later


(defun savolla/insert-org-context-heading ()
  "Insert a new Org 'CONTEXT' heading with CREATED and ID properties."
  (interactive)
  (let ((created (format-time-string (org-time-stamp-format t t)))
        (id (org-id-get-create)))
    (insert (format "* CONTEXT [%%] \n:PROPERTIES:\n:CREATED: %s\n:ID: %s\n:END:\n" created id))

    ;; Fold the PROPERTIES drawer only
    (save-excursion
      (search-backward ":PROPERTIES:")
      (org-cycle))  ;; Fold drawer

    (forward-line -5)
    (end-of-line)
    (org-update-checkbox-count) ;; update progress
    (evil-insert-state)
    ))


(defun savolla/org-insert-header-with-todo ()
  "Go to the bottom of the file, insert an Org mode header with the a task, and place the cursor in insert mode."
  (interactive)
  (end-of-buffer)  ;; Move to the end of the buffer
  ;; (insert (format "* TODO "))  ;; Insert the header with the timestamp
  ;; (org-end-of-subtree)
  (org-insert-todo-heading "TODO")
  (evil-insert-state) ;; Enter insert state (if using Evil mode)
  )

(defun savolla/org-insert-repeated-scheduled-task ()
  (interactive)
  (end-of-buffer)  ;; Move to the end of the buffer
  (insert (format "* REPEAT "))
  (org-schedule '(org-timestamp))
  (evil-insert-state)
  )

(defun savolla/org-insert-repeated-deadline-task ()
  (interactive)
  (end-of-buffer)  ;; Move to the end of the buffer
  (insert (format "* REPEAT "))
  (org-deadline '(org-timestamp))
  (evil-insert-state)
  )

(defun savolla/org-insert-zettel ()
  "Insert a new zettel note into org-roam with export properties and front-matter."
  (interactive)
  (let ((hugo-dir "~/project/publishing/savolla.github.io")
        (org-date (format-time-string "<%Y-%m-%d %a>")))
    ;; Move to end of buffer and insert heading
    (goto-char (point-max))
    (insert "\n* :_z:\n")

    ;; Move to new heading
    (forward-line -1)
    (org-back-to-heading t)

    ;; Generate ID and set properties
    (org-id-get-create)
    (let ((id (org-entry-get nil "ID")))
      (when id
        ;; Set properties inside the drawer
        (org-set-property "EXPORT_FILE_NAME" id)
        (org-set-property "EXPORT_HUGO_SECTION" "zettel")

        ;; Move point to after :END: and insert front-matter
        (save-excursion
          (when (re-search-forward ":END:" nil t)
            (end-of-line)
            (insert (format "\n#+HUGO_BASE_DIR: %s" hugo-dir))
            (insert (format "\n#+DATE: %s" org-date))))))

    ;; Move point between '*' and ':_z:' for editing
    (org-back-to-heading t)
    (search-forward "* " (line-end-position))
    (evil-insert-state)))

(defun savolla/org-insert-contact ()
  "insert a new contact note into org-roam"
  (interactive)
  (end-of-buffer)  ;; move to the end of the buffer
  (insert (format "\n*  :contact:")) ;; create a heading with contact tag
  (insert (format "\n| phone | |"))
  (insert (format "\n| works | |"))
  (insert (format "\n| lives | |"))
  (insert (format "\n| birthday | |"))
  (forward-line -4) ;; go back to the first heading
  (forward-char 2) ;; position cursor between tag and heading
  (org-id-get-create) ;; create heading id so org-roam can find it
  (evil-insert-state) ;; entering in insert mode
  )


;; this causes issues in project workspaces when I kill a buffer with vterm
;; all the workspace kills itself.. completely delete or fix this. disabled for now
;; (defun savolla/kill-buffer-and-window ()
;;   "Kill the current buffer and delete its window if the buffer is a vterm buffer.
;;   Otherwise, just kill the current buffer."
;;   (interactive)
;;   (if (derived-mode-p 'vterm-mode)
;;       (let ((win (selected-window))) ;; Save current window before killing buffer
;;         (kill-buffer)
;;         (when (window-parameter win 'window-side)
;;           (delete-window win))
;;         (when (and (> (count-windows) 1)
;;                    (window-live-p win))
;;           (delete-window win)))
;;     ;; Not a vterm buffer: just kill the buffer
;;     (kill-buffer)))

;; rebuild nixos from emacs (exit if command was successful)
(defun savolla/nixos-rebuild ()
  "Run nixos-rebuild switch in a vterm and auto-close on success."
  (interactive)
  (let* ((buffer-name "*nixos-rebuild*")
         (vterm-buffer (get-buffer-create buffer-name)))
    ;; Create or switch to vterm buffer
    (pop-to-buffer vterm-buffer)
    (unless (eq major-mode 'vterm-mode)
      (vterm-mode))
    (vterm--goto-line -1)

    ;; Send wrapped shell command that will exit the shell on completion
    (vterm-send-string "rebuild-nixos; CODE=$?; exit $CODE")
    (vterm-send-return)

    ;; Attach a sentinel to the vterm process
    (let ((proc (get-buffer-process vterm-buffer)))
      (when proc
        (set-process-sentinel
         proc
         (lambda (process event)
           (when (and (memq (process-status process) '(exit signal)))
             (let ((exit-code (process-exit-status process))
                   (buf (process-buffer process)))
               (if (eq exit-code 0)
                   (when (and (buffer-live-p buf)
                              (get-buffer-window buf))
                     (kill-buffer buf)
                     (delete-window (get-buffer-window buf)))
                 (message "nixos-rebuild failed (exit code %d)" exit-code))))))))))

;; auto allow direnv .envrc files
(defun my/direnv-auto-allow ()
  "Auto-run `direnv allow` if .envrc exists and is blocked."
  (let ((envrc (locate-dominating-file default-directory ".envrc")))
    (when envrc
      (let ((default-directory envrc))
        (start-process "direnv-allow" nil "direnv" "allow")))))

(add-hook 'find-file-hook #'my/direnv-auto-allow)


;; workspace rotation
(defun savolla/rotate-workspace-clockwise ()
  (interactive)
  (evil-window-rotate-downwards)
  (other-window -1)
  )

(defun savolla/rotate-workspace-couter-clockwise ()
  (interactive)
  (evil-window-rotate-upwards)
  (other-window 1)
  )

(defun savolla/org-insert-repeated-deadline-task ()
  (interactive)
  (end-of-buffer)  ;; Move to the end of the buffer
  (insert (format "* REPEAT "))
  (org-deadline '(org-timestamp))
  (evil-insert-state)
  )


;; this is a very valuable function. it parses org-roam notes by tag and transcludes them
;; into separate files. it's like a logseq query function.
(defun savolla/org-roam-export-tagged-nodes-to-file (tag output-file)
  "Export all Org-roam nodes with TAG to OUTPUT-FILE, cleaning up heading tags and properties."
  (interactive
   (list
    (completing-read "Tag to export: " (savolla/org-roam-all-tags))
    (read-file-name "Export to file: " "~/")))
  (let ((nodes (org-roam-db-query
                [:select [id title file pos]
                 :from tags
                 :left-join nodes :on (= tags:node-id nodes:id)
                 :where (= tag $s1)]
                tag)))
    (with-temp-buffer
      (insert (mapconcat
               (lambda (row)
                 (let* ((file (nth 2 row))
                        (pos (nth 3 row)))
                   (with-temp-buffer
                     (insert-file-contents file)
                     (goto-char pos)
                     (org-back-to-heading t)
                     (let* ((beg (point))
                            (end (save-excursion (org-end-of-subtree t t)))
                            (content (buffer-substring-no-properties beg end)))
                       (with-temp-buffer
                         (insert content)
                         (goto-char (point-min))
                         ;; Remove tags from heading
                         ;; (when (re-search-forward "^\\(\\*+\\) \\(.*?\\)\\(:[[:alnum:]_@#%:]+:\\)[ \t]*$" nil t)
                         ;;   (replace-match (concat (match-string 1) " " (match-string 2)) t))
                         ;; Remove PROPERTIES drawer
                         (goto-char (point-min))
                         (while (re-search-forward "^:PROPERTIES:\n\\(?:\\(?:[^\n]*\\)\n\\)*?:END:\n?" nil t)
                           (replace-match ""))
                         (buffer-string))))))
               nodes
               ))
      (write-region (point-min) (point-max) output-file nil 'silent))
    (message "Org-roam nodes tagged :%s: exported to %s" tag output-file)))

(defun savolla/export-all-tagged-nodes ()
  "Export multiple Org-roam tag groups to their respective files."
  (interactive)
  (let ((exports `(
                   ("contact" . "~/resource/notes/org/sourced/contacts.org")
                   ("location" . "~/resource/notes/org/sourced/locations.org")
                   ("z"  . "~/resource/notes/org/sourced/zettelkasten.org")
                   ("resource" . "~/resource/notes/org/sourced/resources.org")
                   ("bookmark" . "~/resource/notes/org/sourced/bookmarks.org")
                   )))
    (dolist (entry exports)
      (let ((tag (car entry))
            (file (expand-file-name (cdr entry))))
        (savolla/org-roam-export-tagged-nodes-to-file tag file)))))


;; testing
(defun my/org-roam-ql-search-by-tag ()
  "Interactively pick a tag and run `org-roam-ql-search` on notes with that tag."
  (interactive)
  (let* ((all-tags (delete-dups (mapcan #'org-roam-node-tags (org-roam-node-list))))
         (tag (completing-read "Select tag: " all-tags nil t)))
    (org-roam-ql-search `(tags ,tag) (format "Notes tagged: %s" tag) "title-reverse")))

;; custom "popup" babel source code property. (test)
(defun my/org-babel-display-results-in-popup (result)
  "Display org-babel RESULT in a popup buffer on the right side and add all transclusions."
  (let ((buf (get-buffer-create "*Org Babel Result*")))
    (with-current-buffer buf
      (read-only-mode -1)
      (erase-buffer)
      (insert (if (stringp result) result (format "%S" result)))
      (goto-char (point-min))
      (org-mode)
      (org-transclusion-add-all) ;; Add transclusions in this popup buffer
      (org-content) ;; see only contents (reduce clutter)
      ;; (read-only-mode 1)
      )
    (display-buffer
     buf
     '((display-buffer-in-side-window)
       (side . right)
       (slot . 1)
       (window-width . 0.5)
       (window-parameters . ((no-other-window . t)
                             (no-delete-other-windows . t)))))))
(defun my/org-babel-eval-popup (orig-fun &rest args)
  "Advice to conditionally display org-babel results in popup buffer."
  (let* ((info (org-babel-get-src-block-info))
         (params (nth 2 info))
         (popup (cdr (assoc :popup params))))
    (if (and popup (not (string= popup "nil")))
        ;; Suppress result insertion
        (let ((orig-insert (symbol-function 'org-babel-insert-result)))
          (unwind-protect
              (progn
                ;; temporarily override insertion function
                (fset 'org-babel-insert-result
                      (lambda (&rest _args) nil))
                (let ((result (apply orig-fun args)))
                  (my/org-babel-display-results-in-popup result)))
            ;; restore the original function
            (fset 'org-babel-insert-result orig-insert)))
      ;; Normal behavior for blocks without :popup t
      (apply orig-fun args))))
(advice-add 'org-babel-execute-src-block :around #'my/org-babel-eval-popup)
