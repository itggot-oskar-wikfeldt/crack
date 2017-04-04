def readfile(filename)
  f = File.open(filename)
  ary = []
  f.each_line do |line|
    ary.push(line.chomp)
  end
  return ary.sort
end


def crack(hashfile, wordfile)
  hashes = readfile(hashfile)

  salts = []

  hashes.each do |hash|
    salts.push hash[0..1]
  end

  salts.uniq!

  words = readfile(wordfile)

  words.each_with_index do |word, i|
    words[i] = word[0,8]
  end

  time = Time.new

  cracked_passwords = File.open("cracked-passwords-#{time.strftime("%Y-%m-%d-%H%M%S")}.txt", "w")

  words.each do |word|

    puts word

    salts.each do |salt|

      hashed_word = word.crypt(salt)

      hashes.each do |hash|

        if hashed_word == hash
          puts "#{hash} --> #{word}"
          cracked_passwords.write("#{hash} --> #{word}\n")
          break
        end

      end

    end


  end

  cracked_passwords.close

end

crack(ARGV[0], ARGV[1])