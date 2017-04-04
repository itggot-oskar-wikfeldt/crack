words = ["hjdj", "fuuhdddaa", "fhhfffffffff"]

words.each_with_index do |word, i|
  words[i] = word[0,8]
end

p words