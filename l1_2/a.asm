include console.inc
COMMENT *
	Laba 1 #2
*

.data
	a db 'a'


.code

Start:
	ClrScr									; Чистка CMD
	ConsoleTitle 		"Вывод символа в 2 разрядном виде"
	outstrln 		"Введите символ"
	inchar 			a						; Считываем символ
	outstr			"В ASCI: "
	outintln		a
	mov 			cl,0						
begin:
	rol 			a,1						; Код символа свигается на 1 бит влево
	jnc 			zero						; JNC проверяет равен ли 0
	outchar 		"1"
	jmp cycle								; Прыгаем на метку "cycle"
zero:
	
	outchar 		"0"						; Выводим символ "0"
	jmp 			cycle
cycle:	
	add 			cl,1						; Уменьшаем счетчик на 1
	cmp 			cl,8						; Проверяем не досчитал ли счетчик до 8
	jl 			begin						; Если счетчик досчитал до 0 прыгаем на метку "begin"
	newline
	exit
	end Start
