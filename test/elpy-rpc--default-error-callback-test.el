(ert-deftest elpy-rpc--default-error-callback-warning-is-no-error ()
  (elpy-testcase ()
    (mletf* ((output nil)
             (message (fmt &rest args)
                      (setq output (apply #'format fmt args))))

      (elpy-rpc--default-error-callback '((name . "e-name")
                                          (message . "e-message")))

      (should (equal output "Elpy warning: e-message")))))

(ert-deftest elpy-rpc--default-error-callback-should-include-traceback ()
  (elpy-testcase ()
    (elpy-rpc--default-error-callback '((name . "e-name")
                                        (message . "e-message")
                                        (traceback . "e-traceback")))

    (with-current-buffer "*Elpy Error*"
      (goto-char (point-min))
      (re-search-forward "backend encountered an unexpected error")
      (re-search-forward "e-traceback"))))