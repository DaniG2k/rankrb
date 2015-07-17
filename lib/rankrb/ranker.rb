module Rankrb
  class Ranker
    attr_accessor :collection, :query
    
    def initialize(params={:collection => nil, :query => nil})
      @collection = params[:collection]
      @query = params[:query]
    end

    #def bm25(params)
    #  dl = @doc.length
    #  # Variables that can be tuned for BM25+
    #  k = params.fetch(:k, 1.2)
    #  b = params.fetch(:b, 0.75)
    #  delta = params.fetch(:delta, 1.0)

    #  score = 0
    #  @query_terms.each do |term|
    #    numerator = term_freq(term) * (k + 1)
    #    denominator = term_freq(term) + k * (1 - b + b * (dl / avg_dl))
    #    score += idf(term) * (numerator/denominator) + delta
    #  end
    #  score
    #end

    def idf(term)
      numerator = @collection.total_docs - @collection.containing_term(term) + 0.5
      denominator = @collection.containing_term(term) + 0.5
      Math.log(numerator / denominator)
    end
  end
end