# Generate machine-specific i3 config files.
all: config.taurus
all: config.wetterhorn
all: config
all: exit

config.%: config.d/*
	@echo Generating $*
	@cat $$(ls config.d/* | grep -E "\.($*|common)$$" | sort -d) > $@

config: config.$(shell hostname)
	ln -sf $< $@

exit: exit.$(shell hostname)
	ln -sf $< $@
