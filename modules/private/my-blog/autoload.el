;;; private/my-blog/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +my-blog/open-org-octopress()
  (interactive)
  (let ((buffer (get-buffer "Octopress")))
    (if buffer
        (switch-to-buffer buffer)
      (org-octopress))))

;;;###autoload
(defun +my-blog*export-blog-image-url(filename)
  (if (equal
       (string-match-p
        (regexp-quote (expand-file-name +my-blog-root-dir))
        (expand-file-name filename))
       0)
      (concat  +my-blog-image-url (string-trim-left filename +my-blog-img-dir))
    nil))


;;;###autoload
(defun +my-blog*easy-hugo--org-headers (file)
  "Return a draft org mode header string for a new article as FILE."
  (let ((date
          (format-time-string "%Y-%m-%d")))
    (concat
     "#+HUGO_BASE_DIR: ../"
     "\n#+HUGO_SECTION: post"
     "\n#+TITLE: " file
     "\n#+DATE: " date
     "\n#+AUTHOR:"
     "\n#+HUGO_CUSTOM_FRONT_MATTER: :author \"xhcoding\""
     "\n#+HUGO_TAGS: "
     "\n#+HUGO_CATEGORIES: "
     "\n#+HUGO_DRAFT: false"
     "\n\n")))


;;;###autoload
(defun +my-blog-kill-new-img-link(prefix imagename)
  (kill-new (format "[[file:%s%s]] " prefix imagename imagename)))

;;;###autoload
(defun +my-blog/capture-screenshot(basename)
  (interactive "sScreenshot name: ")
  (if (string-equal basename "")
      (setq basename
            (file-name-base buffer-file-name)))
  (setq filename (concat basename (format-time-string "_%Y%H%M%S")))
  (sleep-for 3)
  (call-process-shell-command
   (concat
    "deepin-screenshot -s " (concat (expand-file-name +my-blog-img-dir) filename)))
  (+my-blog-kill-new-img-link
   +my-blog-img-dir (concat filename ".png")))

;;;###autoload
(defun +my-blog/org-save-and-export ()
  (interactive)
  (org-octopress-setup-publish-project)
  (org-publish-project "octopress" t))
