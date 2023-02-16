(define-module (dude pkgs c)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages base))

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
      (build-system trivial-build-system)
      (arguments
       `(#:modules ((guix build utils))
         #:builder (begin
                     (use-modules (guix build utils)
                                  (srfi srfi-26))
                     (let* ((source (assoc-ref %build-inputs "source"))
                            (output (assoc-ref %outputs "out"))
                            (coreutils (assoc-ref %build-inputs "coreutils")))
                       (invoke (string-append coreutils "/sbin/pwd"))
                       ;; (invoke "ls -al")
                       ))))
      (native-inputs
       (list coreutils))
      (home-page "")
      (synopsis "")
      (description "")
      (license license:gpl3+))))

