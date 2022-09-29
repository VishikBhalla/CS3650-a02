#
#Usage: ./calculator <op> <arg1> <arg2>
#

# Make `main` accessible outside of this module
.global main

# Start of the code section
.text

# int main(int argc, char argv[][])
main:
  # Function prologue
  enter $0, $0

  # Variable mappings:
  # op -> %r12
  # arg1 -> %r13
  # arg2 -> %r14
  movq 8(%rsi), %r12  # op = argv[1]
  movq 16(%rsi), %r13 # arg1 = argv[2]
  movq 24(%rsi), %r14 # arg2 = argv[3]


  # Hint: Convert 1st operand to long int
  mov %r13, %rdi
  call atol
  mov %rax, %r13

  # Hint: Convert 2nd operand to long int
  mov %r14, %rdi
  call atol
  mov %rax, %r14

  # Hint: Copy the first char of op into an 8-bit register
  # i.e., op_char = op[0] - something like mov 0(%r12), ???
  # if (op_char == '+') {
  #   ...
  # }
  # else if (op_char == '-') {
  #  ...
  # }
  # ...
  # else {
  #   // print error
  #   // return 1 from main
  # }
  
   mov 0(%r12), %cl
 
  mov $'+', %dl 
  cmp %dl, %cl
  je addition

  
  mov $'-', %dl
  cmp %dl, %cl
  je subtraction

  mov $'*', %dl
  cmp %dl, %cl
  je multiplication

  mov $'/', %dl
  cmp %dl, %cl
  je division
	
  jmp print_error
addition:
	mov $0, %rax
	add %r13,%rax
  	add %r14, %rax	
	jmp print_val
  
subtraction:
	mov $0, %rax
        add %r13, %rax
        sub %r14, %rax
	jmp print_val

multiplication:
	mov $0, %rax
	add %r13, %rax
	imul %r14
	jmp print_val
 
division:
	mov $0, %rdx
	mov $0, %rax
        add %r13, %rax
        idiv  %r14
        jmp print_val

print_val:
	mov $format, %rdi
	mov %rax, %rsi	
	call printf
	leave
	ret

print_error:
	mov $err, %rdi
	call printf
	leave
	ret	
# Start of the data section
.data
addi: .string "+"
subt: .string "-"
mult: .string "*"
divide: .string "/"
err: .string "An error occurred. 
"
format: 
  .asciz "%ld\n"
