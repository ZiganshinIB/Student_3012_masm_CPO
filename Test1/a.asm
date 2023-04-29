include console.inc

COMMENT *

   Заготовка программы

*
.data


.code
Start:

   ConsoleTitle " Вывод чисел" ;название в комадной строке 
   outcharln 200 ; вывод 200 символа 
   outcharln 'И' ; вывод И
   outwordln 'И' ; вывод 200
   outintln 'И'  ; вывод 200
   exit

end Start