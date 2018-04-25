.PHONY: clean install

default: mkinitramfs

mkinitramfs: /usr/sbin/mkinitramfs mkinitramfs.patch
	cp --no-preserve=mode $< $@
	patch -p1 < $(filter %.patch,$^)

install: mkinitramfs hooks-localcrypt scripts-localcrypt
	install -m 755 mkinitramfs /usr/sbin/mkinitramfs
	chattr +i /usr/sbin/mkinitramfs
	install -m 755 hooks-localcrypt /etc/initramfs-tools/hooks/localcrypt
	install -m 755 scripts-localcrypt /etc/initramfs-tools/scripts/local-top/localcrypt
	install -m 644 kexecd-localcrypt /etc/default/kexec.d/zz-localcrypt
	update-initramfs -k all -c

clean:
	rm -f mkinitramfs
