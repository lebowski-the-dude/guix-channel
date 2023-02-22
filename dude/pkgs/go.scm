(define-module (dude pkgs go)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages base)
  #:use-module (gnu packages gawk)
  #:use-module (guix git-download)
  #:use-module (guix build-system go)
  #:use-module (gnu packages golang))

(define-public go-github-com-lebowski-the-dude-test-daemon
  (let ((revision "1")
        (commit "524d8564b7a1bc83cb419633949ae24860acb49a"))
    (package
      (name "go-github-com-lebowski-the-dude-test-daemon")
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
          (base32 "1gxapzr66n59rdawd4wb88az84clxvg30m6jv3jjz18yq2vz53p7"))))
      (build-system go-build-system)
      (native-inputs
       (list go-github-com-sevlyar-go-daemon))
      (propagated-inputs
       (list xrandr
             gawk
             grep))
      (arguments
       `(#:import-path "github.com/lebowski-the-dude/test-daemon"
         #:phases (modify-phases %standard-phases
                    (delete 'sanity-check)
                    (add-after 'unpack 'patch
                      (lambda* (#:key inputs #:allow-other-keys)
                        (let ((xrandr (assoc-ref inputs "xrandr"))
                              (gawk (assoc-ref inputs "gawk"))
                              (grep (assoc-ref inputs "grep")))
                          (substitute* "main.go"
                            (("xrandr")
                             (string-append xrandr "/bin/xrandr"))
                            )))))))
                            ;; (("awk")
                            ;;  (string-append gawk "/bin/awk"))
                            ;; (("grep")
                            ;;  (string-append grep "/bin/grep")))))))))
      (home-page "")
      (synopsis "")
      (description "")
      (license license:gpl3+))))
