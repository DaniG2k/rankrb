module Rankrb
  class Document
    attr_accessor :id, :body, :rank

    def initialize(params={})
      @id = params.fetch :id, nil
      @body = params.fetch :body, ''
      @rank = params.fetch :rank, nil

    end

    def length
      tokens.join(' ').length
    end

    def include?(term)
      tokens.include? term_to_token(term)
    end

    def term_freq(term)
      tokens.count term_to_token(term)
    end

    def tokens
      Rankrb::Tokenizer.new(@body).tokenize
    end

    def uniq_tokens
      tokens.uniq
    end

    private
    def term_to_token(term)
      Rankrb::Tokenizer.new(term).tokenize.shift
    end
  end
end