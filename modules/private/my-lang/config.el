;;; private/my-lang/config.el -*- lexical-binding: t; -*-

(def-package! google-c-style
  :config
  (add-hook! (c-mode c++-mode) #'google-set-c-style))

(after! cc-mode
  (map!
   (:map c-mode-base-map
     :i "C-j" #'+my-lang/cc-newline
     :i "M-j" #'+my-lang/cc-jump-out-structure)))

(def-package! ccls
  :init
  (add-hook! (c-mode c++-mode) #'+my-lang/enable-ccls-or-irony)
  :config
  ;; overlay is slow
  ;; Use https://github.com/emacs-mirror/emacs/commits/feature/noverlay
  (setq ccls-sem-highlight-method 'font-lock)
  (ccls-use-default-rainbow-sem-highlight)
  (setq ccls-executable "/usr/bin/ccls")
  ;;(setq ccls-extra-args '("--log-file=/tmp/cq.log"))
  (setq ccls-extra-init-params '(
                                 :completion (:detailedLabel t)
                                 :diagnostics (:frequencyMs 5000)
                                 :index (:reparseForDependency 1)))
  )

(after! projectile
  (setq projectile-project-root-files-top-down-recurring
        (append '("compile_commands.json"
                  ".ccls_root")
                projectile-project-root-files-top-down-recurring))
  (add-to-list 'projectile-globally-ignored-directories ".ccls-cache"))

(def-package! cmake-project
  :load-path +my-site-lisp-dir
  :config
  (add-hook! (c-mode c++-mode) #'cp-load-all)
  (setq cp-default-run-terminal-buffer "*doom eshell*")
  (map!
   (:mode (c-mode c++-mode)
     :gnvime "<f7>" #'cp-cmake-build-project
     :gnvime "<f8>" #'cp-cmake-run-project-with-args)))

(def-package! lsp-python
  :after python
  :init
  (add-hook! 'python-mode-hook #'lsp-python-enable)
  :config
  (map!
   (:map python-mode-map
     :gnvime "C-M-\\" #'lsp-format-buffer))
  )

(def-package! lsp-java
  :init
  (add-hook! java-mode #'+my-lang-lsp-java-enable)
  :config
  (setq lsp-java-server-install-dir
        (expand-file-name (concat doom-etc-dir "eclipse.jdt.ls/server/")))
  (setq lsp-java-workspace-dir
        (expand-file-name (concat doom-etc-dir "java/workspace/")))
  )


(after! latex
  (add-hook 'LaTeX-mode-hook
            (lambda!()
                    (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex --synctex=1 %(mode)%' %t" TeX-run-TeX nil t))
                    (setq TeX-command-default "XeLaTeX"))))

(after! lsp-ui
  (set-lookup-handlers! '(c-mode c++-mode java-mode python-mode)
    :definition #'lsp-ui-peek-find-definitions
    :references #'lsp-ui-peek-find-references))

(after! octave
  (add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
  )

(after! realgud
  (setq realgud-safe-mode nil))
