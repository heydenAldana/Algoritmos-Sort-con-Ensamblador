# merge_sort.asm - Implementación del algoritmo Merge Sort

.data
    temp_array: .space 40000  # Espacio para el arreglo temporal (suficiente para 10000 elementos)

.text
.globl merge_sort

# Merge Sort
merge_sort:
    addi $sp, $sp, -12
    sw $ra, 8($sp)
    sw $a1, 4($sp)
    sw $a0, 0($sp)
    
    li $t0, 1
    ble $a1, $t0, end_merge_sort  # Si el tamaño <= 1, no hacer nada
    
    srl $a1, $a1, 1      
    
    # Llamar merge_sort para la primera mitad
    lw $a0, 0($sp)       # Dirección original
    jal merge_sort
    
    # Llamar merge_sort para la segunda mitad
    lw $a0, 0($sp)       # Dirección original
    lw $a1, 4($sp)       # Tamaño original
    srl $t0, $a1, 1      # mid = n/2
    sll $t1, $t0, 2      # mid*4
    add $a0, $a0, $t1    
    sub $a1, $a1, $t0    
    jal merge_sort
    
    # Hacer merge de ambas mitades
    lw $a0, 0($sp)       # Dirección original
    lw $a1, 4($sp)       
    srl $a2, $a1, 1      # mid = n/2
    jal merge
    
end_merge_sort:
    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra

# Función merge
merge:
    addi $sp, $sp, -24
    sw $ra, 20($sp)
    sw $s4, 16($sp)
    sw $s3, 12($sp)
    sw $s2, 8($sp)
    sw $s1, 4($sp)
    sw $s0, 0($sp)
    
    move $s0, $a0        # Dirección del arreglo
    move $s1, $a1        # Tamaño del arreglo
    move $s2, $a2        # mid
    
    # Inicializar índices
    li $s3, 0            # i = 0 (primera mitad)
    li $s4, 0            # j = 0 (segunda mitad)
    move $t0, $s2        # k = mid
    
    # Copiar arreglo a temp_array
    la $t1, temp_array
    move $t2, $s0
    li $t3, 0
    
copy_loop:
    bge $t3, $s1, end_copy
    lw $t4, 0($t2)
    sw $t4, 0($t1)
    addi $t2, $t2, 4
    addi $t1, $t1, 4
    addi $t3, $t3, 1
    j copy_loop
    
end_copy:
    # Reiniciar índices porque es necesario
    li $s3, 0            # i = 0
    move $s4, $s2        # j = mid
    li $t0, 0            # k = 0
    
merge_loop:
    bge $s3, $s2, copy_remaining_right  # Si i >= mid, viene y copia el resto de la derecha
    bge $s4, $s1, copy_remaining_left   # Si j >= n, viene y copia el resto de la izquierda
    
    # Obtener temp_array[i] y temp_array[j]
    la $t1, temp_array
    sll $t2, $s3, 2
    add $t2, $t1, $t2
    lw $t3, 0($t2)       # temp_array[i]
    
    sll $t4, $s4, 2
    add $t4, $t1, $t4
    lw $t5, 0($t4)       # temp_array[j]
    
    ble $t3, $t5, left_less_or_equal
    
    # temp_array[j] es menor
    sw $t5, 0($s0)       # array[k] = temp_array[j]
    addi $s4, $s4, 1     
    j increment_k
    
left_less_or_equal:
    # temp_array[i] es menor o igual
    sw $t3, 0($s0)       # array[k] = temp_array[i]
    addi $s3, $s3, 1     
    
increment_k:
    addi $s0, $s0, 4     
    addi $t0, $t0, 1
    j merge_loop
    
copy_remaining_left:
    bge $s3, $s2, end_merge
    
    # Copiar temp_array[i] a array[k]
    la $t1, temp_array
    sll $t2, $s3, 2
    add $t2, $t1, $t2
    lw $t3, 0($t2)
    sw $t3, 0($s0)
    
    addi $s3, $s3, 1
    addi $s0, $s0, 4
    addi $t0, $t0, 1
    j copy_remaining_left
    
copy_remaining_right:
    bge $s4, $s1, end_merge
    
    # Copiar temp_array[j] a array[k]
    la $t1, temp_array
    sll $t2, $s4, 2
    add $t2, $t1, $t2
    lw $t3, 0($t2)
    sw $t3, 0($s0)
    
    addi $s4, $s4, 1
    addi $s0, $s0, 4
    addi $t0, $t0, 1
    j copy_remaining_right
    
end_merge:
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $s4, 16($sp)
    lw $ra, 20($sp)
    addi $sp, $sp, 24
    jr $ra