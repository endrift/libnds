/*---------------------------------------------------------------------------------
	$Id: interruptDispatcher.s,v 1.1 2005-09-03 17:09:35 wntrmute Exp $

	Copyright (C) 2005
		Dave Murphy (WinterMute)

	This software is provided 'as-is', without any express or implied
	warranty.  In no event will the authors be held liable for any
	damages arising from the use of this software.

	Permission is granted to anyone to use this software for any
	purpose, including commercial applications, and to alter it and
	redistribute it freely, subject to the following restrictions:

	1.	The origin of this software must not be misrepresented; you
		must not claim that you wrote the original software. If you use
		this software in a product, an acknowledgment in the product
		documentation would be appreciated but is not required.
	2.	Altered source versions must be plainly marked as such, and
		must not be misrepresented as being the original software.
	3.	This notice may not be removed or altered from any source
		distribution.

	$Log: not supported by cvs2svn $

---------------------------------------------------------------------------------*/

#ifdef ARM7
	.text
#endif

#ifdef ARM9
	.section	.itcm,"ax",%progbits
#endif

	.extern	IntrTable
	.code 32

	.global	IntrMain
@---------------------------------------------------------------------------------
IntrMain:
@---------------------------------------------------------------------------------
	mov	r3, #0x4000000		@ REG_BASE

	ldrh	r1, [r3, #0x8]		@ r1 = IME
	mrs	r0, spsr
	stmfd	sp!, {r0-r1,r3,lr}	@ {spsr, IME, REG_BASE, lr}

	ldr	r1, [r3,#0x210]		@ REG_IE
	ldr	r2, [r3,#0x214]		@ REG_IF
	and	r1,r1,r2

#ifdef ARM7
	ldr	r2, [r3, #-8]		@\mix up with BIOS irq flags at 3007FF8h,
	orr	r2, r2, r1		@ aka mirrored at 3FFFFF8h, this is required
	str	r2, [r3, #-8]		@/when using the (VBlank)IntrWait functions
#endif

#ifdef ARM9
	ldr	r0,=0x00803FF8
	ldr	r2,[r0]
	orr	r2,r2,r1
	str	r2,[r0]
#endif

	ldr	r2,=irqTable
@---------------------------------------------------------------------------------
findIRQ:
@---------------------------------------------------------------------------------
	ldr	r0, [r2, #4]
	cmp	r0,#0
	beq	no_handler
	ands	r0, r0, r1
	bne	jump_intr
	add	r2, r2, #8
	b	findIRQ

@---------------------------------------------------------------------------------
no_handler:
@---------------------------------------------------------------------------------
	str	r1, [r3, #0x214]	@ IF Clear
        ldmfd   sp!, {r0-r1,r3,lr}	@ {spsr, IME, REG_BASE, lr}
	mov	pc,lr

@---------------------------------------------------------------------------------
jump_intr:
@---------------------------------------------------------------------------------
	ldr	r0, [r2]		@ user IRQ handler address
	cmp	r0,#0
	beq	no_handler

	str	r1, [r3, #0x214]	@ IF Clear

	mrs	r2, cpsr
	bic	r2, r2, #0xdf		@ \__
	orr	r2, r2, #0x1f		@ /  --> Enable IRQ & FIQ. Set CPU mode to System.
	msr	cpsr,r2

	stmfd	sp!, {lr}
	adr	lr, IntrRet
	bx	r0

@---------------------------------------------------------------------------------
IntrRet:
@---------------------------------------------------------------------------------
	ldmfd	sp!, {lr}

	mrs	r3, cpsr
	bic	r3, r3, #0xdf		@ \__
	orr	r3, r3, #0x92		@ /  --> Disable IRQ. Enable FIQ. Set CPU mode to IRQ.
	msr	cpsr, r3

        ldmfd   sp!, {r0-r1,r3,lr}	@ {spsr, IME, REG_BASE, lr}
	strh	r1, [r3, #0x8]		@ restore REG_IME
	msr	spsr, r0		@ restore spsr
	mov	pc,lr

	.pool
	.end

