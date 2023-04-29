include console.inc

COMMENT @

	���� ���� ������, �������� ������, ��������� ������, ��������� ������, �������� ������� �� �����
	����� � �������� ���������� ��������, ������������ ����� ��������� �������: 25
	��� ����� � �������� ��������: 1 ���� db -128 +127
	������������� ������������ ��������� � ����� ������ ��� ������������ ������: 99*99*25 = +-245025
	
	____________________________________________________________________________________
	
	��������� ������
	____________________________________________________________________________________
	
@
.data
	maxMatrElement  db 25 
	
	matr1 		dw 25 dup (0)		; ����������� ������ ��� ������ ������� 25 ���������
	lines1 		db 0			; ���������� ����� � ������ �������
	columns1 	db 0			; ���������� �������� � ������ �������
	elements1 	db 0			; ���������� ��������� � ������ �������
	matr2 		dw 25 	dup (0)		; ����������� ������ ��� ������ ������� 25 ���������
	lines2 		db 0			; ���������� ����� �� ������ �������
	columns2 	db 0			; ���������� �������� �� ������ �������
	elements2 	db 0			; ���������� ��������� �� ������ �������
	num 		db 0			; ����� ��� ��������� �������
	num1 		db 0			; ����� ��� ��������� �� ������ �������
	num2 		db 0			; ����� ��� ��������� �� ������ �������
	num3 		dw 0			;
	act 		db 0			; ����� �������� ��� ���������
	matr3 		dw 25 	dup (0)		; ����������� ������ ��� ������ ������� 25 ���������
	
	counterI	db ?
	counterJ	db ?
	counterK	db ?	

	temp		db ?
	temp1		db ?
	temp2		db ?
	temp3		db ?
	index		db ?
	
	wtemp		dw ?
	
	sumIr		dw	?

	switch		db ?
.code


Start:
	ClrScr
	jmp 		outOneMatrix;



outOneMatrix:
	outstrln '����� � �������� ���������� ��������, ������������ ����� ��������� �������: 25'
	outstrln '������� ���������� ����� ������ �������'
	inint 		lines1			
	outstrln '������� ���������� �������� ������ �������'
	inint 		columns1
		
	mov 		al,lines1		
	MUL 		columns1		; ��������� ��������� AL � columns1 = AX
	
	; �������� ������ ��� ������ �������� ���� ������ �� ���������
	cmp		ax, 25
	jg		printOverMax1;	
	;
	mov 		elements1, al		
	outstr 	       '���������� ��������� ������ �������: '
	outwordln 	elements1
	
	outstrln '������� ��������������� �������� ������ �������'
	mov ebx,0;
	mov counterI, bl
	mov edx,2;
	mov temp, dl
	mov eax,0;

	LOOP1:	
		mov		al, counterI
		MUL		temp
		inint 		matr1[eax]
		inc 		counterI
		mov		bl, counterI
		CMP 		bl, elements1
		JL		LOOP1


	jmp printOneMatrix
		
	

printOneMatrix:
	; columns1 	 lines1
	mov ebx,0;
	mov counterI, bl
	mov counterJ, bl
	mov edx,2;
	mov temp, dl
	mov eax,0;
	mov temp1, al;
	
	printOneMatrixLOOPline:
		mov		edx, 0
		mov		counterJ,dl
		MOV		al, counterI
		MUL		columns1
		printOneMatrixLOOPcolumns:
			MOV		al, counterI
			MUL		columns1
			ADD	al, counterJ;
			MUL	temp
			outint matr1[eax], 8; matr1[(counterI*columns1+counterJ)*2]		
			inc	counterJ
			mov	dl, counterJ
			cmp	dl, columns1
			jl	printOneMatrixLOOPcolumns
		outstrln
		inc	counterI
		mov	dl, counterI
		cmp 	dl, lines1
		jl  printOneMatrixLOOPline

	jmp		outTwoMatrix


