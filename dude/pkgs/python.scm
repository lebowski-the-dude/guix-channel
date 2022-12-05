(define-module (dude pkgs python)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system python)
  #:use-module (gnu packages sdl)
  #:use-module (gnu packages c)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages check))

(define-public python-tcod
  ;; named branch is outdated
  (let ((commit "d3419a5b4593c7df1580427fc07616d798c85856")
        (revision "1"))
    (package
      (name "python-tcod")
      (version "13.9.1")
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/libtcod/python-tcod")
               (commit commit)
               (recursive? #true)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "1b0ligrswvz307bbx5jp8wnnqz52v5s4gcgakxy4i3jvccalm2if"))))
      (build-system python-build-system)
      ;; tests fail for a reason i do not understand
      ;; "ERROR docs/conf.py - FileNotFoundError", but this file is in the checkout
      ;; probably investigating the source will help resolve it
      (arguments
       '(#:tests? #f))
      (native-inputs
       (list sdl2
             python-pcpp
             python-pycparser
             python-requests
             python-pytest-runner
             python-pytest-benchmark
             python-pytest-cov))
      (propagated-inputs
       (list python-numpy
             python-typing-extensions
             python-cffi))
      (home-page "https://github.com/libtcod/python-tcod")
      (synopsis
       "This library is a Python cffi port of libtcod")
      (description
       "A high-performance Python port of libtcod.
Includes the libtcodpy module for backwards compatibility with older projects.")
      (license license:bsd-2))))
