
name="sonoff"
CHROOT=/etc/${name}



build: 
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 && go build -o dist/${name} -tags=release -ldflags "-s -w"
	cp light.ico dist/light.ico

clean-build: 
	> @rm --force --recursive dist/


install: build

	mkdir ${CHROOT}
	
	cp light.ico ${CHROOT}/light.ico  
	cp sonoff.service /etc/systemd/user/${name}.service
	cp sonoff.sh   ${CHROOT}/sonoff.sh
	cp config.toml   ${CHROOT}/config.toml
	cp dist/${name} /usr/local/bin/${name}

	chmod 777  /usr/local/bin/${name}
	chmod 777 ${CHROOT}/sonoff.sh
