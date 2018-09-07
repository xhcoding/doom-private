;;; private/my-cc/init.el -*- lexical-binding: t; -*-


;; if lsp-mode enabled failed ,using irony instead
(def-package-hook! irony
  :pre-init
  ;; Windows performance tweaks
  ;;
  (when (boundp 'w32-pipe-read-delay)
    (setq w32-pipe-read-delay 0))
  ;; Set the buffer size to 64K on Windows (from the original 4K)
  (when (boundp 'w32-pipe-buffer-size)
    (setq irony-server-w32-pipe-buffer-size (* 64 1024)))
  nil)

(def-package-hook! flycheck-irony
  :pre-init
  nil
  :pre-config
  nil)
