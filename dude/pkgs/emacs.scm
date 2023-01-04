(define-module (dude pkgs emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages emacs-xyz))

(define-public emacs-stuff
  (let ((revision "3")
        (commit "7c72fbb4cf56b96b697c0fb8d1706e4ecc419cc6"))
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
	  (base32 "18x5sh568pch54ryb8q289y4hya6bd5jnwysrnss18ybfar4rgg8"))))
      (build-system emacs-build-system)
      (propagated-inputs
       (list emacs-async))
      (arguments
       `(#:include '("\\.el$")))
      (home-page "https://github.com/KefirTheAutomator/stuff")
      (synopsis "my emacs package")
      (description "my emacs package")
      (license license:gpl3+))))
