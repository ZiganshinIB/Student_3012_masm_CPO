include console.inc

COMMENT @

	Ввод двух матриц, сложение матриц, вычитание матриц, умножение матриц, умножеие матрицы на число
	Числа в матрицах двузначные знаковые, максимальное число элементов матрицы: 25
	Тип ячеек в вводимых матрицах: 1 байт db -128 +127
	Следовательно максимальный результат в одной ячейке при перемножении матриц: 99*99*25 = +-245025
	
	____________________________________________________________________________________
	
	умножение матриц
	____________________________________________________________________________________
	
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
	mov eax, 0 ; Обнулим
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
	outstrln		'Кол-во элиментов больше'
	jmp			outOneMatrix;


printOverMax2:
	outstrln		'Кол-во элиментов больше'
	jmp			outTwoMatrix;
	

printBig:
	outstr		'Это больше'
	jmp		exete			;
printLitle:
	outstr		'Это больше'
	jmp		exete			;
exete:
	exit
	end Start
		


COMMENT @



	mov 		elements1,al		; Записываем количество элементов ПЕРВОЙ матрицы
	
	
	outstrln 'Введите последовательно элементы ПЕРВОЙ матрицы'
	mov bl,elements1; Записываем в региср bl количество элементов ПЕРВОЙ матрицы
	mov eax,0; Записываем в региср esi номер элемента ПЕРВОЙ матрицы
		CIKL1:
		inint matr1[eax]; Записываем элемент в массив
		INC eax; Сдвигаем адрес для записи следующего элемента массива
		DEC bl; Уменьшаем счетчик количества элементов ПЕРВОЙ матрицы
		CMP bl,0; Проверяем, не ввели ли все элементы ПЕРВОЙ матрицы
		JG CIKL1; Если ввели не все элементы ПЕРВОЙ матрицы, то повторяем цикл
	
	outstrln 'ПЕРВАЯ матрица'; Вывод ПЕРВОЙ матрицы
	mov eax,0; обнуляем счетчики
	mov edx,0; обнуляем счетчики
	mov ecx,0; обнуляем счетчики
	mov cl,columns1; Записываем в регистр ecx количество столбццов матрицы
	sub edx,ecx; Указываем на индекс первой строки матрицы (уменьшаем индекс строки на количесвто элементов в строке * тип элементов)
	L2:
	mov ebx,-1; Указываем на певый столбец матрицы
	add edx,ecx; Переходим на следующий индекс строки матрицы (увеличиваем индекс строки на количесвто элементов в строке * тип элементов)
	L1:
	inc ebx; Переходим на следующий столбец в строке матрицы
	outint matr1[ebx+edx],8; Выводим элемент матрицы
	mov al,bl; Записываем в регистр al номер столбца (bl)
	inc al;Увеличиваем его для сравнения
	cmp al, columns1; Проверяем, не дошли ли до конца строки
		JL L1; Если не дошли до конца строки, то продолжаем выводить элементы
	newline
	mov eax,edx; Записываем в регистр eax индекс строки (edx)
	DIV cl; Делим индекс строки на количество элементов, для получения номера строки
	inc al;Увеличиваем его для сравнения
	cmp al, lines1; Проверяем, не дошли ли до последней строки в матрице
		JL L2; Если не дошли до последней строки в матрице, то продолжаем выводить элементы
	
	outstrln 'Введите количество строк ВТОРОЙ матрицы'
	inint lines2; Ввод количества строк ВТОРОЙ матрицы
	outstrln 'Введите количество столбцов ВТОРОЙ матрицы'
	inint columns2; Ввод количества столбцов ВТОРОЙ матрицы
	mov al,lines2
	MUL columns2; Умножаем строки на столбцы и получаем количество элементов ВТОРОЙ матрицы
	mov elements2,al; Записываем количество элементов ВТОРОЙ матрицы
	outstr 'Количество элементов ВТОРОЙ матрицы: '
	outwordln elements2; Выводим количество элементов ВТОРОЙ матрицы
	
	outstrln 'Введите последовательно элементы ВТОРОЙ матрицы'
	mov bl,elements2; Записываем в региср bl количество элементов ВТОРОЙ матрицы
	mov eax,0; Записываем в региср esi номер элемента ВТОРОЙ матрицы
		CIKL2:
		inint matr2[eax]; Записываем элемент в массив
		INC eax; Сдвигаем адрес для записи следующего элемента массива
		DEC bl; Уменьшаем счетчик количества элементов ВТОРОЙ матрицы
		CMP bl,0; Проверяем, не ввели ли все элементы ВТОРОЙ матрицы
		JG CIKL2; Если ввели не все элементы ВТОРОЙ матрицы, то повторяем цикл
	
	outstrln 'ВТОРАЯ матрица'; Вывод ВТОРОЙ матрицы
	mov eax,0; обнуляем счетчики
	mov edx,0; обнуляем счетчики
	mov ecx,0; обнуляем счетчики
	mov cl,columns2; Записываем в регистр ecx количество столбццов матрицы
	sub edx,ecx; Указываем на индекс первой строки матрицы (уменьшаем индекс строки на количесвто элементов в строке * тип элементов)
	L4:
	mov ebx,-1; Указываем на певый столбец матрицы
	add edx,ecx; Переходим на следующий индекс строки матрицы (увеличиваем индекс строки на количесвто элементов в строке * тип элементов)
	L3:
	inc ebx; Переходим на следующий столбец в строке матрицы
	outint matr2[ebx+edx],8; Выводим элемент матрицы
	mov al,bl; Записываем в регистр al номер столбца (bl)
	inc al;Увеличиваем его для сравнения
	cmp al, columns2; Проверяем, не дошли ли до конца строки
		JL L3; Если не дошли до конца строки, то продолжаем выводить элементы
	newline
	mov eax,edx; Записываем в регистр eax индекс строки (edx)
	DIV cl; Делим индекс строки на количество элементов, для получения номера строки
	inc al;Увеличиваем его для сравнения
	cmp al, lines2; Проверяем, не дошли ли до последней строки в матрице
		JL L4; Если не дошли до последней строки в матрице, то продолжаем выводить элементы
