;;; private/my-cc/config.el -*- lexical-binding: t; -*-

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; TODO: refactor
(use-package! cmake-project
  :commands (cp-project-refresh cp-project-new cp-project-debug)
  :config
  (add-hook! (c-mode c++-mode) #'cp-project-refresh)
  (defun +my-cc-gen-template()
    (concat
     (format "cmake_minimum_required(VERSION %s)" cp-cmake-minimum-version)
     (format "\nset(PROJECT_NAME \"%s\")" (file-name-nondirectory (directory-file-name cp-project-root-cache)))
     (format "\nproject(${PROJECT_NAME})")
     (format "\nset(CMAKE_EXPORT_COMPILE_COMMANDS ON)")
     (format  "\nset(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)")
     (format "\nset(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)")
     (format "\n\nadd_executable(main main.cpp)")
     ))
  (setq cp-project-template-function '+my-cc-gen-template)
  (map!
   (:mode (c-mode c++-mode)
     :gnvime "<f7>" #'cp-project-build
     :gnvime "<f8>" #'cp-project-run)))

(after! realgud
  (setq realgud-safe-mode nil))

(use-package! my-work-c-style
  :load-path +my-ext-dir
  :config
  (add-hook! (c-mode c++-mode) #'my-work-set-c-style))
