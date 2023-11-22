#!/bin/bash
#basit ama güçlü şifreleme yapma dikkat şifreyi unutursan açmayı unut
echo "1 seçenek metini şifreleme"
echo "2 seçenek metini çözme"
echo "3 seçenek metini bir dosya olarak şifreleme"
echo "4 seçenek bir dosya olarak çözme cıktı olarak"
echo "5 seçenek bir dosya olarak şifreleme"
echo "6 seçenek bir dosya olarak çözme"
echo "7 seçenek 5'lik numara üretir"
echo "8 seçenek Şifre oluşturucu Script"
echo "1 den 7 kadar bir rakam yazın başka bir şey degil man kafa"
read -p "Yapılacak işlemi secin: " var 
case $var in

1) read -p "şifrelencek karekterler: " girdi
read -s -p "şifre: " Ubuntu 
echo -n "$girdi" | openssl enc -aes-256-cbc -md sha512 -a -pbkdf2 -iter 100000 -salt -pass pass:$Ubuntu ;; 

2) read -p "çözülecek karekterler: " girdi
read -s -p "şifre: " Ubuntu 
echo "$girdi" | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -salt -pass pass:$Ubuntu ;; 

#bir girdiyi tex olacak şekilde şifreleme
3) read -p "Oluşturlacak dosya adı kısaca: " dosya
read -p "şifrelencek yazılar: " girdi
read -s -p "şifre: " Ubuntu 
echo $girdi | openssl enc -aes-256-cbc -md sha512 -a -pbkdf2 -iter 100000 -salt -pass pass:$Ubuntu > $dosya 
sha256sum $dosya >> kayıtlogu.tsp ;; 
#bir dosyayı çözme

4) echo "4 seçenek bir dosyayı cözer"

read -p "Çözülecek dosya adı: " dosya
read -s -p "şifre: " Ubuntu
#read var < <(dosya)
cat "$dosya" | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -salt -pass pass:$Ubuntu ;; 

#Dosya şifreleme yapma 
5) read -p "şifrelencek dosya adı: " dosya
read -p "Oluşturlacak dosya adı: " dosya2
read -s -p "şifre: " Ubuntu
today=$(date +%d-%m-%Y-%H-%M".enc")
openssl enc -aes-256-cbc -md sha512 -a -pbkdf2 -iter 100000 -salt -pass pass:$Ubuntu -in $dosya -out $dosya2.${today} 
sha256sum $dosya2.${today} >> kayıtlogu.tsp 
tar -cvzf $dosya2.${today}.tar.gz $dosya2.${today} 
rm $dosya2.${today};;

#Dosya şifreleme çözme
6) read -p "Çözülecek dosya adı: " dosya
read -p "Oluşturlacak dosya adı: " dosya2
read -s -p "şifre: " Ubuntu
openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -salt -pass pass:$Ubuntu -in $dosya -out $dosya2 ;;

7)  echo "7 seçenek 5'lik numara üretir"

#od -An -N2 -i /dev/random
#A-Za-z0-9 
cat /dev/urandom | tr -dc 0-9 | head -c 6 ; echo;;

8) echo "Şifre oluşturucu Script"
read -p "Şifre uzunluğunu girin: " PASS_LENGTH
for VAR in $(seq 1 3); #how many times password will generate, you can set range
do
    openssl rand -base64 48 | cut -c1-$PASS_LENGTH
    #-base64(Encode) 48 is length 
    #cut is for user input column -c1 is column1
done

;;

esac



