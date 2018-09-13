;;; config/private/+ui.el -*- lexical-binding: t; -*-

;; theme
;; cycle by +my/toggle-cycle-theme, binding SPC t t
(defvar +my-themes '(doom-one doom-one-light doom-dracula))


;; disable line-number
(setq display-line-numbers-type nil)

;; font
(defun +my|init-font(frame)
  (with-selected-frame frame
    (if (display-graphic-p)
        (+my/better-font))))

(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions #'+my|init-font)
  (+my/better-font))

