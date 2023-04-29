include console.inc

COMMENT *

   Заготовка программы

*
.data

W1 dq "Тест"
W2 dw 5
W3 db 100
Q dq 01020304h

.code
Start:

   ConsoleTitle " Распределение памяти" ;название в комадной строке 
   outstrln	"Вывод переменной W1"
   lea 		eax, W1			; записать адресс
   outwordln 	eax 			;
   outwordln    W1 
   
   outstrln	"Вывод переменной W2"
   lea 		eax, W2			; записать адресс
   outwordln 	eax 			; 
   outwordln    W2

   outwordln 	W1+4			;
   outwordln 	W2-4  			; Обращаемся к соседней var
   
   outstrln	"Тип переменной W1"
   OutwordLn 	type 	W1		; получить тип переменной

   outstrln	"Тип переменной W2"
   OutwordLn 	type 	W2		; получить тип переменной

   outwordln byte ptr W2
   outwordln byte ptr W2+1
   exit

end Start