.SEGMENT/PM seg_rth;
nop; nop; nop; nop; nop;
jump start;
.ENDSEG;

.SEGMENT/DM seg_dmda;
.VAR Init[5] = 0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476, 0xc3d2e1f0;
.VAR Kconst[4] = 0x5a827999, 0x6ed9eba1, 0x8f1bbcdc, 0xca62c1d6;
.VAR M[16] = 0x10000000, 0x20000000, 0x30000000, 0x40000000, 
		0x50000000, 0x60000000, 0x70000000, 0x80000000,
		0x90000000, 0x10000000, 0x11000000, 0x12000000, 
		0x13000000, 0x14000000, 0x15000000, 0x16000000;
.VAR W[80];
.Var SHA1[5];
.ENDSEG;


.SEGMENT/PM seg_pmco;

start:
//programa
i0 = Init;
i1 = Kconst;
i2 = M;
i3 = W;
i4 = SHA1;

lcntr = 16, do W0to15 until lce;
   r0 = dm(i2,1);
W0to15: dm(i3,1) = r0;

lcntr = 64, do W16to79 until lce;
   r0 = -3; r1 = -8; r2 = -14; r3 = -16;
   m0 = r0; m1 = r1; m2 = r2; m3 = r3;

   r0 = dm(m0, i3); r1 = dm(m1, i3);
   r2 = dm(m2, i3); r3 = dm(m3, i3);

   r0 = r0 xor r1;
   r0 = r0 xor r2;
   r0 = r0 xor r3;
   r1 = 1;
   r0 = rot r0 by r1; 
W16to79: dm(i3,1) = r0;
r0 = dm(i3,-20);
r0 = dm(i3,-20);
r0 = dm(i3,-20);
r0 = dm(i3,-20);

r0 = dm(i0,1); //a
r1 = dm(i0,1); //b
r2 = dm(i0,1); //c
r3 = dm(i0,1); //d
r4 = dm(i0,1); //e
r5 = dm(i0,-5);


r7 = dm(i1,1);   // k0 to k19
lcntr = 20, do main0to19 until lce;
   call (F0to19);
   call (TEMP);
   call (Swap);
main0to19: r0 = r5 + r6;

r7 = dm(i1,1);
lcntr = 20, do main20to39 until lce;
   call (F20to39and60to79);
   call (TEMP);
   call (Swap);
main20to39: r0 = r5 + r6;

r7 = dm(i1,1);
lcntr = 20, do main40to59 until lce;
   call (F40to59);
   call (TEMP);
   call (Swap);
main40to59: r0 = r5 + r6;

r7 = dm(i1,1);
lcntr = 20, do main60to79 until lce;
   call (F20to39and60to79);
   call (TEMP);
   call (Swap);
main60to79: r0 = r5 + r6;

r5 = dm(i0,1);
r0 = r0 + r5;
dm(i4,1) = r0;
r5 = dm(i0,1);
r1 = r1 + r5;
dm(i4,1) = r1;
r5 = dm(i0,1);
r2 = r2 + r5;
dm(i4,1) = r2;
r5 = dm(i0,1);
r3 = r2 + r5;
dm(i4,1) = r3;
r5 = dm(i0,1);
r4 = r4 + r5;
dm(i4,1) = r4;


//--------------SubFunction------------------

F0to19:	
r6 = r1 and r2;		//b ^ c
r7 = not r1;		//~b
r8 = r7 and r3;		//(~b) ^ d
r6 = r6 or r8;		//(b ^ c) v ((~b) ^ d)
rts;

F20to39and60to79:
r6 = r1 xor r2;    	// b xor c xor d
r6 = r6 xor r3;
rts;

F40to59:		
r6 = r1 and r2;		// b and c
r7 = r1 and r3; 	// b and d
r8 = r2 and r3;		// c and d
r6 = r6 or r7;
r6 = r6 or r8;
rts;

TEMP:
  r9 = 5;
  r8 = dm(i3,1);	// get Wt
  r5 = rot r0 by r9;   	// a <<< 5
  r5 = r5 + r4;		// + e
  r5 = r5 + r6;		// + ft
  r5 = r5 + r7;		// + kt
  r5 = r5 + r8;		// + Wt
rts;

Swap:
  r6 = 0; r7 = 30;
  r4 = r3 + r6;
  r3 = r2 + r6;
  r2 = rot r1 by r7;
  r1 = r0 + r6;
  //r0 = r5 + r6;
rts;

.ENDSEG;










