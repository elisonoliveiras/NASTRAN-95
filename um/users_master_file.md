# 2.5  USER'S MASTER FILE

   As a means of aiding you in handling the large (several boxes of cards)
Bulk Data Decks which are typical of NASTRAN problems, the User's Master File
is provided for storage of many Bulk Data Decks on a single tape. In the
context of this section, a "tape" is synonymous with either a physical tape or
a disk file. (See Section 2.1 for the use of the FILES parameter on the
NASTRAN card.) 

   There are many advantages to using a Master File. The User's Master File
provides a convenient common source of data. Errors due to card handling are
sharply reduced since a several-box input deck is reduced to a few cards.
Finally, the convenience to you in submitting jobs should be emphasized. 

## 2.5.1  Use of User's Master File

   Functionally, the User's Master File exhibits all of the properties of an
Old Problem Tape (OPTP) which would result if a job were terminated after the
NASTRAN preface; only the control cards used are different. Thus the User's
Master File (UMF) becomes an alternate source of bulk data input to NASTRAN
which may be modified in exactly the same way as bulk data is changed during a
modified restart. Since the UMF is used as an alternate OPTP functionally,
only one or the other may appear in a run. The UMF, then, is used only for an
initial run and may not be used in conjunction with a restart. The checkpoint
feature may be used with a UMF run, however, and the resulting New Problem
Tape (NPTP) may be used as an OPTP in a subsequent restart. 

   In describing the use of the User's Master File, the UMF control cards will
be contrasted with their OPTP counterparts. In place of the setup card for the
OPTP tape (see Section 5 of the Programmer's Manual for a discussion of these
machine and installation dependent NASTRAN driver control cards), use a setup
card for the selected UMF tape. In place of the restart dictionary in the
Executive Control Deck, use the card 

      UMF  k1, k2

described in Section 2.2.1, which selects Bulk Data Deck k2 from UMF tape k1
to use in the current execution. 

2.5.2  Using the User's Master File Editor

   To assist you in creating and maintaining User's Master Files, an auxiliary
NASTRAN preface module, the User's Master File Editor, is provided. The
functions performed by the Editor are: 

   1. Create a New User's Master File (NUMF) from Bulk Data Decks supplied by
      you. 

   2. List and/or punch Bulk Data Decks from an already existing UMF.

   3. Edit Bulk Data Decks (which may be modified) from an old UMF onto a
      NUMF. 

   Bulk Data Decks must be acceptable to the NASTRAN preface (XSORT and IFP)
to be accepted by the Editor. 

   The executive control card that causes NASTRAN to execute as the User's
Master File Editor is UMFEDIT. When in the Editor mode, NASTRAN executes only
the preface. A separate run is required to use a User's Master File generated
by the Editor. Preface module UMFEDT, which is where the User's Master File
Editor actions occur, reads data cards from the System Input Stream which are
used to control Editor activity. Some of these data cards precede the Bulk
Data Deck being processed, while others follow. The remainder of this section
will be devoted to describing these cards and the action caused by them.
Section 2.5.3 gives some rules to be followed when making up data cards for
the Editor. Several examples will then be given in Section 2.5.4 to illustrate
the functions performed by the User's Master File Editor. 

   Table 2.5-1 shows the Editor data cards and describes the action taken for
each one. Three classes are described, depending on the tapes used. The cards
are free-field format, as are the executive control cards and case control
cards previously described. The symbolic quantities tid and pid are each up to
8 arbitrarily selected integers chosen by you when you create the User's
Master File. Table 2.5-2 shows a summary of Editor control cards. 

   When a New User's Master File (NUMF) is created, the User's Master File
Editor (UMFEDIT) punches the Executive Control cards that are needed to read
the decks from the newly created master file. The UMFEDIT automatically
punches one UMF Executive Control card for each Bulk Data Deck that is written
on the NUMHF and lists it in a table of contents. 

2.5.3  Rules for the User's Master File Editor

1. The tape identification number, tid, and the problem identification number,
   pid, are positive integers selected by you. The only exception to this is
   that pid may be zero if the UMF card is being used only to specify a value
   for tid or to indicate a new deck rather than an alter set. 

2. The tape identification number, tid, must be the same for all decks on a
   single UMF. 

3. Only one pass is made while either reading the UMF or writing the NUMF.
   Sequential processing requests are thereby required. This means that the
   problem identification numbers must form an increasing sequence
   corresponding to the order of the decks. 

4. A corollary to 2 is that a deck to be inserted between two decks on an
   existing UMF must be given a problem identification number whose value lies
   between the values of the problem identification numbers for the two UMF
   decks. Thus, an initial numbering sequence such as 10, 20, 30, ... is
   recommended. 

5. Host NASTRAN users develop the habit of "storing" data cards not needed for
   a given run behind the ENDDATA card, where they are normally ignored. This
   must not be done when using the Editor, since it reads data from this
   position. Data cards following the FINIS card are ignored, however. 

## 2.5.4  Examples of User's Master File Editor Usage

   Several examples of User's Master File Editor usage are given in this
section. You are well-advised to study these examples both from the standpoint
of understanding the functioning of the Editor and from the standpoint of
learning how to use this NASTRAN feature. A symbolic representation of the
contents of the UMF and/or NUMF used in each example is given along with an
explanation of specific items of interest. These examples illustrate all of
the capability of the User's Master File Editor. 


Example 1. Create a User's Master File

ID  A,B
TIME 1
APP DMAP
BEGIN
END
UMFEDIT
CEND
TITLE =  USER'S MASTER FILE CONTAINS
LABEL =  PROBLEMS 50, 60, ..., 80
ECHO =  BOTH
MAXLINES=50000
BEGIN BULK �
  :        �
  :        �  1st Bulk Data Deck
ENDDATA    �
NUMF  21026, 50
BEGIN BULK �
  :        �
  :        �  2nd Bulk Data Deck
ENDDATA    �
NUMF  21026, 60
  :
  :
BEGIN BULK �
  :        �
  :        �  Last Bulk Data Deck
