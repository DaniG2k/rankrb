module Rankrb
  class InvertedIndex
    attr_accessor :docid

    def initialize(params={})
      @index_file = params.fetch(:index, Rankrb.configuration.index)
    end

    def build(tokens)
    end

    def search(str)
    end

    def delete(str)
    end
  end
end
