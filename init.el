;;; init.el -*- lexical-binding: t; -*-

;; 插件源
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")
			             ("org"   . "http://elpa.emacs-china.org/org/")))

;; 载入与个人非常相关的配置
(load! "+self.el")

(doom!
 :feature
 debugger
 eval              ; run code, run (also, repls)
 (evil +everywhere); come to the dark side, we have cookies
 lookup           ; helps you navigate your code and documentation
 snippets          ; my elves. They type so I don't have to
 (syntax-checker   ; tasing you for every semicolon you forget
  +childframe
  )
 workspaces        ; tab emulation, persistence & separate workspaces

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
 doom-modeline     ; a snazzy Atom-inspired mode-line
 doom-quit         ; DOOM quit-message prompts when you quit Emacs
 hl-todo           ; highlight TODO/FIXME/NOTE tags
 nav-flash         ; blink the current line after jumping
 evil-goggles      ; display visual hints when editing in evil
 (window-select    ; visually switch windows
  +ace-window)

 treemacs          ; a project drawer, like neotree but cooler
 (popup            ; tame sudden yet inevitable temporary windows
  +all
  +defaults)

 :editor
 format            ; automated prettiness
 multiple-cursors  ; editing in many places at once

 :emacs
 dired             ; making dired pretty [functional]
 ediff             ; comparing files in Emacs
 ;; eshell            ; a consistent, cross-platform shell (WIP)
 hideshow          ; basic code-folding support
 imenu             ; an imenu sidebar and searchable code index
 vc                ; version-control and Emacs, sitting in a tree

 :tools
 magit

 :lang
 assembly          ; assembly for fun or debugging
 cc               ; C/C++/Obj-C madness
 data              ; config/data formats
 emacs-lisp        ; drown in parentheses
 (latex            ; writing papers in Emacs has never been so fun
  )
 (org              ; organize your plain life in plain text
  +attach          ; custom attachment system
  +babel           ; running code in org
  +capture         ; org-capture in and outside of Emacs
  +export          ; Exporting org to whatever you want
  +present         ; Emacs for presentations
  )
 javascript        ; all(hope(abandon(ye(who(enter(here))))))
 plantuml          ; diagrams for confusing people more
 (python            ; beautiful is better than ugly
  +pyvenv
  )
 web               ; the tubes

 :app

 :collab

 :config
 ;; The default module set reasonable defaults for Emacs. It also provides
 ;; a Spacemacs-inspired keybinding scheme, a custom yasnippet library,
 ;; and additional ex commands for evil-mode. Use it as a reference for
 ;; your own modules.
 (default +bindings +snippets +evil-commands)

 :private
 lsp
 my-cc
 my-blog
 )
