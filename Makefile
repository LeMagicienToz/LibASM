# Assembleur et options
AS=nasm
ASFLAGS=-f elf64

# Compilateur et options
CC=gcc
CFLAGS=-Wall -Wextra -Werror

# Archiveur (pour créer la bibliothèque statique)
AR=ar
ARFLAGS=rcs

# Commande de suppression
RM=rm -f

# Nom de la bibliothèque
NAME=libasm.a

# Nom de l'exécutable de test
TEST_EXEC=test_libasm

# Fichiers sources ASM
SRC=           ft_read.s \
				ft_strcmp.s \
				ft_strcpy.s \
				ft_strlen.s \
				ft_write.s \
				ft_strdup.s

# Fichier source du main de test
MAIN_SRC=main.c

# Liste des fichiers objets (transformation de .s en .o)
OBJ=$(SRC:.s=.o)

# Règle par défaut (compilation de la bibliothèque et de l'exécutable)
.PHONY: all
all: $(NAME) $(TEST_EXEC)

# Compilation des fichiers .s en fichiers .o
%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

# Création de la bibliothèque statique à partir des objets
$(NAME): $(OBJ)
	$(AR) $(ARFLAGS) $@ $^

# Compilation du programme de test avec `-l asm`
$(TEST_EXEC): $(MAIN_SRC) $(NAME)
	$(CC) $(CFLAGS) -o $(TEST_EXEC) $(MAIN_SRC) -L. -lasm

# Nettoyage des fichiers objets générés
.PHONY: clean
clean:
	$(RM) $(OBJ) $(TEST_EXEC)

# Nettoyage complet : suppression des fichiers objets et de la bibliothèque
.PHONY: fclean
fclean: clean
	$(RM) $(NAME)

# Recompilation complète : suppression des fichiers générés et recompilation
.PHONY: re
re: fclean all
