.PHONY: build_watch
build_watch:
	dart run build_runner watch -d

.PHONY: deb
deb:
	flutter_distributor package --platform linux --targets deb

.PHONY: rpm
rpm:
	flutter_distributor package --platform linux --targets rpm

.PHONY: rpm
rpm:
	flutter_distributor package --platform linux --targets rpm

.PHONY: tarball
tarball:
	flutter clean
	flutter build linux
	cd build/linux/x64/release && tar -czvf mostaqem.tar.gz bundle/

