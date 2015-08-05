module Rankrb
  class Collection
    attr_accessor :query, :docs

    def initialize(params={})
      @docs = params.fetch(:docs, [])
      @query = params.fetch(:query, nil)

      def @docs.<<(arg)
        self.push arg
      end
    end

    def remove_doc(doc)
      @docs.delete_if do |curr_doc|
        curr_doc == doc
      end
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
        tokens = Rankrb::Tokenizer.new(@query).tokenize

        tokens.each do |token|
          dtf = doc.term_freq(token)
          numerator = dtf * (@k + 1)
          denominator = dtf + @k * (1 - @b + @b * (doc.length / avg_dl))
          score += idf(token) * (numerator/denominator) + @delta
        end
        doc.rank = score
      end
    end
  end
end
