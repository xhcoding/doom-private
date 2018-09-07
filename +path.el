;;; config/private/+path.el -*- lexical-binding: t; -*-

(defconst +my-devtools-path
  (expand-file-name "Desktop/DevTools" (getenv "HOME")))


(when (string-equal system-type "windows-nt")
  (setenv "PATH"
          (concat
           (getenv "PATH")
           ";"
           (expand-file-name "cmake/bin" +my-devtools-path)
           ";"
           (expand-file-name "mingw64/bin" +my-devtools-path)
           ";"
           (expand-file-name "ripgrep" +my-devtools-path)
           ";"
           (expand-file-name "emacs/bin" +my-devtools-path)
           ";"
           (expand-file-name "cquery/build/LLVM-6.0.1-win64/bin" +my-devtools-path)
           ";"
           (expand-file-name "PortableGit/bin" +my-devtools-path)
           ";"
           (expand-file-name "PortableGit/usr/bin" +my-devtools-path)
           ))
  (setq exec-path (append (split-string (getenv "PATH") ";") (list "." exec-directory)))
  (add-hook 'eshell-mode-hook #'(lambda()(setq eshell-path-env (getenv "PATH"))))
  )
