# Makefile for the $! webapp
# Copyright 2015 Christopher Williams

$(shell mkdir -p perl)

SRC_FILES=errnogen errno.html errno.pl.template
IMAGES=$(wildcard images/*)
API_PATH:=/api
APP:=perl/errno
ZIP:=errno.zip


$(APP) : $(SRC_FILES)
	./errnogen --path $(API_PATH) >$(APP) && chmod a+x $(APP)

$(ZIP) : $(APP) $(IMAGES)
	@zip $(ZIP) $^

all : $(ZIP)

clean:
	@rm -f $(APP) $(ZIP)

