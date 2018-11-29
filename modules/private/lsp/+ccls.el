;;; private/my-cc/+ccls -*- lexical-binding: t; -*-

(def-package! ccls
  :init
  (add-hook! (c-mode c++-mode) #'+my-cc/enable-lsp-or-irony)
  :config

  ;; default is "ccls"
  ;; (setq ccls-executable "/usr/bin/ccls")
  ;; overlay is slow
  ;; Use https://github.com/emacs-mirror/emacs/commits/feature/noverlay
  ;; (add-hook 'lsp-after-open-hook #'ccls-code-lens-mode)
  ;; (setq ccls-sem-highlight-method 'font-lock)
  ;; (ccls-use-default-rainbow-sem-highlight)

  ;; https://github.com/MaskRay/ccls/wiki/Initialization-options
  (setq
   ccls-extra-init-params
   `(:clang
     (:extraArgs [,(concat "--gcc-toolchain=" (+my-cc/gcc-toolchain))])))

  (evil-set-initial-state 'ccls-tree-mode 'emacs)

  (after! projectile
    (setq projectile-project-root-files-top-down-recurring
          (append '("compile_commands.json"
                    ".ccls_root")
                  projectile-project-root-files-top-down-recurring))
    (add-to-list 'projectile-globally-ignored-directories ".ccls-cache"))

  )
