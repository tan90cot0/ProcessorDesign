.text
mov r1,#0
mov r7,#0
@ldr r7,=mem
mov r3,#4
sub r2,r1,#3
strb r2,[r7]
ldr r4,[r7]
ldrh r6,[r7]
ldrsh r8,[r7]
ldrb r9,[r7]
ldrsb r10,[r7]


@only bytes
@str
@strh
@strb - done
@ldr
@ldrh
@ldrsh
@ldrb
@ldrsb
@checked for fffd

.data

mem: .space 200
