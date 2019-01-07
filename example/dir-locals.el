;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((go-mode
  ((eval . (progn
             (setq process-environment (copy-sequence process-environment))
             (setenv "GOPATH" "/d/sunday/workspace/bysvn/moviestar/develop/code/Server"))))
  (go-backend . go-mode))
 )
