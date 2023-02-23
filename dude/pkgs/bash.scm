(define-module (dude pkgs bash)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages base)
  #:use-module (gnu packages gawk)
  #:use-module (guix git-download)
  #:use-module (guix build-system trivial))

(define-public monitor-checker
  (let ((revision "0")
        (commit "c7b480206e7e30648fd56f0571c8e66335391be7"))
    (package
      (name "monitor-checker")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
	 (method git-fetch)
	 (uri (git-reference
	       (url "https://github.com/lebowski-the-dude/utils")
	       (commit commit)))
	 (file-name (git-file-name name version))
	 (sha256
	  (base32 "1mayy270dkqsimmm7b5p85jbj9p53xyr42g19iz7ilym3gyigfqn"))))
      (build-system trivial-build-system)
      (propagated-inputs
       (list xrandr
             gawk
             grep))
      (arguments
       `(#:builder
         (begin
           (use-modules (guix build utils))
           ;; copy source
           (copy-file (string-append (assoc-ref %build-inputs "source")
                                     "/MonitorChecker.sh")
                      ".")
           ;; install phase
           (install-file "MonitorChecker.sh" (string-append %output "/bin")))))
      (home-page "https://github.com/lebowski-the-dude/utils")
      (synopsis "")
      (description "")
      (license license:gpl3+))))
