.SEGMENT/PM seg_rth;
nop;
nop;
nop;
nop;
nop;
jump start;
.ENDSEG;

.SEGMENT/DM seg_dmda;
.VAR X[4] = 0xa01, 0x3d1, 0x0f1, 0xf23;
.VAR Y[4] = 0x4f2, 0xf30, 0x7ed, 0xc23;
.VAR Z[5];


.ENDSEG;


.SEGMENT/PM seg_pmco;

start:
//programa
i0 = X;
i1 = Y;
i2 = Z;


lcntr = 4, do met until lce;
//ci = 0;
r0 = dm(i0, 1);
r1 = dm(i1, 1);
r2 = r0 + r1 + ci;
met: dm(i2, 1) = r2;

r4 = 0;
r4 = r4 + ci;
dm(i2, 0) = r4;

.ENDSEG;