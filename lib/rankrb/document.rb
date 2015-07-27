module Rankrb
  class Document
    attr_accessor :body, :rank

    def initialize(params={:body=>'', :rank=>nil})
      @doc_id = get_doc_id
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

    def get_doc_id
      config_path = File.expand_path("../#{@config.index}", __FILE__)
      unless @idx.nil?
        File.open(config_path) {|f| f.readline}
      end
    end

    def set_doc_id
      # Write the @doc_id + 1 to config
    end
  end
end