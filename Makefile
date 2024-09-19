
name="sonoff"
CHROOT=/etc/${name}



build: 
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 && go build -o dist/${name} -tags=release -ldflags "-s -w"
	cp light.ico dist/light.ico

clean-build: 
	@rm --force --recursive dist/

install-folder:

	sudo mkdir ${CHROOT}
	
	sudo cp light.ico ${CHROOT}/light.ico  
	sudo cp sonoff.service /etc/systemd/user/${name}.service
	sudo cp sonoff.sh   ${CHROOT}/sonoff.sh
	sudo cp config.toml   ${CHROOT}/config.toml
	sudo cp dist/${name} /usr/local/bin/${name}

	sudo chmod 777  /usr/local/bin/${name}
	sudo chmod 777 ${CHROOT}/sonoff.sh
	systemctl --user daemon-reload
	systemctl --user enable ${name}.service
	systemctl --user start ${name}.service

install : build install-folder  clean-build
	@echo "\033[0;32m Install done \033[0m"

uninstall:
	systemctl --user stop ${name}.service
	systemctl --user disable ${name}.service
	systemctl --user daemon-reload
	sudo rm --force /usr/local/bin/${name}
	sudo rm --force ${CHROOT}/sonoff.sh
	sudo rm --force ${CHROOT}/config.toml
	sudo rm --force ${CHROOT}/light.ico
	sudo rm --force /etc/systemd/user/${name}.service
	sudo rm --force --recursive ${CHROOT}
	systemctl --user daemon-reload