/*
 * Use reserved instruction.
 * See gdb/sim/mips/interp.c:signal_exception(),sim_monitor()
 * (ReservedInstruction)
 * Memory address is defined by K0BASE. (See gdb/sim/mips/interp.c)
 */

#define SYS_exit  17
#define SYS_open   6
#define SYS_read   7
#define SYS_write  8
#define SYS_close 10

#if 1 /* New definition (changed from gdb-7.11) */
#define RSVD_INSTRUCTION 0x00000039
#else /* Old definition (until gdb-7.10.1) */
#define RSVD_INSTRUCTION 0x00000005
#endif
#define RSVD(arg) ((((arg) << 1) << 6) | RSVD_INSTRUCTION)

/* #define EXIT_BY_SYSCALL */
#define EXIT_BY_BREAK

	.section .text

	.globl	__read
	.type	__read, @function
__read:
	.long	RSVD(SYS_read)
	jr	$ra
	nop

	.globl	__write
	.type	__write, @function
__write:
	.long	RSVD(SYS_write)
	jr	$ra
	nop

	.globl	__open
	.type	__open, @function
__open:
	.long	RSVD(SYS_open)
	jr	$ra
	nop

	.globl	__close
	.type	__close, @function
__close:
	.long	RSVD(SYS_close)
	jr	$ra
	nop
