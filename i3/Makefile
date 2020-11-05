# Generate machine-specific i3 config files.
all: config.taurus
all: config.wetterhorn

config.%: config.d/*
	@echo Generating $*
	@cat $$(ls config.d/* | grep -E "\.($*|common)$$" | sort -d) > $@
