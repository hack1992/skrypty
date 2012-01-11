#!/bin/bash
powtorka="tak"
while [ "$powtorka" = "tak" ]
do
echo -n $powtorka

dialog  --title "Wybierz co chcesz
przekonwertowa." \
--backtitle "Jednostki" \
--radiolist \
"Zaznacz wpis:" 10 70 3 \
"1" "SPRAWDZIC DANE PRACOWNIKA" "on" \
"2" "WPROWADZIC NOWEGO PRACOWNIKA" "off" \
"3" "INFORMACJE O AKTUALNYM KONTRAKCIE" "off" \
2> /tmp/wynik.txt

wynik=(`cat /tmp/wynik.txt`)

if [ $wynik -eq 1 ]
then

dialog --title "SPRAWDZANIE DANYCH PRACOWNIKA" \
--inputbox "Podaj Imie i Nazwisko pracownika (np. PatrykBradtke)" 8 40 "" \
2> imie.txt

pracownik=(`cat imie.txt`)

        if [ -e dane$pracownik.txt ]
        then

        dialog --title "DANE $pracownik" \
        --backtitle "info" \
        --textbox "dane$pracownik.txt" 0 0

        else

         dialog --title "KOMUNIKAT" \
        --backtitle "info" \
        --msgbox "Pracownik $pracownik nie istnieje" 0 0

        fi

elif [ $wynik -eq 2 ]
then

dialog --title "WPROWADZANIE NOWEGO PRACOWNIKA" \
--inputbox "Podaj Imie i Nazwisko pracownika (np. PatrykBradtke)" 8 40 "" \
2> imie.txt

pracownik=(`cat imie.txt`)

dialog --title "WPROWADZANIE NOWEGO PRACOWNIKA" \
--inputbox "Podaj wiek pracownika" 8 40 "" \
2> wiek.txt

wiek=(`cat wiek.txt`)

dialog --title "WPROWADZANIE NOWEGO PRACOWNIKA" \
--inputbox "Podaj pesel pracownika" 8 40 "" \
2> pesel.txt

pesel=(`cat pesel.txt`)

dialog --title "WPROWADZANIE NOWEGO PRACOWNIKA" \
--inputbox "Podaj adres zamieszkania pracownika" 8 40 "" \
2> adres.txt

adres=(`cat adres.txt`)

dialog --title "WPROWADZANIE NOWEGO PRACOWNIKA" \
--inputbox "Podaj znajomosc jezykow obcych pracownika (np. angielski)" 8 40 "" \
2> jezyk.txt

jezyk=(`cat jezyk.txt`)

dialog --title "WPROWADZANIE NOWEGO PRACOWNIKA" \
--inputbox "Podaj zawod pracownika" 8 40 "" \
2> zawod.txt

zawod=(`cat zawod.txt`)

dialog --title "WPROWADZANIE NOWEGO PRACOWNIKA" \
--inputbox "Podaj wyksztalcenie pracownika" 8 40 "" \
2> wyksztalcenie.txt

wyksztalcenie=(`cat wyksztalcenie.txt`)

touch dane$pracownik.txt

echo "Imie i Nazwisko: $pracownik" > dane$pracownik.txt
echo "Wiek: $wiek" >> dane$pracownik.txt
echo "Pesel: $pesel" >> dane$pracownik.txt
echo "Adres zamieszkania: $adres" >> dane$pracownik.txt
echo "Znajomosc jezykow: $jezyk" >> dane$pracownik.txt
echo "Zawod: $zawod" >> dane$pracownik.txt
echo "Wyksztalcenie: $wyksztalcenie" >> dane$pracownik.txt

elif [ $wynik -eq 3 ]
then

dialog  --title "AKTUALNY KONTRAKT" \
--radiolist \
"Co chcesz zrobic?:" 20 70 5 \
"1" "WPROWADZIC DANE NA AKTUALNYM KONTRAKCIE" "on" \
"2" "SPRAWDZIC DANE NA AKTUALNYM KONTRAKCIE" "off" \
"3" "DODAC GODZINY" "off" \
"4" "SZCZEGOLOWY ROZPIS DNIA" "off" \
"5" "SPRAWDZIC AKTUALNA NALEZNOSC DO ZAPLATY" "off" \
2> /tmp/co.txt

