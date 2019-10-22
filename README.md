# **[ASU][Projekt 1][zadanie 8 - tabelki]**
## *Polecenie*
Proszę napisać skrypt do tworzenia tabelek w LaTeXu: z pliku z liczbami oddzielonymi jakimiś separatorami
(spacje, nowe wiersze, średniki — zbiór sep. powinien być definiowalny) zrobić tabelkę o zadanej liczbie
kolumn. Dokładać (włączane przez opcje) podsumowanie w wierszach, kolumnach, puste nagłówki wierszy
i kolumn. Zapewnić możliwość obrócenia tabeli o 90 stopni (tzn. dane podane w pliku wierszami umieścić
w kolumnach).
##*Parametry wywołania skryptu*
* -tr transpozycja tabeli
* nagłówki
    * -hc dla kolumn
    * -hr dla wierszy
* posumowania
    * -sc dla kolumn
    * -sr dla wierszy
* separatory
  * -c=? dla kolumn gdzie ? to separator nieposiadający cyfry w swoim ciągu znaków
  * -r=? dla wierszy gdzie ? to separator nieposiadający cyfry w swoim ciągu znaków
    
    separatory muszą być unikalne 
##*Użycie*
Aby wygenerować tabelę w LaTeXie należy wywołać polecenie z głównego katalogu projektu:
```
perl src/LaTeX table generator.pl -c=- -r=;
```
##*Przykłady użycia*

plik wejściowy:
``` text
0-1-2-3-4;10-11-12-13-14;20-21-22-23-24;
```
*
    polecenie uruchamiające:
    ``` text
    perl src/LaTeX table generator.pl -tr -hc -hr -sr -sc -c=- -c=. -r=; -r='
    ```
    uzykana tabela:
    ![tabela 1](documentation/Zrzut%20ekranu%20z%202019-10-22%2021-07-58.png)
*
    polecenie uruchamiające:
    ``` text
    perl src/LaTeX table generator.pl -hc -hr -sc -c=- -c=. -r=; -r='
    ```
    uzykana tabela:
    ![tabela 2](documentation/Zrzut%20ekranu%20z%202019-10-22%2021-13-05.png)
*
    polecenie uruchamiające:
    ``` text
    perl src/LaTeX table generator.pl -c=- -c=. -r=; -r='
    ```
    uzykana tabela:
    ![tabela 3](documentation/Zrzut%20ekranu%20z%202019-10-22%2021-16-34.png)