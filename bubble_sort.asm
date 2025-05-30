# bubble_sort.asm - Implementación del algoritmo Bubble Sort

.text
.globl bubble_sort

bubble_sort:
    addi $sp, $sp, -20
    sw $ra, 16($sp)
    sw $s3, 12($sp)
    sw $s2, 8($sp)
    sw $s1, 4($sp)
    sw $s0, 0($sp)
    
    move $s0, $a0        # Dirección del arreglo
    move $s1, $a1        # Tamaño del arreglo
    li $s2, 0            # i = 0
    
outer_loop:
    addi $s3, $s1, -1    # n-1
    bge $s2, $s3, end_outer  # if i >= n-1, terminar
    
    li $s3, 0            
    sub $t0, $s1, $s2   
    addi $t0, $t0, -1    
    
inner_loop:
    bge $s3, $t0, end_inner  # if j >= n-i-1, terminar
    
    sll $t1, $s3, 2      
    add $t1, $s0, $t1    
    lw $t2, 0($t1)       
    lw $t3, 4($t1)       
    
    ble $t2, $t3, no_swap  # if array[j] <= array[j+1], no intercambiar
    
    # Intercambiar elementos
    sw $t3, 0($t1)
    sw $t2, 4($t1)
    
no_swap:
    addi $s3, $s3, 1     # j++
    j inner_loop
    
end_inner:
    addi $s2, $s2, 1     # i++
    j outer_loop
    
end_outer:
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $ra, 16($sp)
    addi $sp, $sp, 20
    jr $ra