(define-module (dude srvcs custom)
  #:use-module (gnu services)
  #:use-module (gnu services shepherd)
  #:use-module (gnu services configuration)
  #:use-module (gnu system shadow)
  #:use-module (gnu packages admin)
  #:use-module (guix gexp)
  #:use-module (dude pkgs go)
  #:use-module (dude pkgs python)
  #:export (my-daemon-service-type)
  #:export (my-new-daemon-service-type))

(define (my-daemon-shepherd-service _)
  (let ((pid-file "/var/run/my-daemon.pid")
        (log-file "/var/log/my-daemon.log"))
    (list (shepherd-service
           (documentation "my dummy daemon")
           (provision '(my-daemon))
           (requirement '(networking))
           (start #~(make-forkexec-constructor
                     (list (string-append #$go-github-com-lebowski-the-dude-daemon "/bin/daemon")
                           "-pidFile" #$pid-file
                           "-logFile" #$log-file)
                     #:pid-file #$pid-file
                     #:log-file #$log-file))
           (stop #~(make-kill-destructor))))))

(define my-daemon-service-type
  (service-type (name 'my-daemon)
                (extensions
                 (list (service-extension shepherd-root-service-type
                                          my-daemon-shepherd-service)))
                (default-value #f)
                (description "test service")))

(define (my-new-daemon-shepherd-service _)
  (let ((pid-file "/var/run/my-daemon.pid"))
    (list (shepherd-service
           (documentation "my dummy daemon")
           (provision '(my-new-daemon))
           (requirement '(networking))
           (start #~(make-forkexec-constructor
                     (list (string-append #$python-my-daemon "/bin/my-daemon")
                           "-pidFile" #$pid-file)
                     #:pid-file #$pid-file))
           (stop #~(make-kill-destructor))))))

(define my-new-daemon-service-type
  (service-type (name 'my-daemon)
                (extensions
                 (list (service-extension shepherd-root-service-type
                                          my-new-daemon-shepherd-service)))
                (default-value #f)
                (description "test service")))
