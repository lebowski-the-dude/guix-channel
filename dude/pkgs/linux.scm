(define-module (dude pkgs linux)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix git-download)
  #:use-module (gnu packages linux))

(define* (corrupt-linux-git kernel-package version hash url #:key (name "dude-linux-git"))
  (package
    (inherit kernel-package)
    (name name)
    (version version)
    (source (origin
              (method git-fetch)
	      (uri (git-reference
	            (url url)
	            (commit version)))
	      (file-name (git-file-name name version))
	      (sha256
	       (base32 hash))))
    (home-page "https://www.kernel.org/")
    (synopsis "Linux kernel with nonfree binary blobs included")
    (description
     "The unmodified Linux kernel, including nonfree blobs, for running Guix
System on hardware which requires nonfree software to function.")))

(define-public dude-linux-git
  (corrupt-linux-git linux-libre-6.0 "v6.1-rc1"
                     "0agzh4c7ldg9jqinm9zngzbj8rp24l4bk7slmb7xg1d87m01k8dz"
                     "https://github.com/torvalds/linux"))
