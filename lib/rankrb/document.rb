module Rankrb
  class Document
    attr_accessor :body, :rank

    def initialize(params={:body=>'', :rank=>nil})
      @body = params[:body]
      @rank = params[:rank]
    end

    def length
      @body.length
    end

    def include?(term)
      @body.include?(term)
    end

    def term_freq(term)
      to_token.count(term)
    end

    def tokens
      to_token.uniq
    end

    private
    def to_token
      Rankrb::Tokenizer.new(@body).tokenize
    end
  end
end