(setq-default mode-line-format
	      '("%e"
		mz-modeline/major-mode
		))

(defun mz-modeline/major-mode-name ()
  (symbol-name major-mode))

(defvar-local mz-modeline/major-mode
  '(:eval
    (propertize (mz-modeline/major-mode-name) 'face 'bold)))

(put 'mz-modeline/major-mode 'risky-local-variable t)

(provide 'modeline)
