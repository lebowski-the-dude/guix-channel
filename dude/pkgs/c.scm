(define-module (dude pkgs c)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages base)
  #:use-module (gnu packages commencement))

(define-public my-daemon
  (let ((revision "0")
        (commit "c384694061c29c51c6f3a09709d706b00a137351"))
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
          (base32 "1slxrg3bjppv8kxngfhsxpy3sia592rfrdlhvvkxf0xycw4b3mb7"))))
      (build-system gnu-build-system)
      (arguments
       (list
        #:modules ((guix build utils))
        #:phases
        #~(modify-phases %standard-phases
            ;; No configure script and Makefile.
            (delete 'configure)
            (delete 'build)
            (add-before 'install 'compile
              (lambda _
                (invoke "ls" "-al")))
            )))
      (home-page "")
      (synopsis "")
      (description "")
      (license license:gpl3+))))

