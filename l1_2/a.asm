include console.inc
COMMENT *
	Laba 1 #2
*

.data
	a db 'a'


.code

Start:
	ClrScr									; ������ CMD
	ConsoleTitle 		"����� ������� � 2 ��������� ����"
	outstrln 		"������� ������"
	inchar 			a						; ��������� ������
	outstr			"� ASCI: "
	outintln		a
	mov 			cl,0						
begin:
	rol 			a,1						; ��� ������� ��������� �� 1 ��� �����
	jnc 			zero						; JNC ��������� ����� �� 0
	outchar 		"1"
	jmp cycle								; ������� �� ����� "cycle"
zero:
	
	outchar 		"0"						; ������� ������ "0"
	jmp 			cycle
cycle:	
	add 			cl,1						; ��������� ������� �� 1
	cmp 			cl,8						; ��������� �� �������� �� ������� �� 8
	jl 			begin						; ���� ������� �������� �� 0 ������� �� ����� "begin"
	newline
	exit
	end Start
