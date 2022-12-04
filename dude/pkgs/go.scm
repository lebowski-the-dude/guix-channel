(define-module (dude pkgs go)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system go)
  #:use-module (gnu packages golang))

(define-public go-github-com-lebowski-the-dude-daemon
  (let ((commit "a65f202dea87d17d423ca6d632333c2926c4053b")
	(revision "0"))
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
         (modules '((guix build utils)))
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
