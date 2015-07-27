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
      Rankrb::Tokenizer.new(@body).tokenize.count(term)
    end

    def tokens
      Rankrb::Tokenizer.new(@body).tokenize.uniq
    end
  end
end