#CXXFLAGS=-Wall -Og -g3 -std=gnu++11
CXXFLAGS=-Wall -O3 -g3 -fomit-frame-pointer -std=gnu++11
mysql_json.so: CXXFLAGS += -shared -fPIC
LDFLAGS=

DESTDIR=
libdir.x86_64 = /usr/lib64
libdir.i386   = /usr/lib
MACHINE := $(shell uname -i)
libdir = $(DESTDIR)$(libdir.$(MACHINE))

.PHONY: install clean

mysql_json.so: mysql_json.cc

install: mysql_json.so
	mkdir -p $(libdir)/mysql/plugin
	install -p $^ $(libdir)/mysql/plugin

uninstall:
	-rmdir $(libdir)/mysql/plugin $(libdir)/mysql 2> /dev/null

main_test: main_test.cc mysql_json.cc

clean:
	rm -f mysql_json.o mysql_json.so main_test

%.so: %.cc
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@
