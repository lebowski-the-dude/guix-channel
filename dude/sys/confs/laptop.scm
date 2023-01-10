(use-modules (gnu) (gnu system nss)
	     (nongnu packages linux)
             (nongnu system linux-initrd)
             (dude srvcs workstation))

(operating-system
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
 (host-name "grimoire")
 (timezone "Europe/Moscow")
 (locale "en_US.utf8")

 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
              (targets '("/boot/efi"))))

 (file-systems (append
                (list (file-system
                       (device (file-system-label "my-root"))
                       (mount-point "/")
                       (type "ext4"))
                      (file-system
                       (device (uuid "E26A-6302" 'fat))
                       (mount-point "/boot/efi")
                       (type "vfat")))
                %base-file-systems))

 (users (cons (user-account
               (name "user")
               (comment "-_-")
               (group "users")
               (supplementary-groups '("wheel" "netdev"
                                       "audio" "video")))
              %base-user-accounts))

 (packages (append
	    %dude-workstation-packages
	    (map (compose list specification->package+output)
		 '("emacs-stuff"))))

 (services %dude-workstation-services)

 (name-service-switch %mdns-host-lookup-nss))
