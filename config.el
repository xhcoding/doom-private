;;; config/private/+ui.el -*- lexical-binding: t; -*-
(load! "+bindings")
(load! "+ui")
(load! "+org")


;; remove doom advice, I don't need deal with comments when newline
(advice-remove #'newline-and-indent #'doom*newline-and-indent)

;; Reconfigure packages
(after! evil-escape
  (setq evil-escape-key-sequence "jk"))

(after! projectile
  (setq projectile-require-project-root t))

(after! company
  (setq company-minimum-prefix-length 2
        company-tooltip-limit 10
        company-show-numbers t
        company-global-modes '(not comint-mode erc-mode message-mode help-mode gud-mode)
        )
  (map! :map company-active-map
        "M-g" #'company-abort
        "M-d" #'company-next-page
        "M-u" #'company-previous-page))


(def-package! lsp-mode
  :config
  (setq lsp-project-blacklist '("^/usr/")
        lsp-highlight-symbol-at-point nil)
  (add-hook 'lsp-after-open-hook 'lsp-enable-imenu))

(def-package! company-lsp
  :after company
  :init
  (setq company-lsp-cache-candidates nil)
  :config
  (set-company-backend! 'lsp-mode 'company-lsp))

(def-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-enable nil
        lsp-ui-sideline-show-symbol nil
        lsp-ui-sideline-show-symbol nil
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-doc-max-width 50
        )
  (map!
   :map lsp-ui-peek-mode-map
   "h" #'lsp-ui-peek--select-prev-file
   "j" #'lsp-ui-peek--select-next
   "k" #'lsp-ui-peek--select-prev
   "l" #'lsp-ui-peek--select-next-file
   ))


(def-package! auto-save
  :load-path +my-site-lisp-dir
  :config
  (setq auto-save-slient t))

(def-package! visual-regexp
  :config
  (require 'visual-regexp))

(after! emacs-snippets
  (add-to-list 'yas-snippet-dirs +my-yas-snipper-dir))


(after! smartparens
  (define-advice show-paren-function (:around (fn) fix-show-paren-function)
    "Highlight enclosing parens"
    (cond ((looking-at-p "\\s(") (funcall fn))
	      (t (save-excursion
		       (ignore-errors (backward-up-list))
		       (funcall fn)))))
  (sp-local-pair 'cc-mode "(" nil :actions nil)
  (sp-local-pair 'cc-mode "[" nil :actions nil)
  )


(def-package! company-english-helper
  :config
  (map!
   (:leader
     (:prefix "t"
       :n     "e"     #'toggle-company-english-helper))))

(def-package! company-posframe
  :if (display-graphic-p)
  :after company
  :hook (company-mode . company-posframe-mode))



(def-package! scroll-other-window
  :load-path +my-site-lisp-dir
  :config
  (sow-mode 1)
  (map!
   :gnvime "<M-up>"    #'sow-scroll-other-window-down
   :gnvime "<M-down>"  #'sow-scroll-other-window))


(def-package! openwith
  :load-path +my-site-lisp-dir
  :config
  (setq openwith-associations
        '(
          ("\\.pdf\\'" "okular" (file))
          ("\\.docx?\\'" "wps" (file))
          ("\\.pptx?\\'" "wpp" (file))
          ("\\.xlsx?\\'" "et" (file))))
  (add-hook! :append 'emacs-startup-hook #'openwith-mode)
  )

(def-package! isolate
  :config
  (add-to-list 'isolate-pair-list
               '(
                 (from . "os-\\(.*\\)=")
                 (to-left . (lambda(from)
                              (format "#+BEGIN_SRC %s\n" (match-string 1 from))))
                 (to-right . "\n#+END_SRC\n")
                 (condition . (lambda (_) (equal major-mode 'org-mode)))
                 )))

(def-package! color-rg
  )


(set-popup-rules!
  '(("^\\*helpful" :size 0.6)
    ("^\\*info\\*$" :size 0.6)
    ("^\\*.*Octave\\*$" :size 0.5 :side right)
    ("^\\*Python*\\*$" :size 0.5 :side right)
    ("^\\*doom \\(?:term\\|eshell\\)" :size 0.5 :side right)))

(set-lookup-handlers! 'emacs-lisp-mode :documentation #'helpful-at-point)

(set-company-backend! '(yaml-mode cmake-mode) 'company-dabbrev)

(set-formatter!
  '((c-mode ".c")
    (c++-mode ".cpp")
    (java-mode ".java")
    (objc-mode ".m")
    )
  '("clang-format"
    ("-assume-filename=%S" (or (buffer-file-name) ""))
    "-style=Google"))
