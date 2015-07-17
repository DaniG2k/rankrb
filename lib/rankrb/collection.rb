module Rankrb
  class Collection

    def initialize(params={:docs=>[], :query=>nil})
      @docs = params[:docs]
      @query = params[:query]
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
  end
end