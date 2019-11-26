;;; config/private/+ui.el -*- lexical-binding: t; -*-

;; theme
;; cycle by +my/toggle-cycle-theme, binding SPC t t
(defvar +my-themes '(doom-one doom-one-light doom-dracula))
(setq doom-theme 'doom-one-light)

;; disable line-number
(setq display-line-numbers-type nil)



;; font
;;

(let ((family )
      (size 14)
      (big-size 17))
  (cond ((member "等距更纱黑体 SC" (font-family-list))
         (setq family "等距更纱黑体 SC"))
        ((member "Sarasa Term SC" (font-family-list))
         (setq family "Sarasa Term SC" )))
  (cond ((= 1920 (x-display-pixel-width))
         (setq size 14)
         (setq big-size 17))
        ((= 3840 (x-display-pixel-width))
         (setq size 30)
         (setq big-size 35)))
  (setq doom-font (font-spec :family family :size size))
  (setq doom-big-font (font-spec :family family :size big-size))
  )


;;
;;
;; (defun +my|init-font(frame)
;;   (with-selected-frame frame
;;     (if (display-graphic-p)
;;         (+my/better-font))))

;; (if (and (fboundp 'daemonp) (daemonp))
;;     (add-hook 'after-make-frame-functions #'+my|init-font)
;;   (+my/better-font))
