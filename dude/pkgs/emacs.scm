(define-module (dude pkgs emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages emacs-xyz))

(define-public emacs-stuff
  (let ((revision "4")
        (commit "2efd9c7dbd685740007fa9fda8fee09ec60550fe"))
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
	  (base32 "1mayy270dkqsimmm7b5p85jbj9p53xyr42g19iz7ilym3gyigfqn"))))
      (build-system emacs-build-system)
      (propagated-inputs
       (list emacs-async))
      (arguments
       `(#:include '("\\.el$")))
      (home-page "https://github.com/KefirTheAutomator/stuff")
      (synopsis "my emacs package")
      (description "my emacs package")
      (license license:gpl3+))))
