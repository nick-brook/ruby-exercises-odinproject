def substrings(word,dictionary)

  # reduce array into a hash (results)
  dictionary.reduce(Hash.new(0)) do |results, substring|

      #  make case insentive
      substring_lc = substring.downcase

      # is the array element a substring of word
      if word.downcase.include? substring.downcase
        # check whether results already has found this substring, if so increment score, or add 
        results.has_key? substring_lc ? results[substring_lc] += 1 : results[substring_lc] = 1
      end
      results
    end
  end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","Low","own","part","partner","sit"]
p substrings("sitdownloW",dictionary)