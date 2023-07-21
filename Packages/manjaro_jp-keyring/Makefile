V=20230719

PREFIX = /usr
TRUSTED= $(shell cat manjaro_jp-trusted | cut -d: -f1)
REVOKED= $(shell cat manjaro_jp-revoked)

update:
	gpg --recv-keys $(TRUSTED) $(REVOKED)
	gpg --export --armor $(TRUSTED) $(REVOKED) > manjaro_jp.gpg

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 manjaro_jp{.gpg,-trusted,-revoked} $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/manjaro_jp{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
