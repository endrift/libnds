/*---------------------------------------------------------------------------------
	$Id: biosCalls.s,v 1.4 2006-03-03 07:20:14 joatski Exp $

	Copyright (C) 2005
		Michael Noland (joat)
		Jason Rogers (dovoto)
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
	Revision 1.3  2006/01/17 00:13:36  dovoto
	Fixed swi 08 so lable and global matched "swiChangeSoundBias"
	
	Revision 1.2  2005/09/03 13:47:13  wntrmute
	added logging to header
	reformatted for legibility
	

---------------------------------------------------------------------------------*/

	.text
	.align 4

	.thumb

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiSoftReset
	.thumb_func
swiSoftReset:
	swi	0x00
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiDelay
	.thumb_func
swiDelay:
	swi	0x03
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiIntrWait
	.thumb_func
swiIntrWait:
	swi	0x04
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiWaitForVBlank
	.thumb_func
swiWaitForVBlank:
	swi	0x05
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

#ifdef ARM9
	.global swiWaitForIRQ
	.thumb_func
swiWaitForIRQ:
	swi	0x06
	bx	lr
#endif

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

#ifdef ARM7
	.global swiHalt
	.thumb_func
swiHalt:
	swi	0x06
	bx	lr
#endif

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiSleep
	.thumb_func
swiSleep:
	swi	0x07
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiChangeSoundBias
	.thumb_func
swiChangeSoundBias:
	swi	0x08
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiDivide
	.thumb_func
swiDivide:
	swi	0x09
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiRemainder
	.thumb_func
swiRemainder:
	swi	0x09
	mov	r0, r1
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiDivMod
	.thumb_func
swiDivMod:
	push	{r2, r3}
	swi	0x09
	pop	{r2, r3}
	str	r0, [r2]
	str	r1, [r3]
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiCopy
	.thumb_func
swiCopy:
	swi	0x0B
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiFastCopy
	.thumb_func
swiFastCopy:
	swi	0x0C
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiSqrt
	.thumb_func
swiSqrt:
	swi	0x0D
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiCRC16
	.thumb_func
swiCRC16:
	swi	0x0E
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiIsDebugger
	.thumb_func
swiIsDebugger:
	swi	0x0F
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiUnpackBits
	.thumb_func
swiUnpackBits:
	swi	0x10
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiDecompressLZSSWram
	.thumb_func
swiDecompressLZSSWram:
	swi	0x11
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiDecompressLZSSVram
	.thumb_func
swiDecompressLZSSVram:
	swi	0x12
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiDecompressHuffman
	.thumb_func
swiDecompressHuffman:
	swi	0x13
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiDecompressRLEWram
	.thumb_func
swiDecompressRLEWram:
	swi	0x14
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	.global swiDecompressRLEVram
	.thumb_func
swiDecompressRLEVram:
	swi	0x15
	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

#ifdef ARM9
	.global swiDecodeDelta8
	.thumb_func
swiDecodeDelta8:
	swi	0x16
	bx	lr
#endif

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

#ifdef ARM9
	.global swiDecodeDelta16
	.thumb_func
swiDecodeDelta16:
	swi	0x18
	bx	lr
#endif

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

#ifdef ARM7
	.global swiGetSineTable
	.thumb_func
swiGetSineTable:
	swi	0x1A
	bx	lr
#endif

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

#ifdef ARM7
	.global swiGetPitchTable
	.thumb_func
swiGetPitchTable:
	swi	0x1B
	bx	lr
#endif

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

#ifdef ARM7
	.global swiGetVolumeTable
	.thumb_func
swiGetVolumeTable:
	swi	0x1C
	bx	lr
#endif

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@ ARM7 function, but no real point in exposing it, at least not
@ without adding a way to get the 3 arguments back into C
@	.global swiGetFptrs
@	.thumb_func
@swiGetFptrs:
@	swi	0x1D
@	bx	lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

#ifdef ARM7
	.global	swiSwitchToGBAMode
	.thumb_func
swiSwitchToGBAMode:
	mov	r0, #0x40
	swi	0x1F
@ does not return, of course
#endif

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

#ifdef ARM7
	.global swiSetHaltCR
	.thumb_func
swiSetHaltCR:
	mov	r2, r0
	swi	0x1F
	bx	lr
#endif

#ifdef ARM9
	.global swiSetHaltCR
	.thumb_func
swiSetHaltCR:
	swi	0x1F
	bx	lr
#endif

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
