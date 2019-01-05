;;; config/private/+ui.el -*- lexical-binding: t; -*-

;; theme
;; cycle by +my/toggle-cycle-theme, binding SPC t t
(defvar +my-themes '(doom-one doom-one-light doom-dracula))
(if (display-graphic-p)
    (setq doom-theme 'doom-one-light)
  (setq doom-theme 'doom-one))

;; disable line-number
(setq display-line-numbers-type nil)

;; font
(setq doom-font (font-spec :family "Sarasa Term SC" :size 14))
(setq doom-font (font-spec :family "Sarasa Term SC" :size 17))

;;
;;
;; (defun +my|init-font(frame)
;;   (with-selected-frame frame
;;     (if (display-graphic-p)
;;         (+my/better-font))))

;; (if (and (fboundp 'daemonp) (daemonp))
;;     (add-hook 'after-make-frame-functions #'+my|init-font)
;;   (+my/better-font))
