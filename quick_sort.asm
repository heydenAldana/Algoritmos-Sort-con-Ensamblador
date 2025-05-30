# quick_sort.asm - Implementación del algoritmo Quick Sort

.text
.globl quick_sort

# Quick Sort
quick_sort:
    addi $sp, $sp, -12
    sw $ra, 8($sp)
    sw $a1, 4($sp)
    sw $a0, 0($sp)
    
    li $t0, 1
    ble $a1, $t0, end_quick_sort  # Si el tamaño <= 1, no hacer nada
    
    # Llamar a partition para obtener el índice del pivote
    li $a2, 0            
    addi $a3, $a1, -1   
    jal partition
    
    move $t0, $v0
    
    # Llamar quick_sort para la primera parte (low..pi-1)
    lw $a0, 0($sp)       # Dirección original
    move $a1, $t0        # pi
    jal quick_sort
    
    # Llamar quick_sort para la segunda parte (pi+1..high)
    lw $a0, 0($sp)       # Dirección original
    sll $t1, $t0, 2      # pi*4
    add $a0, $a0, $t1    
    addi $a0, $a0, 4     
    lw $a1, 4($sp)      
    sub $a1, $a1, $t0    # n - pi
    addi $a1, $a1, -1    # n - pi - 1
    jal quick_sort
    
end_quick_sort:
    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra

# Función partition
partition:
    addi $sp, $sp, -20
    sw $ra, 16($sp)
    sw $s3, 12($sp)
    sw $s2, 8($sp)
    sw $s1, 4($sp)
    sw $s0, 0($sp)
    
    move $s0, $a0        # Dirección del arreglo
    move $s1, $a1        # low
    move $s2, $a2        # high
    
    # pivot = array[high]
    sll $t0, $s2, 2      # high*4
    add $t0, $s0, $t0    
    lw $s3, 0($t0)       
    
    move $t1, $s1        # i = low - 1
    addi $t1, $t1, -1
    
    move $t2, $s1        # j = low
    
partition_loop:
    bge $t2, $s2, end_partition_loop  # if j >= high, terminar
    
    # array[j]
    sll $t3, $t2, 2      # j*4
    add $t3, $s0, $t3    
    lw $t4, 0($t3)      
    
    bgt $t4, $s3, increment_j  # if array[j] > pivot, saltar
    
    addi $t1, $t1, 1     # i++
    
    # Intercambiar array[i] y array[j]
    sll $t5, $t1, 2      # i*4
    add $t5, $s0, $t5   
    lw $t6, 0($t5)      
    
    sw $t4, 0($t5)       
    sw $t6, 0($t3)       
    
increment_j:
    addi $t2, $t2, 1     # j++
    j partition_loop
    
end_partition_loop:
    # Intercambiar array[i+1] y array[high] (pivote)
    addi $t1, $t1, 1     
    sll $t3, $t1, 2      
    add $t3, $s0, $t3    
    lw $t4, 0($t3)       
    
    sll $t5, $s2, 2      
    add $t5, $s0, $t5  
    lw $t6, 0($t5)       
    
    sw $t6, 0($t3)      
    sw $t4, 0($t5)      
    
    # Devolver i+1 (índice del pivote)
    move $v0, $t1
    
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $ra, 16($sp)
    addi $sp, $sp, 20
    jr $ra