.text
mov r1,#0
mov r7,#0
@ldr r7,=mem
mov r3,#4
sub r2,r1,#3
str r2,[r7,#4]!
ldr r4,[r7]
add r7,r7,#2
strh r2,[r7],r3
sub r7,r7,#4
ldr r5,[r7]
ldrh r6,[r7]
ldrsh r8,[r7]
ldrb r9,[r7]
ldrsb r10,[r7]


@only half-word
@str - done
@strh - done
@strb
@ldr - done
@ldrh
@ldrsh
@ldrb
@ldrsb
@pre-increment - done
@post increment - done
@with constant - done
@with variable - done
@normal
@checked for fffd

.data

mem: .space 200
