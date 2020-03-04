;;; input/chinese/config.el -*- lexical-binding: t; -*-

(use-package! pyim
  :defer 1
  :config
  (setq pyim-dcache-directory (concat doom-cache-dir "pyim/")
        pyim-page-tooltip t
        default-input-method "pyim")
  (when (featurep! +rime)
    (setq pyim-default-scheme 'rime)))


(use-package! liberime-config
  :when (featurep! +rime)
  :load-path (lambda()(expand-file-name "liberime" +my-ext-dir))
  :defer 1
  :config
  (setq liberime-user-data-dir (expand-file-name "pyim/rime" doom-etc-dir))
  (liberime-load)
  )


(use-package! pangu-spacing
  :hook (text-mode . pangu-spacing-mode)
  :config
  ;; Always insert `real' space in org-mode.
  (setq-hook! 'org-mode-hook pangu-spacing-real-insert-separtor t))


(use-package! fcitx
  :after evil
  :config
  (when (executable-find "fcitx-remote")
    (fcitx-evil-turn-on)))


(use-package! ace-pinyin
  :after avy
  :init (setq ace-pinyin-use-avy t)
  :config (ace-pinyin-global-mode t))


;;
;;; Hacks

(defun +chinese*org-html-paragraph (paragraph contents info)
  "Join consecutive Chinese lines into a single long line without unwanted space
when exporting org-mode to html."
  (let* ((fix-regexp "[[:multibyte:]]")
         (origin-contents contents)
         (fixed-contents
          (replace-regexp-in-string
           (concat "\\(" fix-regexp "\\) *\n *\\(" fix-regexp "\\)")
           "\\1\\2"
           origin-contents)))
    (list paragraph fixed-contents info)))
;; (advice-add #'org-html-paragraph :filter-args #'+chinese*org-html-paragraph)
