module Rankrb
  class Document
    attr_accessor :id, :body, :rank

    def initialize(params={})
      @id = params.fetch :id, nil
      @body = params.fetch :body, ''
      @rank = params.fetch :rank, nil
    end

    def tokens
      set_tokens
    end

    def length
      set_tokens.join(' ').length
    end

    def include?(term)
      set_tokens.include?(term_to_token(term))
    end

    def term_freq(term)
      set_tokens.count(term_to_token(term))
    end

    def uniq
      set_tokens.uniq
    end
    
    private
    def set_tokens
      @tknz ||= Rankrb::Tokenizer.new(@body).tokenize
    end
    
    def term_to_token(term)
      Rankrb::Tokenizer.new(term).tokenize.shift
    end
  end
end
