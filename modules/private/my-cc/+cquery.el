;;; private/my-cc/+cquery -*- lexical-binding: t; -*-

(def-package! cquery
  :init
  (add-hook! (c-mode c++-mode) #'+my-cc/enable-lsp-or-irony)
  :config
  (setq cquery-executable (expand-file-name "cquery/build/release/bin/cquery.exe" +my-devtools-path)
  ))

(after! projectile
  (setq projectile-project-root-files-top-down-recurring
        (append '("compile_commands.json"
                  ".cquery")
                projectile-project-root-files-top-down-recurring))
  (add-to-list 'projectile-globally-ignored-directories ".cquery-cached-index"))
