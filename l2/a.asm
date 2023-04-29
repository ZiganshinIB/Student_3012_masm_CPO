include console.inc

COMMENT @

	сложение матриц
	отрцательное сложение матриц
	умножение матриц
	Матричное умножение матриц
	
@
.data
	maxMatrElement  db 25 
	
	matr1 		dw 25 dup (0)		; Резервируем память под ПЕРВУЮ матрицу 25 элементов
	lines1 		db 0			; Количество строк в ПЕРВОЙ матрице
	columns1 	db 0			; Количество столбцов в ПЕРВОЙ матрице
	elements1 	db 0			; Количество элементов в ПЕРВОЙ матрице
	matr2 		dw 25 	dup (0)		; Резервируем память под ВТОРУЮ матрицу 25 элементов
	lines2 		db 0			; Количество строк во ВТОРОЙ матрице
	columns2 	db 0			; Количество столбцов во ВТОРОЙ матрице
	elements2 	db 0			; Количество элементов во ВТОРОЙ матрице
	num 		db 0			; Число для умножения матрицы
	num1 		db 0			; Число для умножения из ПЕРВОЙ матрицы
	num2 		db 0			; Число для умножения из ВТОРОЙ матрицы
	num3 		dw 0			;
	act 		db 0			; Выбор действия над матрицами
	matr3 		dw 25 	dup (0)		; Резервируем память под ВТОРУЮ матрицу 25 элементов
	
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
	outstrln 'Числа в матрицах двузначные знаковые, максимальное число элементов матрицы: 25'
	outstrln 'Введите количество строк ПЕРВОЙ матрицы'
	inint 		lines1			
	outstrln 'Введите количество столбцов ПЕРВОЙ матрицы'
	inint 		columns1
		
	mov 		al,lines1		
	MUL 		columns1		; резултать умножения AL и columns1 = AX
	
	; Проверка больше или меньше значение если больше то повторяем
	cmp		ax, 25
	jg		printOverMax1;	
	;
	mov 		elements1, al		
	outstr 	       'Количество элементов ПЕРВОЙ матрицы: '
	outwordln 	elements1
	
	outstrln 'Введите последовательно элементы ПЕРВОЙ матрицы'
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
	outstrln 'Введите количество строк Второй матрицы'
	inint 		lines2			
	outstrln 'Введите количество столбцов Второй матрицы'
	inint 		columns2
		
	mov 		al,lines2		
	MUL 		columns2		; резултать умножения AL и columns1 = AX
	
	; Проверка больше или меньше значение если больше то повторяем
	cmp		ax, 25
	jg		printOverMax2;	
	;
	mov 		elements2, al		
	outstr 	       'Количество элементов Второй матрицы: '
	outwordln 	elements2
	
	outstrln 'Введите последовательно элементы Второй матрицы'
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
		CMP 		bl, elements2
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
	outstrln 'выберите пункты: '
	outstrln
	outstrln '1) Пересоздать массивы'
	outstrln '2) +'
	outstrln '3) -'
	outstrln '4) *'
	outstrln '5) х'
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
	; Сравниваем размерность матриц row == row and col == col
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
	mov eax, 0 ; Обнулим
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
	; Сравниваем размерность матриц row == row and col == col
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
	mov eax, 0 ; Обнулим
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
	; Сравниваем размерность матриц row == row and col == col
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
	
	mov counterI, 0;
	mov counterJ, 0;
	mov bl, elements1;
	mulElementsMatrixLoop:
		mov eax, 0 ; Обнулим
		;outstr	'Looper: '
		;outint  counterI
		;outstr	'Index: '
		;outint  counterJ
		;outstr	':: '
		mov 	al, counterJ; al is Index
		mov 	dx, matr1[eax]; 
		mov		wtemp, dx	  ; wtemp = matr1[index]		
		mov 	ax, matr2[eax] ; ax = matr2[index]
		;outint 	wtemp
		;outstr	'*'
		;outint	ax
		;outstr  '='
		IMUL		wtemp		;dx = ax *wtemp 
		;outintln	ax
		mov 	wtemp, ax;		
		mov		eax, 0
		mov		al, counterJ	; al is Index
		mov		dx,  wtemp
		mov 	matr3[eax], dx;	
		;outintln matr3[eax]
		ADD		counterJ,2		
		inc		counterI;
		cmp		counterI, bl
		JL		mulElementsMatrixLoop
		jmp 	printThreMatrix	
	jmp	printMenue

mulMatrix:
	; Сравниваем размерность матриц row == col and col == row
	mov 	eax, 0
	mov	al, columns1
	cmp	al, lines2
	JNE	printMenue
	; ------------------------------------------------------
	mov eax, 0 ; Обнулим
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
				MUL		wtemp;
				ADD 	sumIr, ax;
				
				
				inc counterK
				mov bl, counterK;
				cmp bl, columns1
				JL	mulMatrixLoop3;
				;-------------------------------------------
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
	outstrln		'Кол-во элиментов больше'
	jmp			outOneMatrix;


printOverMax2:
	outstrln		'Кол-во элиментов больше'
	jmp			outTwoMatrix;
	

printBig:
	outstr		'Это больше'
	jmp		exete			;

exete:
	exit
	end Start
		



	