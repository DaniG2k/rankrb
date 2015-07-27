module Rankrb
  class InvertedIndex
    attr_accessor :docid
    def initialize(params={})
      @docid = params[:docid]
    end

    def build(tokens)
    end

    def search(str)
    end

    def delete(str)
    end
  end
end