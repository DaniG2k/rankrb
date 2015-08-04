module Rankrb
  class Document
    attr_accessor :id, :body, :rank

    def initialize(params={})
      @id = params.fetch :id, nil
      @body = params.fetch :body, ''
      @rank = params.fetch :rank, nil
    end

    def tokens
      @tknz = Rankrb::Tokenizer.new(@body).tokenize
    end

    def length
      @tknz.join(' ').length
    end

    def include?(term)
      @tknz.include? term
    end

    def term_freq(term)
      @tknz.count term
    end

    def uniq
      binding.pry
    end
    #private
    #def term_to_token(term)
    #  Rankrb::Tokenizer.new(term).tokenize.shift
    #end
  end
end
