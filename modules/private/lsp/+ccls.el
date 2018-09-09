;;; private/my-cc/+ccls -*- lexical-binding: t; -*-

(def-package! ccls
  :init
  (add-hook! (c-mode c++-mode) #'+my-cc/enable-lsp-or-irony)
  :config
  ;; overlay is slow
  ;; Use https://github.com/emacs-mirror/emacs/commits/feature/noverlay
  (setq ccls-sem-highlight-method 'font-lock)
  (ccls-use-default-rainbow-sem-highlight)
  (setq ccls-executable "/usr/bin/ccls")
  (setq ccls-extra-init-params '(
                                 :completion (:detailedLabel t)
                                 :diagnostics (:frequencyMs 5000)
                                 :index (:reparseForDependency 1))))

(after! projectile
  (setq projectile-project-root-files-top-down-recurring
        (append '("compile_commands.json"
                  ".ccls_root")
                projectile-project-root-files-top-down-recurring))
  (add-to-list 'projectile-globally-ignored-directories ".ccls-cache"))
