;;; config/private/+ui.el -*- lexical-binding: t; -*-

;; theme
;; cycle by +my/toggle-cycle-theme, binding SPC t t
(defvar +my-themes '(doom-one doom-one-light doom-dracula))
(setq doom-theme 'doom-one-light)

;; disable line-number
(setq display-line-numbers-type nil)



;; font

(if IS-WINDOWS
    (setq doom-font "-outline-等距更纱黑体 SC-normal-normal-normal-mono-30-*-*-*-c-*-iso8859-1")
  (setq doom-font "-outline-Sarasa Term SC-normal-normal-normal-mono-30-*-*-*-c-*-iso8859-1"))




;;
;;
;; (defun +my|init-font(frame)
;;   (with-selected-frame frame
;;     (if (display-graphic-p)
;;         (+my/better-font))))

;; (if (and (fboundp 'daemonp) (daemonp))
;;     (add-hook 'after-make-frame-functions #'+my|init-font)
;;   (+my/better-font))
