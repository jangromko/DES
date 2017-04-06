load 'stale_algorytmu.rb'
load 'funkcje.rb'

#=begin
print 'Podaj nazwę pliku wejściowego: '
nazwa_wej = gets.chomp

if File.file?(nazwa_wej)
  plik = File.binread(nazwa_wej)

  plik_przetworzony = []

  for i in 0..plik.size-1
    plik_przetworzony[i] = plik[i].unpack('H*')[0].hex
  end

  print 'Podaj klucz (w zapisie szesnastkowym): '
  klucz = gets.chomp.to_i(16).to_s(2).split(//).map(&:to_i)

  print 'Szyfrowanie/deszyfrowanie (s/d)? '
  tryb = gets.chomp

  if tryb.downcase == 's'
    print 'Podaj nazwę pliku wyjściowego: '
    nazwa_wyj = gets.chomp

    plik_zaszyfrowany = szyfruj(plik_przetworzony, klucz)

    File.binwrite(nazwa_wyj, plik_zaszyfrowany.pack('c*'))
    puts "Utworzono plik #{nazwa_wyj} z zaszyfrowaną zawartością."

  elsif tryb.downcase == 'd'
    print 'Podaj nazwę pliku wyjściowego: '
    nazwa_wyj = gets.chomp

    plik_odszyfrowany = deszyfruj(plik_przetworzony, klucz)

    File.binwrite(nazwa_wyj, plik_odszyfrowany.pack('c*'))
    puts "Utworzono plik #{nazwa_wyj} z odszyfrowaną zawartością."

  else
    puts 'Wybrano błędną opcję. Kończenie pracy programu...'
  end

else
  puts 'Podano błędną nazwę pliku. Kończenie pracy programu...'
end
#=end

=begin
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
=end