ENDDATA    �
NUMF  21026, 80
FINIS

Notes:

1. A tape must be set up for NASTRAN file NUMF.

2. A tape must not be set up for NASTRAN file UMF.

3. The DMAP sequence will not be used but must appear in the Executive Control
   Deck. 

4. ECHO = BOTH is recommended since the unsorted Bulk Data Deck is available
   only during the run used to create the User's Master File. The sorted echo
   is needed in order to make alterations to the bulk data when using the
   User's Master File in a NASTRAN run. 

5. Note that the tape identification number, tid, is the same on all of the
   NUMF cards. 

6. Note that the problem identification numbers, pid, are increasing according
   to the data deck order. 


Example 2. List and/or punch selected decks from a User's Master File

ID A,B
TIME 1
APP DMAP
BEGIN
END
UMF 21026, 0
UMFEDIT
CEND
ECHO=NONE
BEGIN BULK
  (blank card)
ENDDATA
LIST 20
PUNCH 50
PUNPRT 60
FINIS

Notes:

1. A tape containing the proper User's Master File must be set up on NASTRAN
   file UMF. 

2. A tape must not be set up for NASTRAN file NUMF.

3. The DMAP sequence will not be used but must appear in the Executive Control
   Deck. 

4. The dummy Bulk Data Deck consisting of a single blank card will not be used
   but must appear. 

5. ECHO = NONE is recommended to suppress printout of the dummy Bulk Data
   Deck. This has no effect on the User's Master File Editor. 

6. The zero value of pid on the UMF card is required since only tid is being
   used in this application. 

7. The LIST, PUNCH, and PUNPRT cards must be sequenced such that the pid
   values form an increasing sequence. 

8. The above requests will cause a sorted Bulk Data Deck echo to be made for
   decks 20 and 60; decks 50 and 60 will be punched. Example 3. Copy a User's
   Master File while listing and/or punching selected decks. 

Example 3. Copy a User's Master File While Listing and/or Punching Selected 
Decks 

ID A,B
TIME 5
APP DMAP
BEGIN
END
UMF 100, 0
UMFEDIT
CEND
ECHO=NONE
BEGIN BULK
  (blank card)
ENDDATA
NUMF 200,0
LIST 30
LIST 50
PUNCH 70
FINIS

Notes:

1. A tape containing the User's Master File to be copied must be set up on
   NASTRAN file UMF. 

2. A tape must be set up on NASTRAN file NUMF.

3. The DMAP sequence is not used but must appear in the Executive Control
   Deck.

4. The dummy Bulk Data Deck consisting of a single blank card will not be used
   but must appear. 

5. ECHO = NONE is recommended to suppress printout of the dummy Bulk Data
   Deck. This has no effect on the User's Master File Editor. 

6. The zero value of pid on the UMF card is required since only tid is being
   used in this application. 

7. The zero value of pid on the NUMF card is not used. This card is used to
   specify tid for the NUMF. If the NUMF card were absent, the same tid would
   be put on the NUMF as existed on the UMF. 

8. The LIST, PUNCH, and PUNPRT cards must be sequenced such that the pid
   values form an increasing sequence. 

9. The above requests will cause a sorted Bulk Data Deck echo to be made for
   decks 20, 30, and 50; decks 20 and 70 will be punched. 

10.   All of the decks contained on the UMF will be copied onto the NUMF tape.
      The tape identification number will be different as explained in Note 7.
      


Example 4. Edit a User's Master File

ID A,B
TIME 5
APP DMAP
BEGIN
END
UMF  21026, 20
UMFEDIT
CEND
TITLE = MODIFICATION OF
SUBTITLE = DECKS 20 AND 50
ECHO = BOTH
BEGIN BULK
  (alter cards for Deck 20)
ENDDATA
NUMF  333, 20
REMOVE 40
UMF  21026, 50
BEGIN BULK
  (alter cards for Deck 50)
ENDDATA
NUMF  333, 55
REMOVE 60
UMF  21026, 0
BEGIN BULK
  (Deck 65)
ENDDATA
NUMF 333, 65
LIST 80
FINIS

Notes:

1. A tape containing the User's Master File to be edited must be set up on
   NASTRAN file UMF. 

2. A tape must be set up on NASTRAN file NUMF.

3. The DMAP sequence is not used but must appear in the Executive Control
   Deck.

4. ECHO = BOTH is recommended since the alter cards are available only during
   the run used to perform the edit. The sorted echo is needed for those decks
   being altered in order to make further alterations to the bulk data when
   using the newly created User's Master File in a NASTRAN run. Decks not
   being altered will not be echoed as a result of the ECHO = BOTH card. Such
   decks may be echoed as they are copied as shown in the example for Deck 80.
   

5. The pid values must form an increasing sequence.

6. The requests in the above example will cause listings to be generated for
   deck 80; no decks will be punched.

7. Decks 30, 70, 80, and 90 will be copied onto the NUMF with no changes.

8. Decks 10, 40, and 60 will be removed (i.e., not copied onto the NUMF).

9. Decks 20 and 50 will be modified. In addition the problem identification
   number of Deck 50 will be changed to 55. 

10.   Deck 65 will be added.

11.   Deck 10 is removed because it appears prior to the first call to the
      Editor. This may be avoided by using a pid of zero and a dummy Bulk Data
      Deck as shown in Example 3. 

Table 2.5-1. User's Master File Editor Control Card Actions.

I.  UMF Only is Present
    A.  FINIS
        1. Terminate run.
    B.  BEGIN BULK        (Not Allowed)
    C.  REMOVE pid        (Not Allowed)
    D.  LIST pid
        1. Skip UMF forward to pid and list the Bulk Data Deck on the printer.
    E.  PUNCH pid
        1. Skip UMF forward to pid and punch the Bulk Data Deck on the punch.
    F.  UMF tid, pid      (Not Allowed)
    G.  NUMF tid, pid     (Not Allowed)
    H.  PUNPRT pid
        1. Skip UMF forward to pid and then list and punch the Bulk Data Deck.
    I.  PRINT tid
        1. List all Bulk Data Decks and Summary Table of Contents.
    J.  TOC tid
        1. List all Bulk Data Decks Summary Table of Contents.

