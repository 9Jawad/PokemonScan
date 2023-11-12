CC=gcc
FLAGS=-std=gnu11 -Wall -Wextra -O2 -Wpedantic
OBJS=

all: img-search

img-search: img-search.c $(OBJS)
	$(CC) $(FLAGS) img-search.c -o img-search $(OBJS)

%.o: %.c %.h
	$(CC) $(FLAGS) $(DBG_OPT) -c $< -o $@