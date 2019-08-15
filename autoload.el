;;;  -*- lexical-binding: t; -*-

;;;###autoload
(defun +my/better-font()
  "Changing font to better."
  (interactive)
  ;; english font
  (if (display-graphic-p)
      (progn
        (set-face-attribute 'default nil :font (format   "%s:pixelsize=%d" "Source Code Pro" 17)) ;; 11 13 17 19 23
        ;; chinese font
        (dolist (charset '(kana han symbol cjk-misc bopomofo))
          (set-fontset-font (frame-parameter nil 'font)
                            charset
                            (font-spec :family "WenQuanYi Micro Hei Mono" :size 20)))))) ;; 14 16 20 22 28

;;;###autoload
(defun +my/toggle-cycle-theme ()
  "Cycle through themes defined in `+my-themes.'"
  (interactive)
  (when doom-theme
    ;; if current theme isn't in cycleable themes, start over
    (setq +my--cycle-themes
          (or (cdr (memq doom-theme +my-themes))
              +my-themes)))
  (setq doom-theme (pop +my--cycle-themes))
  (doom/reload-theme))

;;;###autoload
(defun +my--support-format-p()
  (and (featurep! :editor format)
       (memq major-mode '(c-mode c++-mode emacs-lisp-mode java-mode python-mode))))

;;;###autoload
(defun +my/indent-buffer()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))


;;;###autoload
(defun +my/indent-region-or-buffer(&optional beg end)
  "Indent a region if selected, otherwise the whole buffer."
  (interactive "r")
  (save-excursion
    (if (use-region-p)
        (indent-region beg end)
      (+my/indent-buffer)
      )))

;;;###autoload
(defun +my/indent-or-format(&optional beg end)
  (interactive "r")
  (if (+my--support-format-p)
      (progn
        (+format/region-or-buffer)
        (message "formated"))
    (progn
      (+my/indent-region-or-buffer beg end)
      (message "indented"))))

;;;###autoload
(defun +my/toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(85 . 50) '(100 . 100)))))

;;;###autoload
(defun +my/toggle-auto-save()
  (interactive)
  (if +my-auto-save-timer
      (progn
        (cancel-timer +my-auto-save-timer)
        (setq +my-auto-save-timer nil)
        (message "auto save disabled."))
    (progn (setq +my-auto-save-timer (auto-save-enable))
           (message "auto save enabled."))))

;;;###autoload
(defun +my/rename-this-file-and-buffer (new-name)
  "Rename both current buffer and file it's visiting to NEW_NAME"
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (unless filename
      (error "Buffer '%s' is not visiting a file" name))
    (progn
      (when (file-exists-p filename)
        (rename-file filename new-name 1))
      (set-visited-file-name new-name)
      (rename-buffer new-name))))

;;;###autoload
(defun +my--replace-pairs(content pairs &optional to-direction)
  "replace pairs in `content'"
  (when (or (not to-direction) (string= to-direction "auto"))
    (setq to-direction
          (if (catch 'break
                (mapc
                 (lambda (pair)
                   (if (string-match (aref pair 0) content)
                       (throw 'break t))) pairs)
                nil)
              "positive"
            "negative")))
  (with-temp-buffer
    (insert content)
    (mapc
     (lambda (pair)
       (goto-char (point-min))
       (while (search-forward-regexp (elt pair 0) nil "noerrro")
         (replace-match (elt pair 1))))
     (cond
      ((string= to-direction "positive")
       pairs)
      ((string= to-direction "negative")
       (mapcar
        (lambda(pair)
          (vector (elt pattern 1) (elt pattern 0))) pairs))
      (t
       (user-error "Your 3rd argument %s is invalid" to-direction))))
    (buffer-string)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.nas\\'" . nasm-mode))

;; from TeX-pdf-tools-sync-view
;;;###autoload
(defun TeX-eaf-sync-view()
  (unless (fboundp 'eaf-open)
    (error "EAF is not available!"))
  (let* ((pdf (concat file "." (TeX-output-extension)))
         (url (expand-file-name pdf))
         (app-name "pdfviewer")
         (exists-eaf-buffer)
         (eaf-buffer-window))
    (catch 'found-match-buffer
      (dolist (buffer (buffer-list))
        (set-buffer buffer)
        (when (equal major-mode 'eaf-mode)
          (when (and (string= buffer-url url)
                     (string= buffer-app-name app-name))
            (setq exists-eaf-buffer buffer)
            (setq eaf-buffer-window (get-buffer-window exists-eaf-buffer))
            (throw 'found-match-buffer t)))))
    (if (and exists-eaf-buffer eaf-buffer-window)
        (pop-to-buffer exists-eaf-buffer)
      (eaf-open url app-name "--synctex_on=True"))))

