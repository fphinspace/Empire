# %W% %G% %U% - (c) Copyright 1987, 1988 Chuck Simmons

#
#    Copyright (C) 1987, 1988 Chuck Simmons
#
# See the file COPYING, distributed with empire, for restriction
# and warranty information.

# Change the line below for your system.  If you are on a Sun or Vax,
# you may want BSD.

SYS = BSD
#SYS = SYSV

# Use -g to compile the program for debugging.

DEBUG = -g -DDEBUG
#DEBUG = -O

# Use -p to profile the program.
#PROFILE = -p -DPROFILE
PROFILE =

# Define all necessary libraries.  'curses' is necessary.  'termcap'
# is needed on BSD systems.
#LIBS = -ldcurses
#LIBS = -lcurses -ltermcap
LIBS = -lncurses

# You shouldn't have to modify anything below this line.

CFLAGS = $(DEBUG) $(PROFILE) -D$(SYS)
INS   = /etc/install

FILES = \
	attack.c \
	compmove.c \
	data.c \
	display.c \
	edit.c \
	empire.c \
	game.c \
	main.c \
	map.c \
	math.c \
	object.c \
	term.c \
	usermove.c \
	util.c

HEADERS = empire.h extern.h

OFILES = \
	attack.o \
	compmove.o \
	data.o \
	display.o \
	edit.o \
	empire.o \
	game.o \
	main.o \
	map.o \
	math.o \
	object.o \
	term.o \
	usermove.o \
	util.o

all: empire

empire: $(OFILES)
	$(CC) $(PROFILE) -o empire $(OFILES) $(LIBS)

TAGS: $(HEADERS) $(FILES)
	etags $(HEADERS) $(FILES)

lint: $(FILES)
	lint -u -D$(SYS) $(FILES) -lcurses

clean:
	rm -f *.o TAGS

clobber: clean
	rm -f empire empire.tar*

install: empire
	$(INS) -o -f /usr/local/games empire

installman: empire.6
	$(INS) -f /usr/local/man/man6 empire.6

SOURCES = READ.ME empire.6 COPYING Makefile BUGS $(FILES) $(HEADERS) MANIFEST empire.lsm

empire.tar: $(SOURCES)
	tar -cvf empire.tar $(SOURCES)
empire.tar.gz: empire.tar
	gzip empire.tar

empire.shar: $(SOURCES)
	shar $(SOURCES) >empire.shar
