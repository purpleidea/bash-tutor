# makefile for bash-tutor.sh Interactive live bash tutorial script with style.
# Copyright (C) 2010  James Shubin
# Written by James Shubin <purpleidea@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# name of this project
NAME := $(shell basename `pwd`)

# version of the program
VERSION := $(shell cat VERSION)

# where am i ?
PWD := $(shell pwd)

# where does www source get pushed to and metadata file path
WWW = $(PWD)/../www/code/$(NAME)/
METADATA = $(WWW)/$(NAME)

PREFIX = /usr/


install:
	# script
	sudo cp $(NAME).sh $(PREFIX)bin/$(NAME)
	sudo chmod ugo+x $(PREFIX)bin/$(NAME)
	# docs
	if [ -d $(PREFIX)share/doc/$(NAME)/ ]; then
		sudo mkdir -p $(PREFIX)share/doc/$(NAME)/
		sudo cp -r examples/ $(PREFIX)share/doc/$(NAME)/
	fi


uninstall:
	# remove script
	if [ -e $(PREFIX)bin/$(NAME) ]; then
		sudo rm $(PREFIX)bin/$(NAME)
	fi
	# remove docs
	if [ -d $(PREFIX)share/doc/$(NAME)/ ]; then
		sudo rm -r $(PREFIX)share/doc/$(NAME)/
	fi


purge: uninstall


source:
	# split this up into multiple lines for readability
	cd ..; \
	tar	--exclude=old \
		--exclude=play \
		--exclude=.swp \
		--exclude=.git \
		--exclude=.gitignore \
		--exclude=dist \
		--bzip2 \
		-cf $(NAME).tar.bz2 $(NAME)/

	if [ -e ./dist/$(NAME)-$(VERSION).tar.bz2 ]; then \
		echo version $(VERSION) already exists; \
		rm ../$(NAME).tar.bz2; \
	else \
		mv ../$(NAME).tar.bz2 ./dist/$(NAME)-$(VERSION).tar.bz2 && \
		echo 'source tarball created successfully in dist/'; \
	fi


www: force
	rsync -av dist/ $(WWW)
	# empty the file
	echo -n '' > $(METADATA)
	cd $(WWW); \
	for i in `ls *.bz2`; do \
		echo $(NAME) $(VERSION) $$i >> $(METADATA); \
	done


# depend on this fake target to cause a target to always run
force: ;

