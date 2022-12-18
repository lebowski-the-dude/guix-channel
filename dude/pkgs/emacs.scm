(define-module (dude pkgs emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages emacs-xyz))

(define-public emacs-stuff
  (let ((revision "2")
        (commit "9f0acca7414548c2398d11e61c9f1ecbeed5dfe4"))
    (package
      (name "emacs-stuff")
      (version (git-version "0.1" revision commit))
      (source
       (origin
	 (method git-fetch)
	 (uri (git-reference
	       (url "https://github.com/lebowski-the-dude/stuff.git")
	       (commit commit)))
	 (file-name (git-file-name name version))
	 (sha256
	  (base32 "06cms02hm2k59z9kigl51a6n1aljdzr9nsishfavq6yc6f0y3fls"))))
      (build-system emacs-build-system)
      (propagated-inputs
       (list emacs-async))
      (arguments
       `(#:include '("\\.el$")))
      (home-page "https://github.com/KefirTheAutomator/stuff")
      (synopsis "my emacs package")
      (description "my emacs package")
      (license license:gpl3+))))
