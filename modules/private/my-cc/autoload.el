;;; private/my-cc/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +my-cc/cc-newline()
  "Insert semicolon at end of line, and `newline-and-indent'"
  (interactive)
  (end-of-line)
  (delete-trailing-whitespace)
  (when (not (equal (char-before) 59))
    (insert ";"))
  (newline-and-indent))

;;;autoload
(defun +my-cc/cc-jump-out-structure()
  "Jump to `)}]'"
  (interactive)
  (ignore-errors
    (search-forward-regexp "[])}]")))