;____________________________________________________________________________________	

ACTCHOISE:
	outstrln 'Выберите необходимое действие, введите номер варианта:'
	outstrln '1) Сложение матриц'
	outstrln '2) Вычитание матриц'
	outstrln '3) Умножение матриц. Будет умножена ПЕРВАЯ матрица на ВТОРУЮ'
	outstrln '4) Умножение матрицы на число. Будет умножена ПЕРВАЯ матрица на число'
	outstrln '5) Выход'
	inint act; Выбирается действие
	cmp act,1; Если выбрано сложение
		je ADDITION; Переходим к сложению
	cmp act,2; Если выбрано вычитание
		je SUBTRACTION; Переходим к вычитанию
	cmp act,3; Если выбрано перемножение
		je MULTIPLICATION; Переходим к перемножению
	cmp act,4; Если выбрано умножение на число
		je NUMMULTIPLICATION; Переходим к умножение на число
	cmp act,5; Если выбран выход
		je FINISH; Переходим к выходу
	outstrln 'Неверный выбор'; Если введено не число от 1 до 5 то выводим ошибку и начинаем с начала
	jmp ACTCHOISE
	
ADDITION:
	newline
	outstrln '1) Сложение матриц'
	mov eax,0; обнуляем счетчики
	mov edx,0; обнуляем счетчики
	mov ecx,0; обнуляем счетчики
	mov cl,columns1; Т.к. матрицы одинакового размера записываем в регистр ecx количество столбццов матрицы
	sub edx,ecx; Указываем на индекс первой строки матрицы (уменьшаем индекс строки на количесвто элементов в строке * тип элементов)
	L6:
	mov ebx,-1; Указываем на певый столбец матрицы
	add edx,ecx; Переходим на следующий индекс строки матрицы (увеличиваем индекс строки на количесвто элементов в строке * тип элементов)
	L5:
	inc ebx; Переходим на следующий столбец в строке матрицы
	mov al,matr1[ebx+edx]; Записываем в регистр al элемент первой матрицы для сложения
	add al,matr2[ebx+edx]; Складываем элементы первой и второй матрицы
	outint al,8; Выводим элемент матрицы
	mov eax,ebx; Записываем в регистр eax номер столбца (ebx)
	inc al;Увеличиваем его для сравнения
	cmp al, columns2; Проверяем, не дошли ли до конца строки
		JL L5; Если не дошли до конца строки, то продолжаем выводить элементы
	newline
	mov eax,edx; Записываем в регистр eax индекс строки (edx)
	DIV cl; Делим индекс строки на количество элементов, для получения номера строки
	inc al;Увеличиваем его для сравнения
	cmp al, lines2; Проверяем, не дошли ли до последней строки в матрице
		JL L6; Если не дошли до последней строки в матрице, то продолжаем выводить элементы
	jmp ACTCHOISE