II. NUMF Only is Present
    A.  FINIS
        1. Write end-of-file on NUMF.
        2. Terminate run.
    B.  BEGIN BULK
        1. Process the next Bulk Data Deck.
    C.  REMOVE pid        (Not Allowed)
    D.  LIST pid          (Not Allowed)
    E.  PUNCH pid         (Not Allowed)
    F.  UMF tid, pid      (Not allowed)
    G.  NUMF tid, pid
        1. If first entry to Editor, write tape identification file on NUMF.
        2. Add preceding Bulk Data to NUMF and automatically punch and list
           the UMF card for use with UMF.
    H.  PUNPRT pid        (Not Allowed)
    I.  TOC tid           (Not Allowed)
    J.  PRINT tid         (Not Allowed)

III. Both UMF and NUMF are Present
     A.  FINIS
         1. Copy any remaining Bulk Data Decks from UMF to NUMF.
         2. Write end-of-file on NUMF.
         3. Terminate run.
     B.  BEGIN BULK
         1. Process the next Bulk Data Deck, which may be a new deck or a
            modified deck from the UMF.
     C.  REMOVE pid
         1. Copy UMF onto NUMF up to indicated deck.
         2. Skip indicated deck on UMF.
     D.  LIST pid
         1. Copy UMF onto NUMF through indicated deck.
         2. List indicated Bulk Data Deck on printer.
     E.  PUNCH pid
         1. Copy UMF onto NUMF through indicated deck.
         2. Punch indicated Bulk Data Deck on printer.
     F.  UMF tid, pid
         1. Copy UMF onto NUMF up to indicated deck. (Must be immediately
            followed by BEGIN BULK card.)
     G.  NUMF tid, pid
         1. If first entry to Editor, write tape identification file on NUMF.
         2. Copy UMF onto NUMF up to deck with identification greater than pid.
         3. Add preceding Bulk Data Deck to NUMF and automatically punch and
            list the UMF card for use with UMF.
      H. PUNPRT pid
         1. Copy UMF onto NUMF through indicated deck.
         2. List indicated Bulk Data Deck on printer.
         3. Punch indicated Bulk Data Deck on punch.
      I. TOC tid           (Not Allowed)
      J. PRINT tid         (Not Allowed)

Table 2.5-2. Summary of User's Master File Editor Control Cards.

LIST pid   List the problem deck from UMF or copy the problem deck from UMF
           onto NUMF and list it.

NUMF tid, pid Add problem deck to NUMF, list it, and punch UMF card.

PRINT tid  List all problem decks from UMF and Summary Table of Contents.

PUNCH pid  Punch the problem deck from UMF or copy the problem deck from
           UMF onto NUMF and punch it.

PUNPRT pid Punch and print the problem deck from UMF or copy the problem deck
           from UMF onto NUMF and punch and print it.

REMOVE pid Copy problem decks from UMF onto NUMF up to pid and skip over
           problem pid.

TOC tid    List all problem decks (Summary Table of Contents) by UMF number
           from UMF.

UMF tid, pid  Copy UMF problem deck onto NUMF, list it, and punch UMF card.


# 2.6  USER GENERATED INPUT

   You may want to take a problem previously run on another program and run it
using NASTRAN. In many instances, this provides you with the quickest means of
familiarizing yourself with NASTRAN since you are running a problem which you
understand intimately. Also, you may want to extend your analysis of some
previously analyzed problem into regions which previous programs would not
allow. In either event, you are faced with the problem of input data
conversion. 

   The simplest way to convert structural model data is to write a small
FORTRAN (or other language) program to read in the data cards composing the
input data deck for the previous program and punch a new NASTRAN Bulk Data
Deck. Usually, the information is in a one to one correspondence, and this
procedure is quite straight forward, requiring only a minimal knowledge of
programming. While a large deck of cards may result, by using the User's
Master File feature described in Section 2.5, the amount of large deck
handling may be minimized. 

2.6.1  Utility Module INPUT Usage

   NASTRAN has implemented one data generating utility module within its
existing structure for specific cases. General characteristics of the INPUT
module are as follows: 

   1. INPUT allows you to generate the majority of the bulk data cards for a
      number of selected test problems without having to actually input the
      physical cards into the Bulk Data Deck. 

   2. The test problems for which partial data are generated by INPUT are:

      a. N x N Laplace Network from scalar elements
      b. W x L Rectangular Frame from BAR elements or ROD elements
      c. W x L Rectangular Array of QUAD1 elements
      d. W x L Rectangular Array of TRIA1 elements
      e. N-segment string from scalar elements
      f. N-cell beam made from BAR elements
      g. N-scalar point full matrix with optional unit loading
      h. N-spoke wheel

      These problem types are described separately in the following sections.

   3. To use INPUT, variations of the following alter deck must be used:

      ALTER 1
      PARAM //C,N,NOP/V,N,TRUE=-1 $
      INPUT, ,,,,/G1,G2,----,G5/C,N,a/C,N,b/C,N,b $
      EQUIV G1,GEOM1/TRUE / G2,GEOM2/TRUE----/ G5,GEOM5/TRUE $
      ENDALTER

      The specific data blocks that need to be included depend on the
      particular problem as do the parameter values. Examples for each problem
      type will be given. 

   4. Data cards are read by INPUT from the System Input File using FORTRAN
      I/O, each card containing up to 10 eight column fields. Remember to
      right justify this data. The required data are described in each problem
      type description. 

   5. The INPUT data card(s) follow the ENDDATA card. Do not "store" other
      data that is not intended to be used by the INPUT module. 

   6. Several sample problems were run as part of checkout. The inputs for
      these runs are available as examples of INPUT usage. 

   7. Restart tables are not effective with respect to "cards" generated by
      INPUT since the preface is unaware of their existence. 

   8. The INPUT data generator feature is restrictive. It can only be used in
      the circumstances illustrated. You may employ the INPUT module as
      described but merging of user data with INPUT data is not supported. As
      an example, single point constraints may be defined either in the bulk
      data deck or in the INPUT module data deck but not both places in an
      attempt to combine them. Thus if SPC cards are defined in the bulk data
      deck, then the G4 data block will not be generated and GEOM4 must not be
      equivalenced to G4. 

