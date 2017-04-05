# funkcja do przeprowadzania permutacji, może służyć również do rozszerzania tablicy wg określonego wzoru
def permutacja(wejscie, permutacja)
  wyjscie = []
  for i in 0..permutacja.size-1
    wyjscie[i] = wejscie[permutacja[i]-1]
  end

  wyjscie
end

# wyrównywanie danego ciągu bitów do podanej długości poprzez dostawienie zer z przodu
def wyrownaj_do(ciag_bitow, oczekiwana_dlugosc)
  dodatkowe_zera = []
  until ciag_bitow.size + dodatkowe_zera.size == oczekiwana_dlugosc
    dodatkowe_zera.push(0)
  end

  dodatkowe_zera + ciag_bitow
end

def liczba_na_tablice_bitow(liczba)
  liczba.to_s(2).split(//).map(&:to_i)
end

def tablica_bitow_na_liczbe(tablica)
  tablica.join.to_i(2)
end

def blok_na_tablice_bitow(blok)
  wynik = []
  for i in 0..7
    wynik += wyrownaj_do(liczba_na_tablice_bitow(blok[i]), 8)
  end

  wynik
end

def tablica_bitow_na_blok(tablica_bitow)
  wynik = []
  for i in 0..7
    wynik += [tablica_bitow_na_liczbe(tablica_bitow[(8*i)..(8*i+7)])]
  end
end

# funkcja XOR dla tablic bitów
def xor_tablicowy(a, b)
  #wynik = liczba_na_tablice_bitow(a.join.to_i(2) ^ b.join.to_i(2))
  #wyrownaj_do(wynik, [a.size, b.size].max)

  for i in 0..a.size-1
    a[i] ^= b[i]
  end

  a
end

# funkcja obliczająca numer wiersza i kolumny do S-boksa
def wiersz_kolumna(wejscie)
  wiersz = (wejscie[0] << 1) + (wejscie[5])
  kolumna = tablica_bitow_na_liczbe(wejscie[1..4])

  [wiersz, kolumna]
end

def przesun_w_lewo(wejscie, ile_pozycji)
  for i in 0..ile_pozycji-1
    wejscie.push(wejscie.shift)
  end
  wejscie
end


# funkcja przekształcająca tablicę bitów na S-boksach
def s_boks(wejscie, numer)
  wiersz, kolumna = wiersz_kolumna(wejscie)
  wyrownaj_do(liczba_na_tablice_bitow(SI[numer][16*wiersz+kolumna]), 4)
end

# funkcja f(R, K) (Feistela)
def f(r, k)
  r = permutacja(r, E)
  r = xor_tablicowy(r, k)

  wynik = []
  for i in 0..7
    wynik += s_boks(r[6*i..6*i+5], i)
  end

  permutacja(wynik, P)
end

def pakuj_w_blok(tablica_bitow)
  blok = []

  for i in 0..7
    blok[i] = tablica_bitow_na_liczbe(tablica_bitow[(8*i)..(8*i+7)])
  end

  blok
end

def generuj_klucze(klucz)
  klucz = permutacja(klucz, PC1)
  klucze = Array.new(17) { Array.new(2) }
  klucze[0][0..27] = klucz[0..27]
  klucze[0][28..55] = klucz[28..55]

  for i in 1..16
    klucze[i][0..27] = przesun_w_lewo(klucze[i-1][0..27].clone, LS[i-1])
    klucze[i][28..55] = przesun_w_lewo(klucze[i-1][28..55].clone, LS[i-1])
  end

  for i in 0..16
    klucze[i] = permutacja(klucze[i], PC2)
  end

  klucze
end

# szyfrowanie pojedynczego bloku
def szyfruj_blok(blok, klucze)
  blok = permutacja(blok, IP)

  for i in 0..15
    blok = blok[32..63] + xor_tablicowy(blok[0..31], f(blok[32..63], klucze[i+1]))
  end

  blok = blok[32..63] + blok[0..31]

  pakuj_w_blok(permutacja(blok, FP))
end

# deszyfrowanie pojedynczego bloku
def deszyfruj_blok(blok, klucze)
  blok = permutacja(blok, IP)

  for i in 0..15
    blok = blok[32..63] + xor_tablicowy(blok[0..31], f(blok[32..63], klucze[16-i]))
  end

  blok = blok[32..63] + blok[0..31]

  pakuj_w_blok(permutacja(blok, FP))
end

# funkcja szyfrująca podane na wejściu dane o dowolnym rozmiarze
def szyfruj(wejscie, klucz)
  klucz = wyrownaj_do(klucz, 64)
  klucze = generuj_klucze(klucz)

  liczba_blokow_pelnych = wejscie.size/8
  rozmiar_niepelnego_bloku = wejscie.size%8

  dodany = 0
  if rozmiar_niepelnego_bloku != 0
    ostatni_blok_danych = Array.new(8) { 0 }
    ostatni_blok_danych[0..rozmiar_niepelnego_bloku-1] = wejscie[liczba_blokow_pelnych*8..(liczba_blokow_pelnych*8+rozmiar_niepelnego_bloku-1)]

    for i in 1..(8-rozmiar_niepelnego_bloku)
      wejscie += [0]
    end

    dodany = 1
  end

  dodatkowy_blok = Array.new(8) { 0 }
  dodatkowy_blok[0] = rozmiar_niepelnego_bloku

  wejscie += dodatkowy_blok

  wynik_szyfrowania = []
  for i in 0..liczba_blokow_pelnych+dodany
    wynik_szyfrowania += szyfruj_blok(blok_na_tablice_bitow(wejscie[(i*8)..(i*8+7)]), klucze)
  end

  wynik_szyfrowania
end

# funkcja deszyfrująca podane na wejściu dane o dowolnym rozmiarze
def deszyfruj(wejscie, klucz)
  klucz = wyrownaj_do(klucz, 64)
  klucze = generuj_klucze(klucz)

  liczba_blokow = wejscie.size/8
  wynik_deszyfrowania = []

  for i in 0..liczba_blokow-1
    wynik_deszyfrowania += deszyfruj_blok(blok_na_tablice_bitow(wejscie[(i*8)..(i*8+7)]), klucze)
  end

  nadmiar = wynik_deszyfrowania[wynik_deszyfrowania.size-8]

  for i in 0..nadmiar+7
    wynik_deszyfrowania.pop
  end

  wynik_deszyfrowania
end
