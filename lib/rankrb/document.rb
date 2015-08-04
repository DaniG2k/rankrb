module Rankrb
  class Document
    attr_accessor :id, :body, :rank

    def initialize(params={})
      @id = params.fetch :id, nil
      @body = params.fetch :body, ''
      @rank = params.fetch :rank, nil
    end

    def tokens
      @t = Rankrb::Tokenizer.new(@body).tokenize
      @t
    end

    def length
      @t.join(' ').length
    end

    def include?(term)
      @t.include? term
    end

    def term_freq(term)
      @t.count term
    end
    #private
    #def term_to_token(term)
    #  Rankrb::Tokenizer.new(term).tokenize.shift
    #end
  end
end
