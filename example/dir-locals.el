;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((go-mode
  ((eval . (progn
             (setq process-environment (copy-sequence process-environment))
             (setenv "GOPATH" "/path/of/golang/project"))))
  (go-backend . go-mode))
 )