co=(`cat /tmp/co.txt`)

        if [ $co -eq 1 ]
        then

        dialog --title "WPROWADZANIE DANYCH NA AKTUALNYM KONTRAKCIE" \
        --inputbox "Podaj Imie i Nazwisko (np. PatrykBradtke)" 8 40 "" \
        2> pracownik.txt

        pracownik=(`cat pracownik.txt`)

        dialog --title "WPROWADZANIE DANYCH NA AKTUALNYM KONTRAKCIE $pracownik" \
        --inputbox "Podaj termin trwania kontraktu (np. 22.08-23.09)" 0 0 "" \
        2> data.txt

        data=(`cat data.txt`)

        dialog --title "WPROWADZANIE DANYCH NA AKTUALNYM KONTRAKCIE $pracownik" \
        --inputbox "Podaj stawke" 0 0 "" \
        2> stawka.txt

        stawka=(`cat stawka.txt`)

        echo "Data trwania kontaktu: $data" > aktualny$pracownik.txt
        echo "Stawka: $stawka zl / godzine" >> aktualny$pracownik.txt

        elif [ $co -eq 2 ]
        then

        dialog --title "AKTUALNY STAN PRACOWNIKA" \
        --inputbox "Podaj Imie i Nazwisko pracownika (np. PatrykBradtke)" 8 40 "" \
        2> pracownik.txt

        pracownik=(`cat pracownik.txt`)

                if [ -e aktualny$pracownik.txt ]
                then

                dialog --title "AKTUALNY STAN PRACY $pracownik" \
                --textbox "aktualny$pracownik.txt" 0 0

                else

                dialog --title "KOMUNIKAT" \
                --msgbox "Pracownik $pracownik nie istnieje lub nie posiada aktualnego stanu pracy" 0 0

                fi

        elif [ $co -eq 3 ]
        then

        dialog --title "GODZINY" \
        --inputbox "Podaj Imie i Nazwisko pracownika, ktoremu chcesz dodac godziny (np. PatrykBradtke)" 0 0 "" \
        2> pracownik.txt

        pracownik=(`cat pracownik.txt`)

                if [ -e aktualny$pracownik.txt ]
                then

                dialog --title "DODAWANIE DNI" \
                --inputbox "Podaj dzien do ktorego chcesz dopisac godziny (np. 22.08)" 0 0 "" \
                2> dzien.txt

                dzien=(`cat dzien.txt`)

                echo "Dzien $dzien" >> godziny$pracownik.txt

                dialog --title "DODAWANIE GODZIN $pracownik" \
                --inputbox "Podaj ilosc godzin przepracowanych w dniu $dzien" 0 0 "" \
                2> godziny.txt

                godziny=(`cat godziny.txt`)
                stawka=(`cat stawka.txt`)

                suma=(`cat s$pracownik.txt`)

                suma=$[suma + godziny]

                echo "$suma" > s$pracownik.txt

                naleznosc=$[suma * stawka]

                touch godziny$pracownik.txt

                echo "Godzin: $godziny" >> godziny$pracownik.txt
                echo "Suma przepracowanych godzin: $suma" > suma$pracownik.txt
                echo "Naleznosc: $naleznosc" >> suma$pracownik.txt
                else

                dialog --title "KOMUNIKAT" \
                --msgbox "Pracownik $pracownik nie istnieje lub nie posiada aktualnego stanu pracy" 0 0

                fi

        elif [ $co -eq 4 ]
        then

        dialog --title "SZCZEGOLOWY ROZPIS DNI" \
        --inputbox "Podaj Imie i Nazwisko (np. PatrykBradtke)" 8 40 "" \
        2> pracownik.txt

        pracownik=(`cat pracownik.txt`)

                if [ -e godziny$pracownik.txt ]
                then

                dialog --title "SZCZEGOLOWY ROZPIS DNI $pracownik" \
                --textbox "godziny$pracownik.txt" 0 0

                else

                dialog --title "SZCZEGOLOWY ROZPIS DNI $pracownik" \
                --msgbox "Pracownik $pracownik nie istnieje lub nie zostaly wprowadzone szczegolowe dane dni" 0 0

                fi

        elif [ $co -eq 5 ]
        then

        dialog --title "NALEZNOSCI PRACOWNIKOW" \
        --inputbox "Podaj Imie i Nazwisko (np. PatrykBradtke)" 8 40 "" \
        2> pracownik.txt

        pracownik=(`cat pracownik.txt`)

                if [ -e suma$pracownik.txt ]
                then

                dialog --title "DANE $pracownik" \
                --textbox "suma$pracownik.txt" 0 0

                else

                dialog --title "NALEZNOSC DO ZAPLATY $pracownik" \
                --msgbox "Pracownik $pracownik nie istnieje lub nie zostaly wprowadzone dane o zaplacie" 0 0

                fi

        fi
fi

        dialog --title "ZAKONCZ LUB WROC" \
        --inputbox "Wpisz (tak) jezeli chcesz wrocic do menu glownego" 8 40 "" \
        2> powtorka.txt

        powtorka=(`cat powtorka.txt`)

done
