load 'stale_algorytmu.rb'
load 'funkcje.rb'

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

=begin
puts klucz.to_s

puts s_boks([0,0,1,1,1,0], 2).to_s

puts klucz[0..27].to_s
puts klucz[28..55].to_s

blok = permutacja(blok, IP)

for i in 0..15
  klucz[0..27] = przesun_w_lewo(klucz[0..27], LS[i])
  klucz[28..55] = przesun_w_lewo(klucz[28..55], LS[i])

  k_x = permutacja(klucz, PC2)
  puts ''
  puts f(blok[32..63], k_x).to_s
  blok = blok[32..63] + xor_tablicowy(blok[0..31], f(blok[32..63], k_x))

  #puts ''
  puts 'L' + (i+1).to_s + ': ' + blok[0..31].to_s
  puts 'R' + (i+1).to_s + ': ' + blok[32..63].to_s

end

blok = blok[32..63] + blok[0..31]

blok = permutacja(blok, FP)
puts tablica_bitow_na_liczbe(blok).to_s(16)

=end
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