module Rankrb
  class Collection

    def initialize(params={:docs=>[], :query=>nil})
      @docs = params[:docs]
      @query = params[:query]
    end

    def containing_term(term)
      @docs.count {|doc| doc.include?(term)}
    end
    
    def avg_dl
      @docs.map(&:length).inject(:+) / total_docs
    end

    def total_docs
      @docs.size
    end

    def idf(term)
      numerator = total_docs - containing_term(term) + 0.5
      denominator = containing_term(term) + 0.5
      Math.log(numerator / denominator)
    end

    def bm25(params={:k => 1.2, :b => 0.75, :delta => 1.0})
      @k = params[:k]
      @b = params[:b]
      @delta = params[:delta]

      @docs.each do |doc|
        score = 0
        dl = doc.length
        query_terms = @query.split

        query_terms.each do |term|
          dtf = doc.term_freq(term)
          numerator = dtf * (@k + 1)
          denominator = dtf + @k * (1 - @b + @b * (doc.length / avg_dl))
          score += idf(term) * (numerator/denominator) + @delta
        end
        doc.rank = score
      end
      @docs
    end

    def sort_by_rank
      @docs.sort {|a, b| a.rank <=> b.rank}
    end
  end
end