;;; config/private/+ui.el -*- lexical-binding: t; -*-

;; theme
(defvar +my-themes '(doom-one doom-one-light doom-dracula))


;; disabled display line number
(remove-hook! (prog-mode text-mode conf-mode) #'display-line-numbers-mode)


;; font
(defun +my|init-font(frame)
  (with-selected-frame frame
    (if (display-graphic-p)
        (+my/better-font))))

(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions #'+my|init-font)
  (+my/better-font))

