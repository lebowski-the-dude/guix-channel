(define-module (dude pkgs c)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system trivial))

(define-public my-daemon
  (let ((revision "0")
        (commit "c384694061c29c51c6f3a09709d706b00a137351"))
    (package
      (name "my-daemon")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri
          (git-reference
           (url "https://github.com/lebowski-the-dude/guix-channel.git")
           (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1fc5qk3xnbiywp2j3kpb2zp3rrndvj1mrdiij4nkidyym9l2i53y"))))
      (build-system trivial-build-system)
      (arguments
       `(#:modules ((guix build utils))
         #:builder (begin
                     (use-modules (guix build utils)
                                  (srfi srfi-26))
                     (let* ((source (assoc-ref %build-inputs "source"))
                            (output (assoc-ref %outputs "out")))
                       (invoke "pwd")
                       (invoke "ls -al")
                       ))))
      (home-page "")
      (synopsis "")
      (description "")
      (license license:gpl3+))))
