;;; config/private/+ui.el -*- lexical-binding: t; -*-

(load! "+bindings")
(load! "+ui")
(load! "+org")

(when IS-WINDOWS
  (load! "+path"))

;; remove doom advice, I don't need deal with comments when newline
(advice-remove #'newline-and-indent #'doom*newline-and-indent)

(after! evil
  (setq evil-want-integration t))

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

(def-package! auto-save
  :load-path +my-ext-dir
  :init
  ;; 自动保存计时器
  (defvar +my-auto-save-timer t)
  :config
  (auto-save-enable)
  (setq auto-save-slient t))

(def-package! visual-regexp
  :commands (vr/query-replace vr/replace)
  )

(after! emacs-snippets
  (add-to-list 'yas-snippet-dirs +my-yas-snipper-dir))


(def-package! company-english-helper
  :commands (toggle-company-english-helper))

(def-package! company-posframe
  :if (display-graphic-p)
  :after company
  :hook (company-mode . company-posframe-mode))


(def-package! scroll-other-window
  :load-path +my-ext-dir
  :config
  (sow-mode 1)
  (map!
   :gnvime "<M-up>"    #'sow-scroll-other-window-down
   :gnvime "<M-down>"  #'sow-scroll-other-window))


(def-package! openwith
  :load-path +my-ext-dir
  :config
  (setq openwith-associations
        '(
          ("\\.pdf\\'" "okular" (file))
          ("\\.docx?\\'" "wps" (file))
          ("\\.pptx?\\'" "wpp" (file))
          ("\\.xlsx?\\'" "et" (file))))
  (add-hook! :append 'emacs-startup-hook #'openwith-mode))

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

(set-popup-rules!
  '(("^\\*helpful" :size 0.6)
    ("^\\*info\\*$" :size 0.6)
    ("^\\*.*Octave\\*$" :size 0.5 :side right)
    ("^\\*Python*\\*$" :size 0.5 :side right)
    ("^\\*doom \\(?:term\\|eshell\\)" :size 0.5 :side right)))

(set-lookup-handlers! 'emacs-lisp-mode :documentation #'helpful-at-point)

(set-company-backend! '(yaml-mode cmake-mode) 'company-dabbrev)

(after! format
  (set-formatter!
    'clang-format
    '("clang-format"
      ("-assume-filename=%S" (or (buffer-file-name) ""))
      "-style=Google"))
  :modes
  '((c-mode ".c")
    (c++-mode ".cpp")
    (java-mode ".java")
    (objc-mode ".m")
    ))

(after! ws-butler
  (setq ws-butler-global-exempt-modes
        (append ws-butler-global-exempt-modes
                '(prog-mode))))
