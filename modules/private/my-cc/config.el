;;; private/my-cc/config.el -*- lexical-binding: t; -*-

(if IS-WINDOWS
    (load! "+cquery")
  (load! "+ccls"))

(def-package! google-c-style
  :config
  (add-hook! (c-mode c++-mode) #'google-set-c-style))

(after! cc-mode
  (map!
   (:map c-mode-base-map
     :i "C-j" #'+my-cc/cc-newline
     :i "M-j" #'+my-cc/cc-jump-out-structure)))

(def-package! cmake-project
  :load-path +my-ext-dir
  :config
  (add-hook! (c-mode c++-mode) #'cp-load-all)
  (setq cp-default-run-terminal-buffer "*doom eshell*")
  (map!
   (:mode (c-mode c++-mode)
     :gnvime "<f7>" #'cp-cmake-build-project
     :gnvime "<f8>" #'cp-cmake-run-project-with-args)))

(after! realgud
  (setq realgud-safe-mode nil))
