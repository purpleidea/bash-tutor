

install:
	sudo cp bash-tutor.sh /usr/bin/bash-tutor
	sudo chmod ugo+x /usr/bin/bash-tutor

uninstall:
	sudo rm /usr/bin/bash-tutor

purge: uninstall