outTwoMatrix:
	outstrln '������� ���������� ����� ������ �������'
	inint 		lines2			
	outstrln '������� ���������� �������� ������ �������'
	inint 		columns2
		
	mov 		al,lines2		
	MUL 		columns2		; ��������� ��������� AL � columns1 = AX
	
	; �������� ������ ��� ������ �������� ���� ������ �� ���������
	cmp		ax, 25
	jg		printOverMax2;	
	;
	mov 		elements2, al		
	outstr 	       '���������� ��������� ������ �������: '
	outwordln 	elements2
	
	outstrln '������� ��������������� �������� ������ �������'
	mov ebx,0;
	mov counterI, bl
	mov edx,2;
	mov temp, dl
	mov eax,0;

	LOOP2:	
		mov		al, counterI
		MUL		temp
		inint 		matr2[eax]
		inc 		counterI
		mov		bl, counterI
		CMP 		bl, elements1
		JL		LOOP2


	jmp printTwoMatrix
		
	


	printTwoMatrix:
		mov eax,0;
		mov bl,columns2;
		mov bh, lines2;
		mov counterI, 0
		mov temp, 2
		printTwoMatrixLOOPline:
			mov		counterJ, 0
			printTwoMatrixLOOPcolumns:
				outint matr2[eax], 8;
				ADD		eax, 2
				inc		counterJ;
				cmp		counterJ, bl
				jl	printTwoMatrixLOOPcolumns
			outstrln
			inc		counterI
			cmp 	counterI, bh
			jl  printTwoMatrixLOOPline


	jmp		printMenue



printMenue:
	outstrln '�������� ������: '
	outstrln
	outstrln '1) ����������� �������'
	outstrln '2) +'
	outstrln '3) -'
	outstrln '4) *'
	outstrln '5) �'
	outstrln '6) end'
	inint switch
	
	mov	dl, 5
	cmp	switch,dl
	jg	printMenue
	
	mov	dl, 1
	cmp	switch, dl
	jl	printMenue

	
	cmp	switch, dl
	je	outOneMatrix
	
	mov	dl, 2
	cmp	switch, dl
	je	plusMatrix

	mov	dl, 3
	cmp	switch, dl
	je	subMatrix

	mov	dl, 4
	cmp	switch,dl
	je	mulElementsMatrix
	
	mov	dl, 5
	cmp	switch, dl
	je	mulMatrix
	
	mov	dl, 6
	cmp	switch ,dl
	je	exete
	
	jmp exete


plusMatrix:
	; ���������� ����������� ������ row == row and col == col
	mov 	eax, 0
	mov	al, lines1
	mov	ah, lines2 
	XOR	al, ah
	mov	ah, columns1
	XOR	al, ah
	mov	ah, columns2
	XOR	al, ah
	mov	dl, 00000000b
	mov	temp, dl
	cmp	al, temp
	JNE	printMenue
	; ------------------------------------------------------
	mov eax, 0 ; �������
	mov counterI, 0;
	mov bl, elements1;
	mov temp, 2;
	plusMatrixLoop:
		;matr[3]=matr1[i] + matr2[i]
		mov 	dx, matr1[eax]
		mov		matr3[eax], dx
		mov 	dx, matr2[eax]
		ADD		matr3[eax], dx
		ADD		eax, 2
		inc		counterI;
		cmp		counterI, bl
		JL		plusMatrixLoop
	
	printThreMatrix:
		mov eax,0;
		mov bl,lines1;
		mov bh, columns2;
		mov counterI, 0
		mov temp, 2
		mov temp1, al;
		printThreMatrixLOOPline:
			mov		counterJ, 0
			printThreMatrixLOOPcolumns:
			; print(matrix[eax]); eax = eax + 2; counterI++
				outint matr3[eax], 8;
				ADD		eax, 2
				inc		counterJ;
				cmp		counterJ, bl
				jl	printThreMatrixLOOPcolumns
			outstrln
			inc		counterI
			cmp 	counterI, bh
			jl  printThreMatrixLOOPline

	jmp		printMenue
		
		