SUBTRACTION:
	newline
	outstrln '2) Вычитание матриц'
	outstrln 'Введите 1 чтобы вычесть ВТОРУЮ матрицу из ПЕРВОЙ'
	outstrln 'Введите 2 чтобы вычесть ПЕРВУЮ матрицу из ВТОРОЙ'
	inint si; Выбираем какую матрицу из какой будем вычитать
	mov eax,0; обнуляем счетчики
	mov edx,0; обнуляем счетчики
	mov ecx,0; обнуляем счетчики
	mov cl,columns1; Т.к. матрицы одинакового размера записываем в регистр ecx количество столбццов матрицы
	sub edx,ecx; Указываем на индекс первой строки матрицы (уменьшаем индекс строки на количесвто элементов в строке * тип элементов)
	L8:
	mov ebx,-1; Указываем на певый столбец матрицы
	add edx,ecx; Переходим на следующий индекс строки матрицы (увеличиваем индекс строки на количесвто элементов в строке * тип элементов)
	L7:
	inc ebx; Переходим на следующий столбец в строке матрицы
	cmp si,1; Смотрим какую матрицу из какой будем вычитать
		je M1SUBM2
	jmp M2SUBM1
M1SUBM2:
	mov al,matr1[ebx+edx]; Записываем в регистр al элемент первой матрицы для вычитания
	sub al,matr2[ebx+edx]; Вычитаем элементы второй из первой матрицы
	outint al,8; Выводим элемент матрицы
	jmp CIKL3
M2SUBM1:
	mov al,matr2[ebx+edx]; Записываем в регистр al элемент второй матрицы для вычитания
	sub al,matr1[ebx+edx]; Вычитаем элементы первой из второй матрицы
	outint al,8; Выводим элемент матрицы
	jmp CIKL3
CIKL3:
	mov eax,ebx; Записываем в регистр eax номер столбца (ebx)
	inc al;Увеличиваем его для сравнения
	cmp al, columns2; Проверяем, не дошли ли до конца строки
		JL L7; Если не дошли до конца строки, то продолжаем выводить элементы
	newline
	mov eax,edx; Записываем в регистр eax индекс строки (edx)
	DIV cl; Делим индекс строки на количество элементов, для получения номера строки
	inc al;Увеличиваем его для сравнения
	cmp al, lines2; Проверяем, не дошли ли до последней строки в матрице
		JL L8; Если не дошли до последней строки в матрице, то продолжаем выводить элементы
	jmp ACTCHOISE
	
MULTIPLICATION:
	newline
	outstrln '3) Умножение матриц'
	outstrln 'Будет умножена ПЕРВАЯ матрица на ВТОРУЮ'