2.6.1.1  Laplace Circuit (a=1; b=1, 2, or 3; c is not used)

   INPUT generates CELAS4, SPOINT, SPC (for b=1), and CMASS4 (for b=2,3) cards
for the circuit shown. 


                                     Edge c
                        �������������������������������Ŀ
                                                            2
                           �        �        �        �(N+1)  - 1
                           �        �        �        �
                           �        �        �        �
                �          �        �        �        �          �
                �  ��������������������������������������������  �
                �          �        �        �        �          �
                �          �        �        �        �          �
                �          �        �        �        �          �
                �          �        �        �        �          �
                �  ��������������������������������������������  �
                �  3N+4    �        �        �        �          �
                �          �        �        �        �          �
        Edge b  �          �        �        �        �          � Edge d
                �          �        �        �        �          �
                �  ��������������������������������������������  �
                �  2N+3    �        �        �        �          �
                �          �        �        �        �          �
                �          �        �        �        �          �
                �          �        �        �        �          �
                �  ��������������������������������������������  �
                �  N+2     �N+3     �        �        �          �
                           �        �        �        �
                           �        �        �        �
                           �2       �3       �4       �

                        ���������������������������������
                                     Edge a


The scalar point id's are 1 through (N+1)2 except for 1, N+1, N(N+1)+1, and
(N+1)2. For b = 2 or 3, all edge points are replaced with ground. The scalar
elements generated are shown below for each value of b for a typical cell.
Elements between edge points are not generated. 


                  i+N+1                              i+N+1
                   *                                  *
                   �    6                             �    6
                 k  i+10                            k  i+10
                   �                                  �
                   �  i                        fm     �  i
                   *�� ����*                 �Ĵ �����*�� ����*
                  i   k   i+1                      6  i  k   i+1
                                             i+2x10

                   (b = 1)                          (b = 2)

                                  -fm
                            �����Ĵ �����Ŀ
                            �         6   �         -1/2 fm
                       ����Ĵ   i+4x10    �����*����Ĵ �������Ŀ
                       �    �      k      � i+N+1         6    �
                       �    ������� �������         i+6x10     �
                       �             6                         �
                       �         i+10                          �
                       �                                       �
                       �                                       �
                       �          -fm                          �
                       �    �����Ĵ �����Ŀ                    �
                fm     �    �         6   �                    �
             ��Ĵ �����*���Ĵ   i+3x10    ������*���������������
                    6  �i   �      i      �     i+1
              i+2x10   �    ������� �������
                       �           k
                       �
                       �         -1/2 fm
                       ����������Ĵ �������������*
                                       6         i+N+2
                                 i+5x10

                                 (b = 3)

a. Data Card

     1    N    (I8)      N2 = no. of cells

     2    k    (E8.0)    Spring stiffness

     3    U    (E8.0)    Enforced displacement along edge  b  (b = 1)

     3    m    (E8.0)    Mass  (b = 2,3)

     4    f    (E8.0)    Coupling fraction (b = 3 only)