subMatrix:
	; ���������� ����������� ������ row == row and col == col
	mov 	eax, 0
	mov	al, lines1
	mov	ah, lines2 
	XOR	al, ah
	mov	ah, columns1
	XOR	al, ah
	mov	ah, columns2
	XOR	al, ah
	mov	dl, 00000000b
	mov	temp, dl
	cmp	al, temp
	JNE	printMenue
	; ------------------------------------------------------
	mov eax, 0 ; �������
	mov counterI, 0;
	mov bl, elements1;
	mov temp, 2;
	subMatrixLoop:
		;matr[3]=matr1[i] - matr2[i]
		mov 	dx, matr1[eax]
		mov		matr3[eax], dx
		mov 	dx, matr2[eax]
		SUB		matr3[eax], dx
		ADD		eax, 2
		inc		counterI;
		cmp		counterI, bl
		JL		subMatrixLoop
		jmp 	printThreMatrix
		

mulElementsMatrix:
	; ���������� ����������� ������ row == row and col == col
	mov 	eax, 0
	mov	al, lines1
	mov	ah, lines2 
	XOR	al, ah
	mov	ah, columns1
	XOR	al, ah
	mov	ah, columns2
	XOR	al, ah
	mov	dl, 00000000b
	mov	temp, dl
	cmp	al, temp
	JNE	printMenue
	; ------------------------------------------------------
	mov eax, 0 ; �������
	mov counterI, 0;
	mov counterJ, 0;
	mov bl, elements1;
	mov wtemp, 0;
	mulElementsMatrixLoop:
		;matr[3]=matr1[i] - matr2[i]
		mov 	al, counterJ;
		; temp = matr1[i]
		; eax = i*2
		mov 	dx, matr1[eax]
		mov		wtemp, dx
		; eax = matr2[eax]
		mov 	ax, matr2[eax]
		; wtemp = matr2[eax] * wtemp
		MUL		wtemp;
		mov 	wtemp, ax;
		mov		al, counterJ;
		mov 	dx, wtemp;
		mov		matr3[eax], dx; 
		ADD		counterJ,2
		inc		counterI;
		cmp		counterI, bl
		JL		mulElementsMatrixLoop
		jmp 	printThreMatrix	
	jmp	printMenue

mulMatrix:
	; ���������� ����������� ������ row == col and col == row
	mov 	eax, 0
	mov	al, columns1
	cmp	al, lines2
	JNE	printMenue
	; ------------------------------------------------------
	mov eax, 0 ; �������
	mov edx, 0 ;
	mov counterI, 0;
	
	
	mov index, 0;
	mov temp,  2
	mov temp1, 0;
	mov wtemp, 0;
	mulMatrixLoop1:
		mov counterJ, 0;
		mulMatrixLoop2:
			mov sumIr, 0;
			mov counterK, 0;
			mulMatrixLoop3:
				mov	eax, 0;
				; m1[1][1]*m2[1][1] + m1[1][2]*m2[2][1].... 
				; wtemp = m1[1*lines1+1]* m1[2*lines2+1] + m1[1*lines1+2]*m2[2*lines2+1]......
				; wtemp - is sumator
				; eax =  counterI*lines1+counterJ ; || bl=counterI ; eax = bl * lines1; bl = bl+counterJ
				mov 	al, counterI;
				MUL		columns1;
				add 	al, counterK;
				MUL		temp
				; mov 	index, al
				mov		ax, matr1[eax]
				outint ax;
				mov		wtemp, ax ; matr1[index]
				
				; wtemp = m1[ebx]
				; eax =  counterJ*lines2+counterI ; || eax=counterJ ; eax = eax * lines2
				; dx = wtemp
				; dx + m2[eax]
				mov 	al, counterK;
				MUL		columns2;
				add 	al, counterJ;
				MUL		temp
				mov 	ax, matr2[eax]
				outstr '*';
				outint 	ax;
				MUL		wtemp;
				outstr '=';
				outint 	ax;
				outstrln ;
				ADD 	sumIr, ax;
				
				
				inc counterK
				mov bl, counterK;
				cmp bl, columns1
				JL	mulMatrixLoop3;
				;-------------------------------------------
			outstrln
			mov		eax, 0;
			mov 	al, counterI;
			MUL		columns2;
			add 	al, counterJ;
			MUL		temp
			mov		dx, sumIr;
			mov 	matr3[eax], dx;
			
			
			inc counterJ
			mov bl, counterJ;
			cmp bl, columns2 ; j < columns2
			JL	mulMatrixLoop2;
		
		inc counterI
		mov bl, counterI;
		cmp bl, lines1
		JL	mulMatrixLoop1;
		jmp printThreMatrix


	
	


