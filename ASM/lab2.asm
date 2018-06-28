.SEGMENT/PM seg_rth;
nop;
nop;
nop;
nop;
nop;
jump start;
.ENDSEG;

.SEGMENT/DM seg_dmda;
.VAR Block[2] = 0x12345678, 0x87654321;
.VAR Key[8] = 0x10000000, 0x20000000, 0x30000000, 0x40000000, 0x50000000, 0x60000000, 0x70000000, 0x80000000;
.VAR Result[2];
.VAR Subst[16] = 1, 3, 14, 7, 4, 12, 6, 15, 9, 0, 11, 10, 13, 5, 8, 2;


.ENDSEG;


.SEGMENT/PM seg_pmco;

start:
//programa
i0 = Block;
i1 = Key;
i2 = Result;
i3 = Subst;
r0 = dm(i0, 1);	//left 32 Bit
r1 = dm(i0, 0);	//righ 32 Bit

lcntr = 3, do met until lce;

lcntr = 8, do met1 until lce;
r2 = dm(i1, 1); //r2 = Ki
r3 = r1 + r2 +ci;

call (sub);

//<<< 11
r3 = 0xb;
r4 = rot r6 by r3;
r5 = r0 xor r4;

//XOR
r3 = 0;
r0 = r1 + r3;
met1: r1 = r5 + r3;

met:r2 = dm(i1,-8);

r2 = dm(i1,7);
lcntr = 8, do met3 until lce;
r2 = dm(i1, -1); //r2 = Ki
r3 = r1 + r2 +ci;

call (sub);

r3 = 0xb;
r4 = rot r6 by r3;	//<<< 11
r5 = r0 xor r4;		//XOR

r3 = 0;
r0 = r1 + r3;
met3: r1 = r5 + r3;

dm(i2,1) = r0;
dm(i2,0) = r1;

sub:r4 = 0x100;
r5 = 4;
r6 = 0;
lcntr = 8, do met2 until lce;
r7 = fext r3 by r4;
m0 = r7;
r8 = dm(m0, i3);
r6 = r6 or fdep r8 by r4;
met2: r4 = r4 + r5;

rts;

.ENDSEG;