(define-module (dude pkgs go)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system go)
  #:use-module (gnu packages golang))

(define-public go-github-com-lebowski-the-dude-daemon
  (let ((revision "1")
        (commit "3e8f7c5f4fdef6f1545db8479c5a6d357555a579"))
    (package
      (name "go-github-com-lebowski-the-dude-daemon")
      (version (git-version "0.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri
          (git-reference
           (url "https://github.com/lebowski-the-dude/daemon.git")
           (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1fc5qk3xnbiywp2j3kpb2zp3rrndvj1mrdiij4nkidyym9l2i53y"))))
      (build-system go-build-system)
      (arguments
       `(#:import-path "github.com/lebowski-the-dude/daemon"))
      (native-inputs
       (list go-github-com-sevlyar-go-daemon))
      (home-page "")
      (synopsis "")
      (description "")
      (license license:gpl3+))))