printOverMax1:
	outstrln		'���-�� ��������� ������'
	jmp			outOneMatrix;


printOverMax2:
	outstrln		'���-�� ��������� ������'
	jmp			outTwoMatrix;
	

printBig:
	outstr		'��� ������'
	jmp		exete			;
printLitle:
	outstr		'��� ������'
	jmp		exete			;
exete:
	exit
	end Start
		


COMMENT @



	mov 		elements1,al		; ���������� ���������� ��������� ������ �������
	
	
	outstrln '������� ��������������� �������� ������ �������'
	mov bl,elements1; ���������� � ������ bl ���������� ��������� ������ �������
	mov eax,0; ���������� � ������ esi ����� �������� ������ �������
		CIKL1:
		inint matr1[eax]; ���������� ������� � ������
		INC eax; �������� ����� ��� ������ ���������� �������� �������
		DEC bl; ��������� ������� ���������� ��������� ������ �������
		CMP bl,0; ���������, �� ����� �� ��� �������� ������ �������
		JG CIKL1; ���� ����� �� ��� �������� ������ �������, �� ��������� ����
	
	outstrln '������ �������'; ����� ������ �������
	mov eax,0; �������� ��������
	mov edx,0; �������� ��������
	mov ecx,0; �������� ��������
	mov cl,columns1; ���������� � ������� ecx ���������� ��������� �������
	sub edx,ecx; ��������� �� ������ ������ ������ ������� (��������� ������ ������ �� ���������� ��������� � ������ * ��� ���������)
	L2:
	mov ebx,-1; ��������� �� ����� ������� �������
	add edx,ecx; ��������� �� ��������� ������ ������ ������� (����������� ������ ������ �� ���������� ��������� � ������ * ��� ���������)
	L1:
	inc ebx; ��������� �� ��������� ������� � ������ �������
	outint matr1[ebx+edx],8; ������� ������� �������
	mov al,bl; ���������� � ������� al ����� ������� (bl)
	inc al;����������� ��� ��� ���������
	cmp al, columns1; ���������, �� ����� �� �� ����� ������
		JL L1; ���� �� ����� �� ����� ������, �� ���������� �������� ��������
	newline
	mov eax,edx; ���������� � ������� eax ������ ������ (edx)
	DIV cl; ����� ������ ������ �� ���������� ���������, ��� ��������� ������ ������
	inc al;����������� ��� ��� ���������
	cmp al, lines1; ���������, �� ����� �� �� ��������� ������ � �������
		JL L2; ���� �� ����� �� ��������� ������ � �������, �� ���������� �������� ��������
	
	outstrln '������� ���������� ����� ������ �������'
	inint lines2; ���� ���������� ����� ������ �������
	outstrln '������� ���������� �������� ������ �������'
	inint columns2; ���� ���������� �������� ������ �������
	mov al,lines2
	MUL columns2; �������� ������ �� ������� � �������� ���������� ��������� ������ �������
	mov elements2,al; ���������� ���������� ��������� ������ �������
	outstr '���������� ��������� ������ �������: '
	outwordln elements2; ������� ���������� ��������� ������ �������
	
	outstrln '������� ��������������� �������� ������ �������'
	mov bl,elements2; ���������� � ������ bl ���������� ��������� ������ �������
	mov eax,0; ���������� � ������ esi ����� �������� ������ �������
		CIKL2:
		inint matr2[eax]; ���������� ������� � ������
		INC eax; �������� ����� ��� ������ ���������� �������� �������
		DEC bl; ��������� ������� ���������� ��������� ������ �������
		CMP bl,0; ���������, �� ����� �� ��� �������� ������ �������
		JG CIKL2; ���� ����� �� ��� �������� ������ �������, �� ��������� ����
	
	outstrln '������ �������'; ����� ������ �������
	mov eax,0; �������� ��������
	mov edx,0; �������� ��������
	mov ecx,0; �������� ��������
	mov cl,columns2; ���������� � ������� ecx ���������� ��������� �������
	sub edx,ecx; ��������� �� ������ ������ ������ ������� (��������� ������ ������ �� ���������� ��������� � ������ * ��� ���������)
	L4:
	mov ebx,-1; ��������� �� ����� ������� �������
	add edx,ecx; ��������� �� ��������� ������ ������ ������� (����������� ������ ������ �� ���������� ��������� � ������ * ��� ���������)
	L3:
	inc ebx; ��������� �� ��������� ������� � ������ �������
	outint matr2[ebx+edx],8; ������� ������� �������
	mov al,bl; ���������� � ������� al ����� ������� (bl)
	inc al;����������� ��� ��� ���������
	cmp al, columns2; ���������, �� ����� �� �� ����� ������
		JL L3; ���� �� ����� �� ����� ������, �� ���������� �������� ��������
	newline
	mov eax,edx; ���������� � ������� eax ������ ������ (edx)
	DIV cl; ����� ������ ������ �� ���������� ���������, ��� ��������� ������ ������
	inc al;����������� ��� ��� ���������
	cmp al, lines2; ���������, �� ����� �� �� ��������� ������ � �������
		JL L4; ���� �� ����� �� ��������� ������ � �������, �� ���������� �������� ��������
;____________________________________________________________________________________	

ACTCHOISE:
	outstrln '�������� ����������� ��������, ������� ����� ��������:'
	outstrln '1) �������� ������'
	outstrln '2) ��������� ������'
	outstrln '3) ��������� ������. ����� �������� ������ ������� �� ������'
	outstrln '4) ��������� ������� �� �����. ����� �������� ������ ������� �� �����'
	outstrln '5) �����'
	inint act; ���������� ��������
	cmp act,1; ���� ������� ��������
		je ADDITION; ��������� � ��������
	cmp act,2; ���� ������� ���������
		je SUBTRACTION; ��������� � ���������
	cmp act,3; ���� ������� ������������
		je MULTIPLICATION; ��������� � ������������
	cmp act,4; ���� ������� ��������� �� �����
		je NUMMULTIPLICATION; ��������� � ��������� �� �����
	cmp act,5; ���� ������ �����
		je FINISH; ��������� � ������
	outstrln '�������� �����'; ���� ������� �� ����� �� 1 �� 5 �� ������� ������ � �������� � ������
	jmp ACTCHOISE
	
ADDITION:
	newline
	outstrln '1) �������� ������'
	mov eax,0; �������� ��������
	mov edx,0; �������� ��������
	mov ecx,0; �������� ��������
	mov cl,columns1; �.�. ������� ����������� ������� ���������� � ������� ecx ���������� ��������� �������
	sub edx,ecx; ��������� �� ������ ������ ������ ������� (��������� ������ ������ �� ���������� ��������� � ������ * ��� ���������)
	L6:
	mov ebx,-1; ��������� �� ����� ������� �������
	add edx,ecx; ��������� �� ��������� ������ ������ ������� (����������� ������ ������ �� ���������� ��������� � ������ * ��� ���������)
	L5:
	inc ebx; ��������� �� ��������� ������� � ������ �������
	mov al,matr1[ebx+edx]; ���������� � ������� al ������� ������ ������� ��� ��������
	add al,matr2[ebx+edx]; ���������� �������� ������ � ������ �������
	outint al,8; ������� ������� �������
	mov eax,ebx; ���������� � ������� eax ����� ������� (ebx)
	inc al;����������� ��� ��� ���������
	cmp al, columns2; ���������, �� ����� �� �� ����� ������
		JL L5; ���� �� ����� �� ����� ������, �� ���������� �������� ��������
	newline
	mov eax,edx; ���������� � ������� eax ������ ������ (edx)
	DIV cl; ����� ������ ������ �� ���������� ���������, ��� ��������� ������ ������
	inc al;����������� ��� ��� ���������
	cmp al, lines2; ���������, �� ����� �� �� ��������� ������ � �������
		JL L6; ���� �� ����� �� ��������� ������ � �������, �� ���������� �������� ��������
	jmp ACTCHOISE