; lines1 columns2
	
	mov edi,0
	mov eax,0; обнуляем счетчики
	mov edx,0; обнуляем счетчики
	mov ecx,0; обнуляем счетчики
	mov cl,columns1; Записываем в регистр ecx количество столбццов матрицы
	sub edx,ecx; Указываем на индекс первой строки матрицы (уменьшаем индекс строки на количесвто элементов в строке * тип элементов)
	L12:
	mov ebx,-1; Указываем на певый столбец матрицы
	add edx,ecx; Переходим на следующий индекс строки матрицы (увеличиваем индекс строки на количесвто элементов в строке * тип элементов)
	L11:
	inc ebx; Переходим на следующий столбец в строке матрицы
	mov num1,matr1[ebx+edx]; Записываем в num1 элемент из ПЕРВОЙ матрицы для умножения
	
	mov eax,0
	mov eax,ebx
	dec eax
	mul columns2; записали в ax индекс строки элемента 2 матрицы
	mov esi,edx; Записали в esi индекс столбца ВТОРОЙ матрицы
	mov num2,matr2[eax,esi]; Записываем в num2 элемент из ВТОРОЙ матрицы для умножения
	mov al,num1
	mul num2; умножаем num1*num2
	add num3,ax; складываем перемноженные значения
	
	mov al,bl; Записываем в регистр al номер столбца (bl)
	inc al;Увеличиваем его для сравнения
	cmp al, columns1; Проверяем, не дошли ли до конца строки
		JL L11; Если не дошли до конца строки, то продолжаем выводить элементы
	outint num3,8; выводим символ
	mov num3,0
	cmp edi,
	mov eax,edx; Записываем в регистр eax индекс строки (edx)
	DIV cl; Делим индекс строки на количество элементов, для получения номера строки
	inc al;Увеличиваем его для сравнения
	cmp al, lines2; Проверяем, не дошли ли до последней строки в матрице
		JL L12; Если не дошли до последней строки в матрице, то продолжаем выводить элементы
	

	jmp ACTCHOISE

NUMMULTIPLICATION:
	newline
	outstrln '4) Умножение матрицы на число'
	outstrln 'Будет умножена ПЕРВАЯ матрица на число'
	outstrln 'Введите число от 1 до 100, на которое будет умножена матрица'
	inint num; Вводим число, на которое будем умножать матрицу
	mov eax,0; обнуляем счетчики
	mov edx,0; обнуляем счетчики
	mov ecx,0; обнуляем счетчики
	mov cl,columns1; Записываем в регистр ecx количество столбцов матрицы
	sub edx,ecx; Указываем на индекс первой строки матрицы (уменьшаем индекс строки на количесвто элементов в строке * тип элементов)
	L10:
	mov ebx,-1; Указываем на певый столбец матрицы
	add edx,ecx; Переходим на следующий индекс строки матрицы (увеличиваем индекс строки на количесвто элементов в строке * тип элементов)
	L9:
	inc ebx; Переходим на следующий столбец в строке матрицы
	mov al,matr1[ebx+edx]; Записываем в регистр al элемент из матрицы для умножения
	cmp al,0; Проверяем не отрицательное ли число
		jg POSITIV; Если положительное то прыгаем на метку POSITIV
	neg al; Если отрицательное, тогда делаем его положительным
	mul num; Умножаем элемент матрицы на число
	neg ax; Делаем число отрицательным
	outint ax,8; Выводим элемент матрицы
	jmp NEGATIVE
POSITIV:
	mul num; Умножаем элемент матрицы на число
	outint ax,8; Выводим элемент матрицы
NEGATIVE:
	mov al,bl; Записываем в регистр al номер столбца (bl)
	inc al;Увеличиваем его для сравнения
	cmp al, columns1; Проверяем, не дошли ли до конца строки
		JL L9; Если не дошли до конца строки, то продолжаем выводить элементы
	newline
	mov eax,edx; Записываем в регистр eax индекс строки (edx)
	DIV cl; Делим индекс строки на количество элементов, для получения номера строки
	inc al;Увеличиваем его для сравнения
	cmp al, lines1; Проверяем, не дошли ли до последней строки в матрице
		JL L10; Если не дошли до последней строки в матрице, то продолжаем выводить элементы
	jmp ACTCHOISE
	
	Ввод двух матриц, сложение матриц, вычитание матриц, умножение матриц, умножеие матрицы на число
	Числа в матрицах двузначные знаковые, максимальное число элементов матрицы: 25
	Тип ячеек в вводимых матрицах: 1 байт db -128 +127
	Следовательно максимальный результат в одной ячейке при перемножении матриц: 99*99*25 = +-245025
	
	____________________________________________________________________________________
	
	умножение матриц
	____________________________________________________________________________________
	
@

	