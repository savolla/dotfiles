;; tailwind lsp
(package! lsp-tailwindcss :recipe
  (:type git
   :host github
   :repo "merrickluo/lsp-tailwindcss"))


;; enable transparency in tui mode
(package! solaire-mode :disable t)


;; org packages
(package! org-ql) ;; filter your org files
(package! org-roam-ql) ;; logseq queries in org-mode
(package! org-transclusion) ;; transclusion in org mode
(package! ob-mermaid) ;; add mermaid support to org-babel
(package! org-auto-tangle) ;; org mode automatic tangle on save
(package! engrave-faces) ;; latex export code blocks with highlight
(package! org-anki) ;; enable anki integration in org mode
(package! org-sticky-header) ;; see the current context while editing


;; rss
;; (doom's init.el rss flag does not work)
(package! elfeed)
(package! elfeed-org)
(package! elfeed-tube)
(package! elfeed-tube-mpv)
(package! elfeed-goodies) ;; better elfeed experience