SUBTRACTION:
	newline
	outstrln '2) ��������� ������'
	outstrln '������� 1 ����� ������� ������ ������� �� ������'
	outstrln '������� 2 ����� ������� ������ ������� �� ������'
	inint si; �������� ����� ������� �� ����� ����� ��������
	mov eax,0; �������� ��������
	mov edx,0; �������� ��������
	mov ecx,0; �������� ��������
	mov cl,columns1; �.�. ������� ����������� ������� ���������� � ������� ecx ���������� ��������� �������
	sub edx,ecx; ��������� �� ������ ������ ������ ������� (��������� ������ ������ �� ���������� ��������� � ������ * ��� ���������)
	L8:
	mov ebx,-1; ��������� �� ����� ������� �������
	add edx,ecx; ��������� �� ��������� ������ ������ ������� (����������� ������ ������ �� ���������� ��������� � ������ * ��� ���������)
	L7:
	inc ebx; ��������� �� ��������� ������� � ������ �������
	cmp si,1; ������� ����� ������� �� ����� ����� ��������
		je M1SUBM2
	jmp M2SUBM1
M1SUBM2:
	mov al,matr1[ebx+edx]; ���������� � ������� al ������� ������ ������� ��� ���������
	sub al,matr2[ebx+edx]; �������� �������� ������ �� ������ �������
	outint al,8; ������� ������� �������
	jmp CIKL3
M2SUBM1:
	mov al,matr2[ebx+edx]; ���������� � ������� al ������� ������ ������� ��� ���������
	sub al,matr1[ebx+edx]; �������� �������� ������ �� ������ �������
	outint al,8; ������� ������� �������
	jmp CIKL3
CIKL3:
	mov eax,ebx; ���������� � ������� eax ����� ������� (ebx)
	inc al;����������� ��� ��� ���������
	cmp al, columns2; ���������, �� ����� �� �� ����� ������
		JL L7; ���� �� ����� �� ����� ������, �� ���������� �������� ��������
	newline
	mov eax,edx; ���������� � ������� eax ������ ������ (edx)
	DIV cl; ����� ������ ������ �� ���������� ���������, ��� ��������� ������ ������
	inc al;����������� ��� ��� ���������
	cmp al, lines2; ���������, �� ����� �� �� ��������� ������ � �������
		JL L8; ���� �� ����� �� ��������� ������ � �������, �� ���������� �������� ��������
	jmp ACTCHOISE
	
MULTIPLICATION:
	newline
	outstrln '3) ��������� ������'
	outstrln '����� �������� ������ ������� �� ������'

