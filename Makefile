CC=cc
FLAGS=-Wall -Wextra -Werror -g
DEPS=srcs/main.o $(patsubst %.c, %.o, $(wildcard lib/*.c))

raycaster: $(DEPS)
	$(CC) $^ -o $@ -lm

%.o: %.c includes/*.h
	$(CC) $(FLAGS) -c $< -o $@ -I includes

fclean:
	find . -name "*.o" -delete
	rm raycaster

