;;; private/my-blog/config.el -*- lexical-binding: t; -*-

(defvar +my-blog-root-dir
  "~/Blog/"
  "Blog root directory.")

(defvar +my-blog-img-dir
  (expand-file-name "images/" +my-blog-root-dir)
  "Blog's image directory.")

(defvar +my-blog-image-url
  "http://source.xhcoding.cn/images/")


(use-package! ox-hugo)

(use-package! easy-hugo
  :config
  (setq easy-hugo-basedir (expand-file-name +my-blog-root-dir)
        easy-hugo-postdir "blog"
        easy-hugo-org-header t)
  (evil-set-initial-state 'easy-hugo-mode 'emacs)
  (advice-add #'easy-hugo--org-headers :override #'+my-blog*easy-hugo--org-headers))
