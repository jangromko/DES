# funkcja do przeprowadzania permutacji, może służyć również do rozszerzania tablicy wg określonego wzoru
def permutacja(we, permutacja)
  wy = []
  for i in 0..permutacja.size-1
    wy[i] = we[permutacja[i]-1]
  end

  wy
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

# funkcja XOR dla tablic bitów
def xor_tablicowy(a, b)
  wynik = liczba_na_tablice_bitow(a.join.to_i(2) ^ b.join.to_i(2))
  wyrownaj_do(wynik, [a.size, b.size].max)
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
  klucze = Array.new(17) {Array.new(2)}
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