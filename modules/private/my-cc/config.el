;;; private/my-cc/config.el -*- lexical-binding: t; -*-

(def-package! google-c-style
  :config
  (add-hook! (c-mode c++-mode) #'google-set-c-style))

(after! cc-mode
  (map!
   (:map c-mode-base-map
     :i "C-j" #'+my-cc/cc-newline
     :i "M-j" #'+my-cc/cc-jump-out-structure)))

(def-package! cmake-project
  :after cc-mode
  :load-path +my-ext-dir
  :config
  (map!
   (:mode (c-mode c++-mode)
     :gnvime "<f7>" #'cp-project-build-project)))

(after! realgud
  (setq realgud-safe-mode nil))
