(define-module (dude pkgs c)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages base)
  #:use-module (gnu packages commencement))

(define-public my-daemon
  (let ((revision "0")
        (commit "974510c9418e9b7fc09850cbf5afb777f47c22d9"))
    (package
      (name "my-daemon")
      (version (git-version "0.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri
          (git-reference
           (url "https://github.com/lebowski-the-dude/test-daemon")
           (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0kx4zfdz98pn3s2lkpc3gxi8im7h5kzf8zx5ln2pdb14awrab6gd"))))
      (build-system gnu-build-system)
      (arguments
       `(#:tests? #f
         #:phases
         (modify-phases %standard-phases
           (delete 'configure))))
      (home-page "")
      (synopsis "")
      (description "")
      (license license:gpl3+))))

