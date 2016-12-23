;;; persp-fr.el --- In persp-mode, show perspective list in the GUI window title

;; Copyright (C) 2016 Francesc Rocher

;; Author: Francesc Rocher <francesc.rocher@gmail.com>
;; URL: http://github.com/rocher/persp-fr
;; Version: 0.0.1
;; Package-Requires: ((emacs "25.0") (persp-mode "2.9.1"))
;; Keywords: perspectives, workspace, windows, convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This code is an extension of the `persp-mode' mode that uses your GUI window
;; title (aka Emacs frame name) to show the list of current perspectives and
;; indicates the current one.

;; Installation:

;; From the MELPA: M-x package-install RET `persp-fr' RET.

;; From a file: M-x `package-install-file' RET 'path to this file' RET Or put
;; this file into your load-path.

;; Usage:

;; The same as `persp-mode':

;;    (require 'persp-fr)    ;; was (require 'persp-mode)
;;    (persp-fr-start)

;; Customization:

;; The customization group lets you tweak few parameters: M-x `customize-group'
;; RET 'persp-fr' RET.

;; Useful keys to change to next/previous perspective, as in most user
;; interfaces using tabs:

;;     (global-set-key [(control prior)] 'persp-prev)
;;     (global-set-key [(control next)] 'persp-next)


;; Tested only under Linux / Gnome. Feedback welcome!

;;; Code:

(require 'persp-mode)

(defgroup persp-fr nil
  "Customization of the `persp-fr' mode."
  :tag "persp-fr"
  :group 'environment)

(defcustom persp-fr-title-max-length nil
  "Limit the length of the title shown in the window title."
  :tag "Max length of frame titles."
  :type '(choice
          (const :tag "unlimited" nil)
          (integer :tag "limited" :value 64
                   :validate
                   (lambda(widget)
                     (when (or (null (integerp (widget-value widget)))
                               (< (widget-value widget)  1))
                       (widget-put
                        widget :error
                        (format-message
                         "Invalid value, must be an integer greater than 0"))
                       widget))))
  :set (lambda (symbol value)
         (custom-set-default symbol value)
         (when (fboundp 'persp-fr-update)
           (persp-fr-update nil)))
  :group 'persp-fr)

(defcustom persp-fr-title-prefix nil
  "Prefix to be used in the window title."
  :tag "Window title prefix"
  :type '(choice
          (const :tag "default frame name" nil)
          (string :tag "literal text"))
  :set (lambda (symbol value)
         (custom-set-default symbol value)
         (when (fboundp 'persp-fr-update)
           (persp-fr-update nil)))
  :group 'persp-fr)

(defvar persp-fr-default-frame-name (frame-parameter nil 'name))

(defun persp-fr-update (&optional hook &rest rest)
  "Keep a list of perspective names in the frame title."
  (let ((current (get-current-persp)))
    (unless (and (eq hook 'persp-before-kill-functions)
                 (eq (car rest) current))
      (setq current (safe-persp-name current))
      (let ((persp-list (persp-names-current-frame-fast-ordered))
            title)
        (when (eq hook 'persp-before-kill-functions)
          (setq persp-list
                (delete (safe-persp-name (car rest))
                        persp-list)))
        (setq title
              (concat (or persp-fr-title-prefix
                          persp-fr-default-frame-name
                          current)
                      "   - "
                      (mapconcat
                       #'(lambda (persp)
                           (if (string= current persp)
                               (concat "[ " (upcase persp) " ]")
                             persp))
                       persp-list
                       " - ")
                      " -"))
        (if (and persp-fr-title-max-length
                 (> (length title) persp-fr-title-max-length))
            (setq title (concat (substring title 0 persp-fr-title-max-length) " ..")))
        (set-frame-name title)))))

;;;###autoload
(defun persp-fr-start ()
  "Starts `persp-fr' mode.
This is exactly the same as `persp-mode', but perspective names
are shown in the frame title."
  (interactive)
  (macrolet ((add-persp-hooks
              (&rest hooks)
              (let (code)
                (dolist (hook hooks)
                  (push
                   `(add-hook
                     ',hook
                     #'(lambda (&rest rest)
                         (apply #'persp-fr-update ',hook rest)))
                   code))
                `(progn ,@code))))
    (add-persp-hooks persp-before-kill-functions persp-activated-functions
                     persp-created-functions persp-renamed-functions
                     focus-in-hook))
  (persp-fr-update))

(provide 'persp-fr)
;;; persp-fr.el ends here