; lines1 columns2
	
	mov edi,0
	mov eax,0; �������� ��������
	mov edx,0; �������� ��������
	mov ecx,0; �������� ��������
	mov cl,columns1; ���������� � ������� ecx ���������� ��������� �������
	sub edx,ecx; ��������� �� ������ ������ ������ ������� (��������� ������ ������ �� ���������� ��������� � ������ * ��� ���������)
	L12:
	mov ebx,-1; ��������� �� ����� ������� �������
	add edx,ecx; ��������� �� ��������� ������ ������ ������� (����������� ������ ������ �� ���������� ��������� � ������ * ��� ���������)
	L11:
	inc ebx; ��������� �� ��������� ������� � ������ �������
	mov num1,matr1[ebx+edx]; ���������� � num1 ������� �� ������ ������� ��� ���������
	
	mov eax,0
	mov eax,ebx
	dec eax
	mul columns2; �������� � ax ������ ������ �������� 2 �������
	mov esi,edx; �������� � esi ������ ������� ������ �������
	mov num2,matr2[eax,esi]; ���������� � num2 ������� �� ������ ������� ��� ���������
	mov al,num1
	mul num2; �������� num1*num2
	add num3,ax; ���������� ������������� ��������
	
	mov al,bl; ���������� � ������� al ����� ������� (bl)
	inc al;����������� ��� ��� ���������
	cmp al, columns1; ���������, �� ����� �� �� ����� ������
		JL L11; ���� �� ����� �� ����� ������, �� ���������� �������� ��������
	outint num3,8; ������� ������
	mov num3,0
	cmp edi,
	mov eax,edx; ���������� � ������� eax ������ ������ (edx)
	DIV cl; ����� ������ ������ �� ���������� ���������, ��� ��������� ������ ������
	inc al;����������� ��� ��� ���������
	cmp al, lines2; ���������, �� ����� �� �� ��������� ������ � �������
		JL L12; ���� �� ����� �� ��������� ������ � �������, �� ���������� �������� ��������
	

	jmp ACTCHOISE

NUMMULTIPLICATION:
	newline
	outstrln '4) ��������� ������� �� �����'
	outstrln '����� �������� ������ ������� �� �����'
	outstrln '������� ����� �� 1 �� 100, �� ������� ����� �������� �������'
	inint num; ������ �����, �� ������� ����� �������� �������
	mov eax,0; �������� ��������
	mov edx,0; �������� ��������
	mov ecx,0; �������� ��������
	mov cl,columns1; ���������� � ������� ecx ���������� �������� �������
	sub edx,ecx; ��������� �� ������ ������ ������ ������� (��������� ������ ������ �� ���������� ��������� � ������ * ��� ���������)
	L10:
	mov ebx,-1; ��������� �� ����� ������� �������
	add edx,ecx; ��������� �� ��������� ������ ������ ������� (����������� ������ ������ �� ���������� ��������� � ������ * ��� ���������)
	L9:
	inc ebx; ��������� �� ��������� ������� � ������ �������
	mov al,matr1[ebx+edx]; ���������� � ������� al ������� �� ������� ��� ���������
	cmp al,0; ��������� �� ������������� �� �����
		jg POSITIV; ���� ������������� �� ������� �� ����� POSITIV
	neg al; ���� �������������, ����� ������ ��� �������������
	mul num; �������� ������� ������� �� �����
	neg ax; ������ ����� �������������
	outint ax,8; ������� ������� �������
	jmp NEGATIVE
POSITIV:
	mul num; �������� ������� ������� �� �����
	outint ax,8; ������� ������� �������
NEGATIVE:
	mov al,bl; ���������� � ������� al ����� ������� (bl)
	inc al;����������� ��� ��� ���������
	cmp al, columns1; ���������, �� ����� �� �� ����� ������
		JL L9; ���� �� ����� �� ����� ������, �� ���������� �������� ��������
	newline
	mov eax,edx; ���������� � ������� eax ������ ������ (edx)
	DIV cl; ����� ������ ������ �� ���������� ���������, ��� ��������� ������ ������
	inc al;����������� ��� ��� ���������
	cmp al, lines1; ���������, �� ����� �� �� ��������� ������ � �������
		JL L10; ���� �� ����� �� ��������� ������ � �������, �� ���������� �������� ��������
	jmp ACTCHOISE
	
	���� ���� ������, �������� ������, ��������� ������, ��������� ������, �������� ������� �� �����
	����� � �������� ���������� ��������, ������������ ����� ��������� �������: 25
	��� ����� � �������� ��������: 1 ���� db -128 +127
	������������� ������������ ��������� � ����� ������ ��� ������������ ������: 99*99*25 = +-245025
	
	____________________________________________________________________________________
	
	��������� ������
	____________________________________________________________________________________
	
@

	