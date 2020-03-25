;;; config/private/+ui.el -*- lexical-binding: t; -*-

(load! "+bindings")
(load! "+ui")
(load! "+org")

;; remove doom advice, I don't need deal with comments when newline
(advice-remove #'newline-and-indent #'doom*newline-indent-and-continue-comments)


;; Reconfigure packages
(after! evil-escape
  (setq evil-escape-key-sequence "jk"))


(after! projectile
  (setq compilation-read-command nil)  ; no prompt in projectile-compile-project
  (projectile-register-project-type 'cmake '("CMakeLists.txt")
                                    :configure "cmake %s"
                                    :compile "cmake --build Debug"
                                    :test "ctest")

  (setq projectile-require-project-root t)
  (setq projectile-project-root-files-top-down-recurring
        (append '("compile_commands.json")
                projectile-project-root-files-top-down-recurring)))

(after! company
  (setq company-minimum-prefix-length 1
        company-idle-delay 0
        company-tooltip-limit 10
        company-show-numbers t
        company-global-modes '(not comint-mode erc-mode message-mode help-mode gud-mode)
        ))

(after! company-box
  (setq company-box-doc-enable nil))


(after! yasnippet
  (add-to-list 'yas-snippet-dirs #'+my-private-snippets-dir nil #'eq))

(after! grip
  (setq grip-github-user "xhcoding")
  (setq grip-github-password "fd0074706311dc0edb162d78f328a2e32b0f7ab3"))


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
                '(prog-mode org-mode))))


(after! tex
  (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil t))
  (setq-hook! LaTeX-mode TeX-command-default "XeLaTex")

  (setq TeX-save-query nil)

  (when (fboundp 'eaf-open)
    (add-to-list 'TeX-view-program-list '("eaf" TeX-eaf-sync-view))
    (add-to-list 'TeX-view-program-selection '(output-pdf "eaf"))))



(after! eshell
  (setq eshell-directory-name (expand-file-name "eshell" doom-etc-dir)))

(global-auto-revert-mode 0)

(after! lsp
  (add-to-list 'lsp-file-watch-ignored "[/\\\\]build" )
  (setq +lsp-company-backend 'company-capf))

(after! lsp-ui
  (add-hook! 'lsp-ui-mode-hook #'lsp-ui-doc-mode)
  (setq
   lsp-ui-doc-use-webkit nil
   lsp-ui-doc-max-height 20
   lsp-ui-doc-max-width 50
   lsp-ui-sideline-enable nil
   lsp-ui-peek-always-show t)
  (map!
   :map lsp-ui-peek-mode-map
   "h" #'lsp-ui-peek--select-prev-file
   "j" #'lsp-ui-peek--select-next
   "k" #'lsp-ui-peek--select-prev
   "l" #'lsp-ui-peek--select-next-file))

(after! ccls
  (setq ccls-initialization-options `(:cache (:directory ,(expand-file-name "~/Code/ccls_cache"))
                                             :compilationDatabaseDirectory "build"))

  (setq ccls-sem-highlight-method 'font-lock)
  (ccls-use-default-rainbow-sem-highlight)
  (evil-set-initial-state 'ccls-tree-mode 'emacs))


(use-package! visual-regexp
  :commands (vr/query-replace vr/replace))

(use-package! package-lint
  :commands (package-lint-current-buffer))

(use-package! auto-save
  :load-path +my-ext-dir
  :config
  (setq +my-auto-save-timer nil)
  (setq auto-save-slient t))


(use-package! company-english-helper
  :commands (toggle-company-english-helper))


(use-package! openwith
  :load-path +my-ext-dir
  :config
  (setq openwith-associations
        '(
          ("\\.pdf\\'" "okular" (file))
          ("\\.docx?\\'" "wps" (file))
          ("\\.pptx?\\'" "wpp" (file))
          ("\\.xlsx?\\'" "et" (file))))
  (add-hook! 'emacs-startup-hook :append #'openwith-mode))

(use-package! awesome-tab
  :config
  (awesome-tab-mode +1)
  (setq awesome-tab-height 100)
  (defhydra awesome-fast-switch (:hint nil)
    "
 ^^^^Fast Move             ^^^^Tab                    ^^Search            ^^Misc
-^^^^--------------------+-^^^^---------------------+-^^----------------+-^^---------------------------
   ^_k_^   prev group    | _C-a_^^     select first | _b_ search buffer | _C-k_   kill buffer
 _h_   _l_  switch tab   | _C-e_^^     select last  | _g_ search group  | _C-S-k_ kill others in group
   ^_j_^   next group    | _C-j_^^     ace jump     | ^^                | ^^
 ^^0 ~ 9^^ select window | _C-h_/_C-l_ move current | ^^                | ^^
-^^^^--------------------+-^^^^---------------------+-^^----------------+-^^---------------------------
"
    ("h" awesome-tab-backward-tab)
    ("j" awesome-tab-forward-group)
    ("k" awesome-tab-backward-group)
    ("l" awesome-tab-forward-tab)
    ("0" my-select-window)
    ("1" my-select-window)
    ("2" my-select-window)
    ("3" my-select-window)
    ("4" my-select-window)
    ("5" my-select-window)
    ("6" my-select-window)
    ("7" my-select-window)
    ("8" my-select-window)
    ("9" my-select-window)
    ("C-a" awesome-tab-select-beg-tab)
    ("C-e" awesome-tab-select-end-tab)
    ("C-j" awesome-tab-ace-jump)
    ("C-h" awesome-tab-move-current-tab-to-left)
    ("C-l" awesome-tab-move-current-tab-to-right)
    ("b" ivy-switch-buffer)
    ("g" awesome-tab-counsel-switch-group)
    ("C-k" kill-current-buffer)
    ("C-S-k" awesome-tab-kill-other-buffers-in-current-group)
    ("q" nil "quit"))
  (map!
   :i   "C-c t" #'awesome-tab-ace-jump
   :i   "C-c T" #'awesome-fast-switch/body
   (:leader
     (:prefix "c"
       :desc "switch tab"         :nv    "t" #'awesome-tab-ace-jump
       :desc "switch tab hydra"    :nv   "T" #'awesome-fast-switch/body)))
  )


(use-package! color-rg
  :config
  (evil-set-initial-state 'color-rg-mode 'emacs))

(use-package! eaf
  :when IS-LINUX
  :load-path "/home/xhcoding/Code/ELisp/emacs-application-framework/"
  :config
  (evil-set-initial-state 'eaf-mode 'emacs)
  (require 'seq)
  (setq process-environment (seq-filter
                             (lambda(var)
                               (and (not (string-match-p "QT_SCALE_FACTOR" var))
                                    (not (string-match-p "QT_SCREEN_SCALE_FACTOR" var)))) process-environment))

  (eaf-setq eaf-browser-default-zoom  "2")
  (set-popup-rule! "^\\*color" :size 0.5))

(after! pyim
  (setq pyim-page-tooltip 'posframe)

  (setq-default pyim-english-input-switch-functions
                '(
                  pyim-probe-dynamic-english
                  pyim-probe-isearch-mode
                  pyim-probe-program-mode
                  pyim-probe-org-structure-template))

  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))

  (map! :gnvime
        "M-l" #'pyim-convert-string-at-point))

(after! geiser
  (setq-default geiser-default-implementation 'chez))

(use-package! keyfreq)

(use-package! evil-matchit)

(use-package! nsis-mode
  :mode ("\.[Nn][Ss][HhIi]\'". nsis-mode))

(use-package! groovy-mode
  :mode ("\.groovy\'" . groovy-mode))

;; server
(setq server-auth-dir (expand-file-name doom-etc-dir))
(setq server-name "emacs-server-file")
(server-start)

(when (eq system-type 'windows-nt)
  (setq locale-coding-system 'gb18030)  ;此句保证中文字体设置有效
  (setq w32-unicode-filenames 'nil)       ; 确保file-name-coding-system变量的设置不会无效
  (setq file-name-coding-system 'gb18030) ; 设置文件名的编码为gb18030
  )

(toggle-frame-fullscreen)
