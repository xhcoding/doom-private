;;; init.el -*- lexical-binding: t; -*-

;; 插件源 straight don't need it
;; (setq package-archives '(("gnu-cn"   . "http://elpa.emacs-china.org/gnu/")
;;                          ("melpa-cn" . "http://elpa.emacs-china.org/melpa/")
;;                          ("org-cn"   . "http://elpa.emacs-china.org/org/")))

;; 调试模式
(setq doom-debug-mode nil)

;; 扩展
(defvar +my-ext-dir (expand-file-name "~/.config/doom/extensions"))

;; Org文件
(defvar +my-org-dir (expand-file-name "~/Documents/Org/"))

;; 代码片段
(defvar +my-private-snippets-dir (expand-file-name "private/snippets/" +my-org-dir))

(setq user-full-name "xhcoding"
      user-mail-address "xhcoding@163.com")

(doom!
 :input

 :completion
 (company           ; the ultimate code completion backend
  +childframe
  +auto
  )
 (ivy               ; a search engine for love and life
  +fuzzy
  +childframe)

 :ui
 doom              ; what makes DOOM look the way it does
 doom-dashboard    ; a nifty splash screen for Emacs
 modeline     ; a snazzy Atom-inspired mode-line
 doom-quit         ; DOOM quit-message prompts when you quit Emacs
 hl-todo           ; highlight TODO/FIXME/NOTE tags
 nav-flash         ; blink the current line after jumping
 (window-select    ; visually switch windows
  +ace-window)
 vc-gutter         ; vcs diff in the fringe

 treemacs          ; a project drawer, like neotree but cooler
 (popup            ; tame sudden yet inevitable temporary windows
  +all
  +defaults)
 workspaces        ; tab emulation, persistence & separate workspaces
 ophints

 :editor
 (evil +everywhere); come to the dark side, we have cookies
 format            ; automated prettiness
 multiple-cursors  ; editing in many places at once
 fold
 snippets          ; my elves. They type so I don't have to

 :emacs
(dired             ; making dired pretty [functional]
 +icons
 +ranger
 )
 vc                ; version-control and Emacs, sitting in a tree

 :term
 vterm             ; another terminals in Emacs

 :checkers
 syntax              ; tasing you for every semicolon you forget

 :tools
 magit
 lsp
 eval              ; run code, run (also, repls)
 lookup           ; helps you navigate your code and documentation

 :lang
 (cc               ; C/C++/Obj-C madness
  +lsp)
 data              ; config/data formats
 emacs-lisp        ; drown in parentheses
 latex            ; writing papers in Emacs has never been so fun
 (org              ; organize your plain life in plain text
 +dragndrop       ; file drag & drop support
 +ipython         ; ipython support for babel
 +pandoc          ; pandoc integration into org's exporter
 +present)        ; using Emacs for presentations
 plantuml          ; diagrams for confusing people more
 (python
  +lsp)
 (markdown          ; writing docs for people to ignore
  +grip)
  (go
  +lsp)
 (javascript
  +lsp)
 (rust              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
  +lsp)
 qt
 scheme            ; a fully conniving family of lisps
 
 :config
 ;; The default module set reasonable defaults for Emacs. It also provides
 ;; a Spacemacs-inspired keybinding scheme, a custom yasnippet library,
 ;; and additional ex commands for evil-mode. Use it as a reference for
 ;; your own modules.
 (default +bindings +smartparens)

 :private
 my-cc
 my-blog
 my-chinese
 )
