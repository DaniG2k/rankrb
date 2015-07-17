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
      # TODO
      # Will need something better here to clean out the document.
      # Eg. QueryCleaner class.
      @body.gsub(/[^\s\p{Alnum}\p{Han}\p{Katakana}\p{Hiragana}\p{Hangul}]/,'')
      .downcase
      .split
      .count(term) 
    end
  end
end