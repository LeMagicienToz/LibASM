#include <stdio.h>  // for printf
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>

extern long ft_strlen(const char *str);
extern char *ft_strcpy(char *dest, const char *src);
extern int ft_strcmp(const char *dest, const char *src);
extern ssize_t ft_write(int fd, const void *buf, size_t count);
extern ssize_t ft_read(int fd, const void *buf, size_t count);
extern char *ft_strdup(const char *s);

void test_strdup() {
    printf("\n========== TEST ft_strdup ==========\n");
    char *test_cases[] = {
        "Hello, World!",
        "",
        "abcdefghijklmnopqrstuvwxyz",
        "Test avec caractères spéciaux !@#$%^&*()_+-=[]{}|;:'\",.<>/?`~"
    };

    for (int i = 0; i < 4; i++) {
        char *dup1 = strdup(test_cases[i]);
        printf("strdup:    \"%s\"\n", dup1);
        free(dup1);

        char *dup2 = ft_strdup(test_cases[i]);
        printf("ft_strdup: \"%s\"\n", dup2);
        free(dup2);
    }
}


int main() {
    char *test_str = "damnwodjawd";
    char *empty_str = "";
    char buffer[256];  // Buffer pour stocker les données lues

    //STRLEN
    printf("/////////// STRLEN ///////////////\n");
    long length = ft_strlen(test_str);
    long true_length = strlen(test_str);
    int e_length = ft_strlen(empty_str);
    int e_true_length= strlen(empty_str);
    printf("|REAL| Longueur de \"%s\" = %ld\n", test_str, true_length);
    printf("|TEST| Longueur de \"%s\" = %ld\n", test_str, length);
    printf("|REAL| Longueur de \"%s\" = %d\n", empty_str, e_true_length);
    printf("|TEST| Longueur de \"%s\" = %d\n", empty_str, e_length);
    printf("\n\n");

    //STRCPY
    printf("/////////// STRCPY ///////////////\n");
    char copied_str[100];
    char true_copied_str[100];
    strcpy(true_copied_str, test_str);
    ft_strcpy(copied_str, test_str);
    printf("|REAL| Copied string : \"%s\"\n", true_copied_str);
    printf("|TEST| Copied string: \"%s\"\n", copied_str);
    printf("\n\n");

    //strcmp

    printf("/////////// STRCMP ///////////////\n");
    const char *good_one = "damnwodjawd";
    const char *bad_one = "damnwodjabc";

    printf("|REAL| GOOD strcmp = %d \n", strcmp(test_str, good_one));
    printf("|REAL| BAD strcmp = %d \n", strcmp(test_str, bad_one));
    printf("|TEST| GOOD strcmp = %d \n", ft_strcmp(test_str, good_one));
    printf("|TEST| BAD strcmp = %d \n", ft_strcmp(test_str, bad_one));
    printf("\n\n");

    //write
    printf("/////////// WRITE ///////////////\n");
    write(1, "|REAL|\n", 7);
    ft_write(1, "|TEST|\n", 7);
    write(1, "|REAL|aa\naaa", 9);
    ft_write(1, "|TEST|aa\naaa", 9);
    printf("ERROR CASE |REAL| ret value = %ld" ,write(-5, "|REAL|\n", 7));
    printf(" errno = %d" ,errno);
    printf(" error message = %s\n" ,strerror(errno));
    errno = 0;
    printf("ERROR CASE |TEST| ret value = %ld" ,ft_write(-5, "|TEST|\n", 7));
    printf(" errno = %d" ,errno);
    printf(" error message = %s\n" ,strerror(errno));
    errno = 0;
    printf("\n\n");

    
    //read
    printf("/////////// READ (ft_read) ///////////////\n");
        int fd = open("test.txt", O_RDONLY);
        ssize_t read_ret = read(fd, buffer, sizeof(buffer) - 1);
        ssize_t read_ret_test = ft_read(fd, buffer, sizeof(buffer) - 1);
        if (read_ret == -1) {
            // Si read échoue, afficher l'erreur
            printf("|REAL| READ failed. errno = %d, error message = %s\n", errno, strerror(errno));
        } else {
            buffer[read_ret] = '\0';  // Ajouter le caractère de fin de chaîne
            printf("|REAL| READ success: %s\n", buffer);
        }
        // Test de `ft_read` avec l'entrée standard (fd = 0)
        if (read_ret_test == -1) {
            // Si ft_read échoue, afficher l'erreur
            printf("|TEST| READ failed. errno = %d, error message = %s\n", errno, strerror(errno));
        } else {
            buffer[read_ret] = '\0';  // Ajouter le caractère de fin de chaîne
            printf("|TEST| READ success: %s\n", buffer);
        }
        close(fd);
        int fd_two = open("tesst.txt", O_RDONLY);
        read_ret = read(fd, buffer, sizeof(buffer) - 1);
        read_ret_test = ft_read(fd, buffer, sizeof(buffer) - 1);
        if (read_ret == -1) {
            // Si read échoue, afficher l'erreur
            printf("|REAL| READ failed. errno = %d, error message = %s\n", errno, strerror(errno));
        } else {
            buffer[read_ret] = '\0';  // Ajouter le caractère de fin de chaîne
            printf("|REAL| READ success: %s\n", buffer);
        }
        // Test de `ft_read` avec l'entrée standard (fd = 0)
        if (read_ret_test == -1) {
            // Si ft_read échoue, afficher l'erreur
            printf("|TEST| READ failed. errno = %d, error message = %s\n", errno, strerror(errno));
        } else {
            buffer[read_ret] = '\0';  // Ajouter le caractère de fin de chaîne
            printf("|TEST| READ success: %s\n", buffer);
        }
        close(fd_two);
        printf("\n\n");
        
        //strdup
        printf("/////////// STRDUP ///////////////\n");
       test_strdup();
}
