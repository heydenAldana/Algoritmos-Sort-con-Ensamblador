# arrays.asm - Contiene los arreglos de prueba para los algoritmos sort

.data
    # Arreglo 1: tamaño 10
    array10: .word 9, 2, 5, 1, 8, 3, 7, 4, 6, 0
    size10: .word 10
    
    # Arreglo 2: tamaño 50
    array50: .word 49, 32, 15, 41, 28, 33, 47, 14, 26, 10, 
             38, 22, 5, 11, 18, 23, 37, 44, 16, 30, 
             8, 2, 25, 31, 48, 13, 27, 40, 6, 20, 
             39, 12, 35, 21, 7, 4, 36, 24, 17, 29, 
             19, 1, 45, 34, 3, 42, 9, 46, 0, 43
    size50: .word 50
    
    # Arreglo 3: tamaño 500 (se genera con un patrón)
    array500: .space 2000 
    size500: .word 500
    
    # Arreglo 4: tamaño 5000 (se genera con un patrón)
    array5000: .space 20000
    size5000: .word 5000
    
    # Arreglo 5: tamaño 10000 (se genera con un patrón)
    array10000: .space 40000 
    size10000: .word 10000
    
    newLine: .asciiz "\n"
    space: .asciiz " "
    msgOriginal: .asciiz "Arreglo original: "
    msgSorted: .asciiz "Arreglo ordenado: "
    msgTesting: .asciiz "Probando con arreglo de tamaño: "
    
.text
.globl initialize_arrays

# Función para inicializar los arreglos con valores aleatorios
initialize_arrays:
    # Inicializar array500
    la $a0, array500
    li $a1, 500
    jal fill_array
    
    # Inicializar array5000
    la $a0, array5000
    li $a1, 5000
    jal fill_array
    
    # Inicializar array10000
    la $a0, array10000
    li $a1, 10000
    jal fill_array
    
    jr $ra

# Función para llenar un arreglo con valores pseudo-aleatorios
fill_array:
    move $t0, $a0    # Dirección del arreglo
    move $t1, $a1    # Tamaño del arreglo
    li $t2, 0        # Contador
    
    # Semilla pseudo-aleatoria basada en el tamaño
    move $t3, $a1
    sll $t3, $t3, 1
    addi $t3, $t3, 1
    
    fill_loop:
        sw $t3, 0($t0)        # Almacenar valor
        addi $t0, $t0, 4      # Siguiente posición
        mul $t3, $t3, 1664525
        addiu $t3, $t3, 1013904223
        srl $t4, $t3, 16      
        andi $t3, $t4, 0xFFFF 
        addi $t2, $t2, 1
        blt $t2, $t1, fill_loop
    
    jr $ra

# Función para imprimir un arreglo
print_array:
    move $t0, $a0
    move $t1, $a1
    li $t2, 0
    
    print_loop:
        lw $a0, 0($t0)
        li $v0, 1
        syscall
        
        la $a0, space
        li $v0, 4
        syscall
        
        addi $t0, $t0, 4
        addi $t2, $t2, 1
        blt $t2, $t1, print_loop
    
    la $a0, newLine
    li $v0, 4
    syscall
    
    jr $ra