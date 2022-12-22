(define-module (dude srvcs base)
  #:use-module ((dude sys vars) #:prefix dude-vars:)
  #:use-module (gnu system)
  #:use-module (gnu packages)
  #:use-module (gnu services base)
  #:use-module (gnu services)
  #:use-module (gnu services admin)
  #:use-module (gnu services shepherd)
  #:use-module (gnu services sysctl)
  #:use-module (gnu services guix)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages base)
  #:use-module (guix gexp)
  #:export (%dude-base-packages
            %dude-base-services))

(define %dude-base-packages
  (append
   %base-packages
   (map (compose list specification->package+output)
        '("git" "git:send-email" "xrandr" "openssh"
          "emacs" "emacs-exwm" "emacs-async" "nss-certs"))))

(define %dude-base-services
  (list (service login-service-type)

        (service virtual-terminal-service-type)
        (service console-font-service-type
                 (map (lambda (tty)
                        (cons tty %default-console-font))
                      '("tty1" "tty2" "tty3" "tty4" "tty5" "tty6")))

        (syslog-service)
        (service agetty-service-type (agetty-configuration
                                      (extra-options '("-L")) ; no carrier detect
                                      (term "vt100")
                                      (tty #f) ; automatic
                                      (shepherd-requirement '(syslogd))))

        (service mingetty-service-type (mingetty-configuration
                                        (tty "tty1")))
        (service mingetty-service-type (mingetty-configuration
                                        (tty "tty2")))
        (service mingetty-service-type (mingetty-configuration
                                        (tty "tty3")))
        (service mingetty-service-type (mingetty-configuration
                                        (tty "tty4")))
        (service mingetty-service-type (mingetty-configuration
                                        (tty "tty5")))
        (service mingetty-service-type (mingetty-configuration
                                        (tty "tty6")))

        (service static-networking-service-type
                 (list %loopback-static-networking))
        (service urandom-seed-service-type)
        (service guix-service-type
		 (guix-configuration
		  (substitute-urls dude-vars:%substitutes-urls)))
        (service nscd-service-type)

        (service rottlog-service-type)

        ;; Periodically delete old build logs.
        (service log-cleanup-service-type
                 (log-cleanup-configuration
                  (directory "/var/log/guix/drvs")))

        ;; The LVM2 rules are needed as soon as LVM2 or the device-mapper is
        ;; used, so enable them by default.  The FUSE and ALSA rules are
        ;; less critical, but handy.
        (service udev-service-type
                 (udev-configuration
                  (rules (list lvm2 fuse alsa-utils crda))))

        (service sysctl-service-type)

        (service special-files-service-type
                 `(("/bin/sh" ,(file-append bash "/bin/sh"))
                   ("/usr/bin/env" ,(file-append coreutils "/bin/env"))))))
