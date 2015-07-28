module Rankrb
  #
  # Porter stemmer in Ruby.
  # See also http://www.tartarus.org/~martin/PorterStemmer
  #
  class Stemmer
    # Make the stem_porter the default stem method, just in case we
    # feel like having multiple stemmers available later.
    
    alias_method :stem, :stem_porter
    
    def initialize(str)
      @str = str
    end

    STEP_2_LIST = {
      'ational'=>'ate', 'tional'=>'tion', 'enci'=>'ence', 'anci'=>'ance',
      'izer'=>'ize', 'bli'=>'ble',
      'alli'=>'al', 'entli'=>'ent', 'eli'=>'e', 'ousli'=>'ous',
      'ization'=>'ize', 'ation'=>'ate',
      'ator'=>'ate', 'alism'=>'al', 'iveness'=>'ive', 'fulness'=>'ful',
      'ousness'=>'ous', 'aliti'=>'al',
      'iviti'=>'ive', 'biliti'=>'ble', 'logi'=>'log'
    }
    
    STEP_3_LIST = {
      'icate'=>'ic', 'ative'=>'', 'alize'=>'al', 'iciti'=>'ic',
      'ical'=>'ic', 'ful'=>'', 'ness'=>''
    }
    
    SUFFIX_1_REGEXP = /(
      ational  |
      tional   |
      enci     |
      anci     |
      izer     |
      bli      |
      alli     |
      entli    |
      eli      |
      ousli    |
      ization  |
      ation    |
      ator     |
      alism    |
      iveness  |
      fulness  |
      ousness  |
      aliti    |
      iviti    |
      biliti   |
      logi)$/x

    SUFFIX_2_REGEXP = /(
      al       |
      ance     |
      ence     |
      er       |
      ic       | 
      able     |
      ible     |
      ant      |
      ement    |
      ment     |
      ent      |
      ou       |
      ism      |
      ate      |
      iti      |
      ous      |
      ive      |
      ize)$/x

    C = "[^aeiou]"             # consonant
    V = "[aeiouy]"             # vowel
    CC = "#{C}(?>[^aeiouy]*)"  # consonant sequence
    VV = "#{V}(?>[aeiou]*)"    # vowel sequence

    MGR0 = /^(#{CC})?#{VV}#{CC}/o                # [cc]vvcc... is m>0
    MEQ1 = /^(#{CC})?#{VV}#{CC}(#{VV})?$/o       # [cc]vvcc[vv] is m=1
    MGR1 = /^(#{CC})?#{VV}#{CC}#{VV}#{CC}/o      # [cc]vvccvvcc... is m>1
    VOWEL_IN_STEM   = /^(#{CC})?#{V}/o           # vowel in stem
    
    def stem_porter
      # make a copy of the given object and convert it to a string.
      #w = self.dup.to_s
      
      return @str if @str.length < 3
      
      # now map initial y to Y so that the patterns never treat it as vowel
      @str[0] = 'Y' if @str[0] == ?y
      
      # Step 1a
      if @str =~ /(ss|i)es$/
        @str = $` + $1
      elsif @str =~ /([^s])s$/ 
        @str = $` + $1
      end

      # Step 1b
      if @str =~ /eed$/
        @str.chop! if $` =~ MGR0 
      elsif @str =~ /(ed|ing)$/
        stem = $`
        if stem =~ VOWEL_IN_STEM 
          @str = stem
          case @str
            when /(at|bl|iz)$/             then @str << "e"
            when /([^aeiouylsz])\1$/       then @str.chop!
            when /^#{CC}#{V}[^aeiouwxy]$/o then @str << "e"
          end
        end
      end

      if @str =~ /y$/ 
        stem = $`
        @str = stem + "i" if stem =~ VOWEL_IN_STEM 
      end

      # Step 2
      if @str =~ SUFFIX_1_REGEXP
        stem = $`
        suffix = $1
        # print "stem= " + stem + "\n" + "suffix=" + suffix + "\n"
        if stem =~ MGR0
          @str = stem + STEP_2_LIST[suffix]
        end
      end

      # Step 3
      if @str =~ /(icate|ative|alize|iciti|ical|ful|ness)$/
        stem = $`
        suffix = $1
        @str = stem + STEP_3_LIST[suffix] if stem =~ MGR0
      end

      # Step 4
      if @str =~ SUFFIX_2_REGEXP
        stem = $`
        @str = stem if stem =~ MGR1
      elsif @str =~ /(s|t)(ion)$/
        stem = $` + $1
        @str = stem if stem =~ MGR1
      end

      #  Step 5
      if @str =~ /e$/ 
        stem = $`
        if (stem =~ MGR1) || (stem =~ MEQ1 && stem !~ /^#{CC}#{V}[^aeiouwxy]$/o)
          @str = stem
        end
      end

      @str.chop! if (@str =~ /ll$/ && @str =~ MGR1)
      # then turn initial Y back to y
      @str[0] = 'y' if @str[0] == ?Y
      @str
    end
  end
end