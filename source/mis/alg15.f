      SUBROUTINE ALG15 (XDATA,YDATA,NDATA,XIN,YOUT,NXY,NTYPE)
C
      REAL M
C
      DIMENSION M(21), A(21), B(21), D(21), XDATA(2), YDATA(2), XIN(1),
     1YOUT(1)
C
      IF (NDATA-1) 10,10,30
10    DO 20 I=1,NXY
20    YOUT(I)=YDATA(1)
      RETURN
30    IF (NDATA-2) 50,50,40
40    IF (NTYPE) 180,180,50
50    J=1
      I=1
60    IF (XIN(I)-XDATA(2)) 130,130,70
70    IF (XIN(I)-XDATA(NDATA-1)) 80,140,140
80    IF (XIN(I)-XDATA(J)) 100,120,90
90    IF (XIN(I)-XDATA(J+1)) 120,120,100
100   J=J+1
      IF (J-NDATA) 80,110,110
110   J=1
      GO TO 80
120   YOUT(I)=YDATA(J)+(YDATA(J+1)-YDATA(J))/(XDATA(J+1)-XDATA(J))*(XIN(
     1I)-XDATA(J))
      GO TO 150
130   YOUT(I)=YDATA(1)+(YDATA(2)-YDATA(1))/(XDATA(2)-XDATA(1))*(XIN(I)-X
     1DATA(1))
      GO TO 150
140   YOUT(I)=YDATA(NDATA-1)+(YDATA(NDATA)-YDATA(NDATA-1))/(XDATA(NDATA)
     1-XDATA(NDATA-1))*(XIN(I)-XDATA(NDATA-1))
150   IF (I-NXY) 160,170,170
160   I=I+1
      GO TO 60
170   RETURN
180   A(1)=1.0
      B(1)=0.0
      D(1)=0.0
      N=NDATA-1
      DO 190 I=2,N
      A(I)=(XDATA(I+1)-XDATA(I-1))/3.0-(XDATA(I)-XDATA(I-1))*B(I-1)/(6.0
     1*A(I-1))
      B(I)=(XDATA(I+1)-XDATA(I))/6.0
190   D(I)=(YDATA(I+1)-YDATA(I))/(XDATA(I+1)-XDATA(I))-(YDATA(I)-YDATA(I
     1-1))/(XDATA(I)-XDATA(I-1))-(XDATA(I)-XDATA(I-1))*D(I-1)/6.0/A(I-1)
      M(NDATA)=0.0
      DO 200 II=2,N
      I=NDATA+1-II
200   M(I)=(D(I)-B(I)*M(I+1))/A(I)
      M(1)=0.0
      J=1
      I=1
210   IF (XIN(I)-XDATA(1)) 230,260,220
220   IF (XIN(I)-XDATA(NDATA)) 280,270,240
230   JP=1
      KP=2
      GO TO 250
240   JP=NDATA
      KP=NDATA-1
250   YPRIME=(YDATA(KP)-YDATA(JP))/(XDATA(KP)-XDATA(JP))-M(KP)/6.0*(XDAT
     1A(KP)-XDATA(JP))
      YOUT(I)=YDATA(JP)+(XIN(I)-XDATA(JP))*YPRIME
      GO TO 350
260   YOUT(I)=YDATA(1)
      GO TO 350
270   YOUT(I)=YDATA(NDATA)
      GO TO 350
280   IF (XIN(I)-XDATA(J)) 300,320,290
290   IF (XIN(I)-XDATA(J+1)) 340,330,300
300   J=J+1
      IF (J-NDATA) 280,310,310
310   J=1
      GO TO 280
320   YOUT(I)=YDATA(J)
      GO TO 350
330   YOUT(I)=YDATA(J+1)
      GO TO 350
340   DX=XDATA(J+1)-XDATA(J)
      YOUT(I)=M(J)/(6.0*DX)*(XDATA(J+1)-XIN(I))**3+M(J+1)/(6.0*DX)*(XIN(
     1I)-XDATA(J))**3+(XDATA(J+1)-XIN(I))*(YDATA(J)/DX-M(J)/6.0*DX)+(XIN
     2(I)-XDATA(J))*(YDATA(J+1)/DX-M(J+1)/6.0*DX)
350   IF (I-NXY) 360,370,370
360   I=I+1
      GO TO 210
370   RETURN
      END