b. Options

   b = 1, statics. Use statics (Rigid Format D-1) to solve V2u = 0 with
          boundary conditions u = 0 along  a ,  c  and  d , u = U along  b.
          G2 and G4 are both used. No masses are generated.

   b = 2, no mass coupling. Use real eigenvalue analysis (Rigid Format D-3)
          to obtain the eigenvalues of a square membrane (V2u = a2u/at2
          where the theoretical solutions for N->�  are given by

                           2    2 1/2
             f    =  1/N {i  + j }   ;   i,j  =  1,2,---
                   ij

          U is ignored. Only G2 is used. Diagonal masses only are
          generated.

   b = 3, mass coupling. Same as where the diagonal masses are m. The
          horizontal and vertical masses are -fm; the cross diagonal masses
          are 1/2 fm.

c. Notes

   (1) For b = 1, SPR = 1000+N must be selected in Case Control Deck.

ID INPUT,CASE1
TIME 30
APP DISP
SOL 1,3
ALTER 1
PARAM //C,N,NOP/V,N,TRUE=-1 $
INPUT, ,,,,/,G2,,G4,/C,N,1/C,N,1 $
EQUIV G2,GEOM2/TRUE  /  G4,GEOM4/TRUE $
ENDALTER
CEND
ECHO=BOTH
TITLE=TEST OF UTILITY MODULE INPUT
SUBTITLE=LAPLACE CIRCUIT
LABEL=STATICS
SPC=1005
OUTPUT
DISP=ALL
BEGIN BULK

{blank card}
ENDDATA


                                       u=0
                        �������������������������������Ŀ

                           �32      �33      �34      �35
                           �        �        �        �
                           �        �        �        �
                �  25      �26      �27      �28      �29     30 �
                �  ��������������������������������������������  �
                �          �        �        �        �          �
                �          �        �        �        �          �
                �          �        �        �        �          �
                �  19      �20      �21      �22      �23     24 �
                �  ��������������������������������������������  �
                �          �        �        �        �          �
                �          �        �        �        �          �
           u=10 �          �        �        �        �          � u=0
                �  13      �14      �15      �16      �17     18 �
                �  ��������������������������������������������  �
                �          �        �        �        �          �
                �          �        �        �        �          �
                �          �        �        �        �          �
                �  7       �8       �9       �10      �11     12 �
                �  ��������������������������������������������  �
                �          �        �        �        �          �
                           �        �        �        �
                           �        �        �        �
                           �2       �3       �4       �5

                        ���������������������������������
                                       u=0


                          Lines indicate scalar springs

2.6.1.2  Rectangular Frame Made from BARs or RODs (a=2; b=1, 2, 3, or 4; c=0, 1, 
2, or 3) 

   INPUT generates GRID, CBAR, or CROD and SEQGP cards for the rectangular
frame shown. 

                   �y
                   �                                       (W+1)(L+1)
                   ��������������������������������������������Ŀ
                   �        �        �        �        �        �
                   �        �        �        �        �        �
                   �        �        �        �        �        �
                   �        �        �        �        �        �
                   ��������������������������������������������Ĵ
                   �        �        �        �        �        �
                   �        �        �        �        �        �
                   �        �        �        �        �        �
                   �        �        �        �        �        �
         �������   ��������������������������������������������Ĵ
         �     W+2 �     W+3�        �        �        �        �
         �         �        �        �        �        �        �
 delta y �         �        �        �        �        �        �
         �         �        �        �        �        �        �
         �������   �������������������������������������������������� x
                   1        2        3        4                W+1
                   �        �
                   �        �
                   ��������Ĵ      i+W+1    i+W+2    6    i+W+1
                     delta x         �\    /(2i)+2x10       �\
                                    6�  \ /              6  �  \               6
                                i+10 �    \   (2i-1)+2x10   �    \  (2i-1)+2x10
                                     �  /   \               �      \
       i+W+1                         � /  i   \             �    i   \
         �                           �����������            �����������
         �    6                      i        i+1           i        i+1
         �i+10
         �                             (c = 1)                (c = 2)
         �    i                        (rods)                 (rods)
         �����������
         i        i+1

            (c = 0)
            (bars)
                               i+W+1                     i+W+1
                                 �                         �\                6
                                6�                        6�  \   (2i-1)+2x10
                            i+10 �                    i+10 �    \
                                 �                         �      \
                                 �    i                    �    i   \
                                 �����������               �����������
                                 i        i+1              i        i+1

                            cells other than on   (c = 3)  cells on left
                            left edge or bottom   (rods)   edge or bottom

a. Data Card

   1    W    (I8)      No. cells in x-direction

   2    L    (I8)      No. cells in y-direction

   3    dx   (E8.0)    Length of cell in x-direction

   4    dy   (E8.0)    Length of cell in y-direction

   5    P    (I8)      Permanent single-point constraints

b. Options (SEQGP cards)

   b = 1, Regular Banding (no SEQGP cards generated)

   b = 2, Double Banding

   b = 3, Active Columns

   b = 4, Reverse Double Banding

   c = 0, Bars

   c = 1, Rods with both diagonals

   c = 2, Rods with UL - LR diagonals

   c = 3, Rods - statically determinate

c. Notes

   (1) A PBAR card with PID of 101 must be supplied as part of the Bulk
   Data for c = 0; for c not equal 0 this is a PROD card.

   (2) If b = 1, SEQGP cards may be included in the Bulk Data.

ID INPUT, CASE2
TIME 30
APP DISP
SOL 1,3
ALTER 1
PARAM //C,N,NOP/V,N,TRUE=-1 $
INPUT, ,,,,/G1,G2,,,/C,N,2/C,N,1 $
EQUIV G1 ,GEOM1 /TRUE  /  G2 ,GEOM2/TRUE  $
ENDALTER
CEND
ECHO=BOTH
TITLE=TEST OF UTILITY MODULE INPUT
SUBTITLE=RECTANGULAR FRAME FROM BARS
LABEL=REGULAR BANDING
SPC=1
LOAD=1
OUTPUT
SET 101 = 1,4,17,20
DISP=101
BEGIN BULK
FORCE         1      20       0     1.0     1.0   0.0    0.0
MAT1          7     1.0     1.0
PBAR        101       7     1.0     2.0     4.0   8.0
SPC           1       1    1234     0.0      4     23    0.0
ENDDATA
       3      4     1.0     2.0     345



                                             19
                        ��������������������������Ŀ
                      17�      18�      19�      20�
                        �        �        �        �
                        �        �        �        �
                        �        �        �        �
                        ��������������������������Ĵ
                      13�      14�      15�      16�
                        �        �        �        �
                        �        �        �        �
                        �   9    �  10    �  11    �
                        ��������������������������Ĵ
                       9�      10�      11�      12�
                        �        �        �        �
                 1000005�        �        �        �
                        �   5    �   6    �   7    �
                        ��������������������������Ĵ
                       5�       6�       7�       8�
                        �        �        �        �
                 1000001� 1000002� 1000005� 1000004�
                        �   1    �   2    �   3    �
                        ����������������������������
                       1        2        3        4

2.6.1.3  Rectangular Plate Made from QUAD1s (a=3; b=1, 2, 3, or 4; c is not 
used) 

   INPUT generates GRID, CQUAD1, SEQGP, OMIT (if requested), and SPC (if
requested) cards for the rectangular grid work shown. 


                                        c
                  ��������������������������������������������Ŀ

                  �y                                      (L+1)(W+1)
             �    ��������������������������������������������Ŀ   �
             �    �        �        �        �        �        �   �
             �    �        �        �        �        �        �   �
             �    �        �        �        �        �        �   �
             �    �        �        �        �        �        �   �
             �    ��������������������������������������������Ĵ   �
             �    �        �        �   �    �        �        �   �
             �    �        �        �   �    �        �        �   �
           b �    �        �        � delta y�        �        �   � d
             �    �        �        �   �    �        �        �   �
             �    ��������������������������������������������Ĵ   �
             �    �   /    �        �        �        �        �   �
             �    �* /     �        ��delta x�        �        �   �
             �    � /      �        �        �        �        �   �
             �    �/�      �        �        �        �        �   �
             �    �����������������������������������������������x �
                  1        2        3                         W+1

                  ����������������������������������������������
                                         a

                   * Represents sweep angle in degrees


                             i+W+1             i+W+2
                               �����������������Ŀ
                               �                 �
                               �                 �
                               �                 �
                               �                 �
                               �        i        �
                               �                 �
                               �                 �
                               �                 �
                               �                 �
                               �������������������
                               i                i+1


a. Data Deck (2 cards required)

   First Card

   1    W      (I8)        No. cells in x-direction

   2    L      (I8)        No. cells in y-direction

   3    dx     (E8.0)      Length of cell in x-direction

   4    dy     (E8.0)      Length of cell in y-direction

   5    IP     (I8)        Permanent Constraints

   6    ^      (E8.0)      Sweep angle in degrees

   7    �      (E8.0)      Material orientation angle in degrees

   Second Card

   1    IY0    (I8)        SPC's on y = 0

   2    IX0    (I8)        SPC's on x = 0

   3    IYL    (I8)        SPC's on y = L x dy

   4    IXW    (I8)        SPC's on x = W x dx

   5    IOX    (I8)        OMIT's in x-direction

   6    IOY    (I8)        OMIT's in y-direction

b. Options (SEQGP cards)

   b = 1, Regular banding (no SEQGP cards generated)

   b = 2, Double banding

   b = 3, Active banding

   b = 4, Reverse double banding

c. Notes

   (1) If IP, IYO, IXO, IYL, IXW, IOX, and IOY are all zero, data block G4
       will be purged.

   (2) A PQUAD1 card with PID = 101 must be included in the Bulk Data.

   (3) IF SPCs are generated the set ID will be 1000NX + NY.

   (4) If b = 1, SEQGP cards may be included in the Bulk Data.

  ID INPUT, CASE3
  TIME 30
  APP DISP
  SOL 1,3
  ALTER 1
  PARAM //C,N,NOP/V,N,TRUE=-1 $
  INPUT, ,,,,/G1,G2,,G4,/C,N,3/C,N,1 $
  EQUIV G1,GEOM1/TRUE  /  G2,GEOM2/TRUE  /  G4,GEOM4/TRUE  $
  ENDALTER
  CEND
  ECHO=BOTH
  TITLE=TEST OF UTILITY MODULE INPUT
  SUBTITLE=RECTANGULAR PLATE MADE FROM CQUAD1'S
  LABEL=STATICS           SIMPLE SUPPORTS         REGULAR BAND
��SPC=5005
� LOAD=1
� OUTPUT
� DISP=ALL
� BEGIN BULK
� FORCE   1         1        0         1.0      0.0     0.0 1.0
� MAT1    7         1.0      1.0
� PQUAD1  101       7        1.0       7        2.0     7   4.0
� ENDDATA
�        5       5      10.0     10.0      126      0.0
�      246     156     12356    12346        0        0
�       �       �        �        �          ����������
�       �       �        �        �               ���������� NO OMITS
�       �   �����        �        �����������������������������������Ŀ
�       �   �            ����������������Ŀ                           �
�       �   �       ��������������������������������������������Ŀ    �
�       �   �   �   ��������������������������������������������Ŀ �  �
�       �   �   �   �        �        �        �        �      36� �  �
�       �   �   �   �        �        �        �        �        � �  �
�       �   �   �   �        �        �        �        �   29   � �  �
�       �   �   �   �        �        �        �        �        � �  �
�       �   �   �   ��������������������������������������������Ĵ �  �
�       �   �   �   �        �        �        �        �        � �  �
�       �   �   �   �        �        �        �        �        � �  �
�       �   �   �   �        �        �        �        �        � �  �
�       �   �   �   �        �        �        �        �        � �  �
�       �   �   �   ��������������������������������������������Ĵ �  �
�       �   �   �   �        �        �        �        �        � �  �
�       �   �   �   �        �        �        �        �        � ����
�       �   ���Ĵ   �        �        �        �        �        � �
�       �       �   �        �        �        �        �        � �
�       �       �   ��������������������������������������������Ĵ �
�       �       �   �        �        �        �        �        � �
�       �       �   �        �        �        �        �        � �
�       �       �   �   7    �        �        �        �        � �
�       �       �   �        �        �        �        �        � �
�       �       �   ��������������������������������������������Ĵ �
�       �       � 7 �       8�       9�      10�      11�      12� �
�       �       �   �        �        �        �        �        � �
�       �       �   �   1    �    2   �   3    �   4    �   5    � �
�       �       �   �        �        �        �        �        � �
�       �       �   ���������������������������������������������� �
�       �          1        2        3        4        5        6
�       �           ����������������������������������������������
�       �                                 �
�       �����������������������������������
�
����� SPC SET ID IS GIVEN BY 1000 * W + L

2.6.1.4  Rectangular Plate Made from TRIA1s (a=4; b=1, 2, 3, or 4; c is not 
used) 

   INPUT generates GRID, CTRIA1, SEQGP, and SPC (if requested) cards for the
rectangular grid work shown. 

                                    c
                           �����������������Ŀ

                           �y            (L+1)(W+1)
                      �    �����������������Ŀ     �
                      �    �        �        �     �
                      �    �        �        �     �
                      �    �        �        �     �
                      �    �        �        �     �
                      �    �����������������Ĵ     �
                      �    �        �        �     �
                      �    �        �        �     �
                    b �    �        �        �     � d
                      �    �        �        �     �
                      �    �����������������Ĵ     �
                      �    �        �        �     �
                      �    �*  /    �        �     �
                      �    �  /     �        �     �
                      �    � / �    �        �     �
                      �    ��������������������� x �
                           1        2       W+1

                           �������������������
                                    a

                            * Represents sweep angle in degrees



               i+W+1     i+W+2                  i+W+1     i+W+2
                 ��������Ŀ                       ��������Ŀ
                 � 2i    /�                       �\   2i  �
                 �     /  �                       �  \     �
                 �   /    �                       �    \   �
                 � / 2i-1 �                       � 2i-1 \ �
                 ����������                       ����������
                 i       i+1                      i       i+1

                   (c = 1)                          (c = 2)


a. Data Deck (2 cards required)

   First Card

   1   W       (I8)       No. cells in x-direction

   2   L       (I8)       No. cells in y-direction

   3   dx      (E8.0)     Length of cell in x-direction

   4   dy      (E8.0)     Length of cell in y-direction

   5   IP      (E8.0)     Permanent constraints

   6   ^       (E8.0)     Sweep angle in degrees

   7   �       (E8.0)     Material orientation angle in degrees

   Second Card

   1   IY0     (I8)       SPC's on y = 0

   2   IX0     (I8)       SPC's on x = 0

   3   IYL     (I8)       SPC's on y = L x dy

   4   IXW     (I8)       SPC's on x = W x dx

b. Options (SEQGP cards)

   b = 1, Regular banding (no SEQGP cards generated)

   b = 2, Double banding

   b = 3, Active banding

   b = 4, Reverse double banding

c. Notes

   (1) If IP, IY0, IX0, IYL and IXW are all zero, G4 will be purged.

   (2) A PTRIA1 card with PID=101 must be included in the Bulk Data.

   (3) If SPCs are generated the set ID will be 1000NX + NY.

   (4) If b=1, SEQGP cards may be included in the Bulk Data.

ID INPUT, CASE 4
TIME 30
APP DISP
SOL 1,3
ALTER 1
PARAM //C,N,NOP/V,N,TRUE=-1 $
INPUT, ,,,,/G1,G2,,G4,/C,N,4/C,N,1/C,N,1 $
EQUIV G1 ,GEOM1 /TRUE / G2,GEOM2/TRUE  /  G4,GEOM4/TRUE  $
ENDALTER
CEND
ECHO=BOTH
TITLE=TEST OF UTILITY MODULE INPUT
SUBTITLE=RECTANGULAR PLATE MADE FROM CTRIA1'S
LABEL=OPTION 1                WITH CLAMPED SUPPORTS
SPC=3005
LOAD=1
OUTPUT
DISP=ALL
BEGIN BULK
FORCE   1      1       0       1.0      0.0    0.0     1.0
MAT1    7      1.0     1.0
PTRIA1  101    7       1.0     7        2.0    7       4.0
ENDDATA
        3     5     2.0     1.0     126     0.0
      246   156  412356  512346
       �     �      �       ��������������������������������Ŀ
       �     �      �                                        �
       �     �      ��������������������Ŀ                   �
       �     �              ��������������������������Ŀ     �
       �     �         �    ��������������������������Ŀ �   �
       �     �         �    �      / �      / �      / � �   �
       �     �         �    �    /   �    /   �    / 24� �   �
       �     �         �    �  /     �  /     �  /     � �   �
       �     �         �    �/       �/       �/       � �   �
       �     �         �    ��������������������������Ĵ �   �
       �     �         �    �      / �      / �      / � �   �
       �     �         �    �    /   �    /   �    /   � �   �
       �     �         �    �  /     �  /     �  /     � �   �
       �     �         �    �/       �/       �/       � �   �
       �     �         �    ��������������������������Ĵ �   �
       �     �         �    �      / �      / �      / � �   �
       �     ���������Ĵ    �    /   �    /   �    /   � �����
       �               �    �  /     �  /     �  /     � �
       �               �    �/       �/       �/       � �
       �               �    ��������������������������Ĵ �
       �               �   9�      / �      / �      / � �
       �               �    � 10 / 10� 12 / 11�    / 12� �
       �               �    �  / 9   �  /11   �  /     � �
       �               �    �/       �/       �/       � �
       �               �    ��������������������������Ĵ �
       �               �   5�      /6�      /7�      /8� �
       �               �    �  2 /   �  4 /   �  6 /   � �
       �               �    �  /  1  �  / 3   �  / 5   � �
       �               �    �/       �/       �/       � �
       �               �    ���������������������������� �
       �                   1        2        3        4
       �
       �                    ����������������������������
       �                                 �
       �����������������������������������

### 2.6.1.5  N-Segment String (a=5; b and c are not used)

   INPUT generates CELAS4, CMASS4, and CDAMP4 cards for an N-segment string
grounded at both ends. 


                        �       �       �       �       �
                       ���     ���     ���     ���     ���
                       � �     � �     � �     � �     � �       (see below)
                       ���     ���     ���     ���     ���
                    1   �   2   �   3   �   4   �       �   N
                ���� ������� ������� ������� ������� ������� ���
                    k1  2   k1  3   k1  4   k1      k1  N   k1





                         ����������������������������Ŀ
                         �                 6          �
                         �           m i+10           �
                         �   ��������Ĵ ���������Ŀ   �
                         �   �                6   �   �
                         �   �       k2 i+3x10    �   �
                      ����������������� ������������������i
                         �   �                    �   �
                         �   �        ���         �   �
                         �   ��������Ĵ �����������   �
                         �            ���    6        �
                         �           b i+2x10         �
                         ������������������������������

a. Data Card

   1      N     (I8)       No. of segments

   2      k1    (E8.0)     Spring value

   3      k2    (E8.0)     Spring value (if zero, none of these elements
                           are generated)

   4      m     (E8.0)     Mass value (if zero, none of these elements are
                           generated)

   $      b     (E8.0)     Damper values (if zero, none of these elements
                           are generated)

b. Notes

   (1) If any of k2, m, or b are zero, those elements will not be
       generated.

ID INPUT, CASE 5
TIME 30
APP DISP
SOL 1,3
ALTER 1
PARAM //C,N,NOP/V,N,TRUE=-1 $
INPUT, ,,,,/,G2,,,/C,N,5 $
EQUIV G2,GEOM2/TRUE $
ENDALTER
CEND
ECHO=BOTH
TITLE=TEST OF UTILITY MODULE INPUT
SUBTITLE=N-SEGMENT STRING
LABEL=STATICS
LOAD=1
OUTPUT
DISP=ALL
BEGIN BULK
SLOAD         1        3    1.0       6     1.0
ENDDATA
       7     1.0    0.0     0.0    0.0



                                                                           /
   /�                                                                     �/
   /�    1         2         3         4         5         6         7    �/
   /*����W����*����W����*����W����*����W����*����W����*����W����*����W����*/
   /�         2         3         4         5         6         7         �/
   /�                                                                     �/
   /

### 2.6.1.6  N-Ce11 Bar (a=6; b and c are not used)

   INPUT generates GRID and CBAR cards for an N-cell bar. OMIT cards will also
be created if requested. 

         1      2      3                      N
     �������������������������         ����������¿
     �������������������������         ������������
     1      2      3      4               N      N+1


a. Data deck

   First Card

   1   N      (I8)        No. of cells

   2   L      (E8.0)      Length of bar

   3   IP     (I8)        Permanent constraints

   4   IFLG   (I8)        Orientation vector flag

   5   IGO    (I8)        GO (used only if IFLG = 2)

   6   M      (I8)        No. of right-most grid points to be connected to
                          GP2 via bars with PID = 102

   7   IOX    (I8)        OMIT card count

   Second Card (Read only if IFLG = 1)

   1   X1     (E8.0)      Orientation vector X1 component

   2   X2     (E8.0)      Orientation vector X2 component

   3   X3     (E8.0)      Orientation vector X3 component

b. Notes

   (1) A PBAR card with PID = 101 is required. If M not equal 0, a PBAR
       card with PID = 102 is required.

   (2) IFLG = 2 option is not allowed for this case.

   (3) Do not include G4 in alter packet unless IOX is greater than 0.

ID INPUT, CASE 6
TIME 30
APP DISP
SOL 1,3
ALTER 1
PARAM //C,N,NOP/V,N,TRUE=-1 $
INPUT, ,,,,/G1,G2,,,/C,N,6 $
EQUIV G1,GEOM1/TRUE  /  G2,GEOM2/TRUE  $
ENDALTER
CEND
ECHO=BOTH
TITLE=TEST OF UTILITY MODULE INPUT
SUBTITLE=N-CELL BAR
LABEL=STATICS
SPC=1
LOAD=1
OUTPUT
SET 101=11
DISP=101
BEGIN BULK
FORCE          1      11       0    1.0      0.0     1.0     1.0
MAT1           7     1.0     1.0
PBAR         101       7     1.0    2.0      4.0     8.0
SPC            1       1  123456    0.0
PARAM  GRDPNT  6
ENDDATA
      10   100.0       0       1      0        0       0
     0.0     0.0     1.0



         1      2      3      4      5      6      7     8       9     10
     ����������������������������������������������������������������������¿
     ������������������������������������������������������������������������
     1      2      3      4      5      6      7      8      9      10     11

### 2.6.1.7  Full Matrix with Optional Unit Load (a=7; b and c are not used)

   INPUT generates N scalar points, all of which are interconnected giving
N(N+1)/2 elements. On option, SLOAD cards are generated for each CELAS4 scalar
point. 

a. Data Card

   1   N       (I8)        Order of problem

   2   NSLOAD  (I8)        Uniform load flag (= 0, will not generate SLOAD
                           cards; not equal 0, will generate SLOAD cards).

b. Notes

   (1) GP1 is altered as shown in the example in order to run efficiently.

   (2) If SLOAD cards are generated the load set ID is N.

ID INPUT, CASE 7
TIME 30
APP DISP
SOL 1,3
ALTER 1
PARAM //C,N,NOP/V,N,TRUE=-1 $
INPUT, ,,,,/,G2,G3,,G5/C,N,7 $
EQUIV G2,GEOM2/TRUE  /  G3,GEOM3/TRUE  $
ALTER 4,4
GP1 GEOM1,G5/GPL,EQEXIH,GPDT,CSTM,BGPDT,SIL/V,N,LUSET/C,N,0/V,N,NOGPDT $
ENDALTER
CEND
ECHO=BOTH
TITLE=TEST OF UTILITY MODULE INPUT
SUBTITLE=FULL MATRIX WITH OPTIONAL UNIT LOAD
LABEL=ORDER = 10
LOAD=10
OUTPUT
DISP=ALL
SPCF=ALL
OLOAD=ALL
ELFO=ALL
BEGIN BULK

{blank card}

ENDDATA
      10    1

### 2.6.1.8  N-Spoked Wheel Made from BAR Elements (a=8; b and c are not used)

   INPUT generates N+1 GRID points, all of which are connected to the last
point, and N CBAR cards. The CBAR cards represent connections around the
circumference and spokes in the wheel as shown in Figure 2.6-1. 

               This figure is not included in the machine readable
               documentation because of complex graphics.

              Figure 2.6-1. N-spoked wheel made from BAR elements

a. Data deck

   First Card

   1    N      (I8)       No. of spokes

   2    XL     (E8.0)     Radius of wheel

   3    IP     (I8)       Permanent constraints on rim

   4    IFLG   (I8)       Orientation vector flag

   5    IGO    (I8)       GO (used only if IFLG = 2)

   6    ICEN   (I8)       Permanent constraints at center

   Second Card

   1    X1     (E8.0)     Orientation vector X1 component

   2    X2     (E8.0)     Orientation vector X2 component

   3    X3     (E8.0)     Orientation vector X3 component

b. Notes

   (1) A PBAR card with PID = 101 is required.

   (2) The option, IFLG = 2, is not allowed for this case.

   (3) A coordinate system with CID = 2 is required. All points, except the
       center, will reference this system.

   (4) The number of spokes, N, cannot exceed 255.

ID INPUT, CASE 8
TIME 10
APP DISP
SOL 1,3
ALTER 1
PARAM //C,N,NOP/V,N,TRUE=-1 $
INPUT GEOM1,GEOM2,,,/G1,G2,,,/C,N,8 $
EQUIV G1,GEOM1/TRUE / G2,GEOM2/TRUE $
ENDALTER
CEND
TITLE = TEST OF UTILITY MODULE INPUT
SUBTITLE = N-SPOKED WHEEL
LABEL = STATICS
LOAD = 20
OUTPUT
DISP = ALL
BEGIN BULK
CORD2C  2       0       0.0    0.0      0.0       1.0      0.0      0.0    +CYL
+CYL    0.0     0.0     1.0
FORCE   20      1       0      1.0      1.0      0.0      0.0
MAT1    7       1.0            0.3
PBAR    101     7       1.0    100.0    100.0
ENDDATA
      8      10.0    12456       1        0    123456
     0.0      0.0      1.0
