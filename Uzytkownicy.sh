#!/bin/bash

echo"poodaj ile kont zamierzasz zalozyc"
read n

for ((i = 0; i<n; i++));
do
	echo "podaj nazwe konta"
	read user
	if [ -z `cut -d: -f1 /etc/passwd | grep $user` ];
	then {
		echo "Tworze uzytkownika"
	useradd -m -g student $user
	arr_user=($[arr_user[@]} $user)
	}
	else
		echo "error juz istnieje"
	fi
done

echo -e "3\n"
echo -e "wyswietlam prawa dostepu dla uzytkownikow"
for i in ${arr_user[*]}
do
	ls -ld $i
done

echo -e "4\n"
echo -e "Tworze katalogi dla kazdego uzytkownika"
for i in ${arr_user[*]}
do
	mkdir $i/Pulpit
	mkdir $i/Pulput/katalog1
	touch $i/Pulpit/katalog1/plik1
done

echo -e "5\n"
echo -e "Wyswietlam zawartosc katalogu home"
tree

echo -e "6\n"
echo "Zmieniam wlascicielow zasobow"
for i in ${arr_user[*]}
do
	chown -R $i:student $i
done

echo -e "7\n"
echo -e "wyswietlam prawa do katalgow dla uzykownikow"
for i in ${arr_user[*]}
do
	ls -ld $i
done

echo -e "8\n"
echo -e "Zmeiniam prawa dostepu"
for i in ${arr_user[*]}
do
	chmod 467 $i/Pulpit
	chmod 746 $i/Pulpit/katalog1
	chmod 444 $i/Pulpit/katalog1/plik1
done

echo -e "9\n"
echo -e "pokazuje odzielnie wszystkie prawa dostepu"

for i in ${arr_user[*]}
do
	ls -ld $i/Pulpit
	ls -ld $i/Pulpit/katalog1
	ls -l $i/Pulpit/katalog1/plik1
done

echo -e "10\n"
echo -e "zmieniam wlasciela na konto i grupe root"
for i in ${arr_user[*]}
do
	chown -R $i:root $i
done

echo -e "11\n"
echo -e "wsywietlam prawa dla kazdego"
for i in ${arr_user[*]}
do
	ls -ld $i/Pulpit
	ls -ld $i/Pulpit/katalog1
	ls -l $i/Pulpit/katalog1/plik1
done

echo -e "12\n"
echo -e "towrze tar dla kazdego"
for i in ${arr_user[*]}
do
	mkdir archiwum_$i
	tar -cf archiwum_$i/archiwum.tar $i
done

echo -e "13\n"
echo -e "rozpakwouje tary do backup"
mkdir backup
for i in ${arr_user[*]}
do
	tar -xf archiwum_$i/archiwum.tar -C backup
done

echo -e "14\n"
echo -e "usuwam wszystkich uzytkownikow"
for i in ${arr_user[*]}
do
	userdel -r $i
	rm -r archiwum_$1
done
rm -r backup

echo -e "15\n"
echo -e "wyswietlam prawa dostepu do home"
ls -l
