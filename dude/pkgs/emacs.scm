(define-module (dude pkgs emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (dude pkgs bash))

(define-public emacs-stuff
  (let ((revision "5")
        (commit "9b1eed2ac2b5c2f645877d7e1ec5dae0c8b7ecf2"))
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
       (list emacs-async
             monitor-checker))
      (arguments
       `(#:include '("\\.el$")))
      (home-page "https://github.com/KefirTheAutomator/stuff")
      (synopsis "my emacs package")
      (description "my emacs package")
      (license license:gpl3+))))
