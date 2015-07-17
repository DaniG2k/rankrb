module Rankrb
  class Collection

    def initialize(params={:docs=>[], :query=>nil})
      @docs = params[:docs]
      @query = params[:query]
    end

    def each(&block)
      self.each(&block)
    end

    def containing_term(term)
      total = 0
      @docs.each do |doc|
        total += 1 if doc.include?(term) 
      end
      total
    end
    
    def avg_dl
      doc_lengths = 0
      @docs.each do |doc|
        doc_lengths += doc.length
      end
      doc_lengths / total_docs
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
    
  end
end