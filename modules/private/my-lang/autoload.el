;;; private/my-lang/autoload.el -*- lexical-binding: t; -*-


;;;###autoload
(defun +my-lang/cc-newline()
  "Insert semicolon at end of line, and `newline-and-indent'"
  (interactive)
  (end-of-line)
  (delete-trailing-whitespace)
  (when (not (equal (char-before) 59))
    (insert ";"))
  (newline-and-indent))

;;;autoload
(defun +my-lang/cc-jump-out-structure()
  "Jump to `)}]'"
  (interactive)
  (ignore-errors
    (search-forward-regexp "[])}]")))

;;;###autoload
(defun +my-lang/enable-ccls-or-irony ()
  "Enable ccls, otherwise enable irony"
  (interactive)
  (condition-case nil
      (lsp-ccls-enable)
    (user-error
     (irony-mode +1))))

;;;###autoload
(defun ccls/base () (interactive) (lsp-ui-peek-find-custom 'base "$ccls/base"))

;;;###autoload
(defun ccls/callers () (interactive) (lsp-ui-peek-find-custom 'callers "$ccls/callers"))

;;;###autoload
(defun ccls/derived () (interactive) (lsp-ui-peek-find-custom 'derived "$ccls/derived"))

;;;###autoload
(defun ccls/vars () (interactive) (lsp-ui-peek-find-custom 'vars "$ccls/vars"))

;;;###autoload
(defun ccls/random () (interactive) (lsp-ui-peek-find-custom 'random "$ccls/random"))

;;;###autoload
(defun +my-lang-lsp-java-enable ()
  (let ((lsp-inhibit-message t))
    (ignore-errors (lsp-java-enable)))
  )
