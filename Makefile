AS=nasm
ASFLAGS=-f elf64
AR=ar
RM=rm -f
NAME=           libasm.a

SRC=           ft_read.s \
				ft_strcmp.s \
				ft_strcpy.s \
				ft_strlen.s \
				ft_write.s \
				ft_strdup.s
			
# Liste des fichiers objets (transformation de .s en .o)
OBJ=$(SRC:.s=.o)

# Règle par défaut (compilation de la bibliothèque)
.PHONY: all
all: $(NAME)

# Création de la bibliothèque statique à partir des objets
$(NAME): $(OBJ)
	$(AR) rcs $@ $^

# Compilation des fichiers .s en fichiers .o
%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

# Nettoyage des fichiers objets générés
.PHONY: clean
clean:
	$(RM) $(OBJ)

# Nettoyage complet : suppression des fichiers objets et de la bibliothèque
.PHONY: fclean
fclean: clean
	$(RM) $(NAME)

# Recompilation complète : suppression des fichiers générés et recompilation
.PHONY: re
re: fclean all