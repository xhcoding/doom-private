;;; private/my-cc/+ccls -*- lexical-binding: t; -*-

(def-package! ccls
  :init
  (add-hook! (c-mode c++-mode) #'+my-cc/enable-lsp-or-irony)
  :config
  ;; overlay is slow
  ;; Use https://github.com/emacs-mirror/emacs/commits/feature/noverlay
  ;; (add-hook 'lsp-after-open-hook #'ccls-code-lens-mode)
  ;; (setq ccls-sem-highlight-method 'font-lock)
  ;; (ccls-use-default-rainbow-sem-highlight)
  (setq ccls-executable "/usr/bin/ccls")
  (setq
   ccls-extra-init-params
   `(:clang (:extraArgs ["--gcc-toolchain=/usr"]
                        :pathMappings ,+ccls-path-mappings)
            :completion
            (:include
             (:blacklist
              ["^/usr/(local/)?include/c\\+\\+/[0-9\\.]+/(bits|tr1|tr2|profile|ext|debug)/"
               "^/usr/(local/)?include/c\\+\\+/v1/"
               ]))
            :index (:initialBlacklist ,+ccls-initial-blacklist :trackDependency 1)))

  (evil-set-initial-state 'ccls-tree-mode 'emacs)
  )

(after! projectile
  (setq projectile-project-root-files-top-down-recurring
        (append '("compile_commands.json"
                  ".ccls_root"
                  ".git")
                projectile-project-root-files-top-down-recurring))
  (add-to-list 'projectile-globally-ignored-directories ".ccls-cache"))
