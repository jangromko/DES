load 'stale_algorytmu.rb'
load 'funkcje.rb'

=begin

blok = '0123456789ABCDEF'.to_i(16).to_s(2).split(//).map(&:to_i)
klucz = '133457799BBCDFF1'.to_i(16).to_s(2).split(//).map(&:to_i)
blok = wyrownaj_do(blok, 64)
klucz = wyrownaj_do(klucz, 64)

klucze = generuj_klucze(klucz)
wynik = szyfruj_blok(blok, klucze)

for i in 0..wynik.size-1
  puts wynik[i].to_s(16)
end
puts ""
blok_zaszyfrowany = '85E813540F0AB405'.to_i(16).to_s(2).split(//).map(&:to_i)
wynik2 = deszyfruj_blok(blok_zaszyfrowany, klucze)

for i in 0..wynik2.size-1
  puts wynik2[i].to_s(16)
end

=end

wejscie = [1, 35, 69, 103, 137, 171, 205, 239, 1, 35, 69, 103, 137, 171, 205, 239, 16, 35, 69, 103, 137, 171, 205, 239, 1, 35, 69, 103]

klucz = '133457799BBCDFF1'.to_i(16).to_s(2).split(//).map(&:to_i)
wynik = szyfruj(wejscie, klucz)

for i in 0..wynik.size-1
  print wynik[i].to_s(16)
end


puts ''
deszyfr = deszyfruj(wynik, klucz)
for i in 0..deszyfr.size-1
  print deszyfr[i].to_s(16)
end

=begin
print 'Podaj nazwę pliku wejściowego: '
nazwa_wej = gets.chomp

if File.file?(nazwa_wej)
  plik = File.binread(nazwa_wej)

  plik_przetworzony = []

  for i in 0..plik.size-1
    plik_przetworzony[i] = plik[i].unpack('H*')[0].hex
  end

  print 'Podaj klucz (w zapisie szesnastkowym): '
  klucz = gets.chomp.to_i(16)

  print 'Szyfrowanie/deszyfrowanie (s/d)? '
  tryb = gets.chomp

  if tryb.downcase == 's'
    print 'Podaj nazwę pliku wyjściowego: '
    nazwa_wyj = gets.chomp

  elsif tryb.downcase == 'd'
    print 'Podaj nazwę pliku wyjściowego: '
    nazwa_wyj = gets.chomp

  else
    puts 'Wybrano błędną opcję. Kończenie pracy programu...'
  end

else
  puts 'Podano błędną nazwę pliku. Kończenie pracy programu...'
end
=end
