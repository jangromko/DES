load 'stale_algorytmu.rb'

def permutacja(we, permutacja)
  wy = []

  for i in 0..permutacja.size-1
    wy[i] = we[permutacja[i]-1]
  end

  wy
end

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