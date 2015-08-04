module Rankrb
  class InvertedIndex
    attr_accessor :collection, :iidx

    def initialize(params={})
      @collection = params.fetch(:collection, Rankrb::Collection.new)
      @index_file = Rankrb.configuration.index_file
      @iidx = Hash.new
    end

    def build
      @collection.docs.each do |doc|
        doc.uniq_tokens.each do |token|
          if @iidx[token]
            @iidx[token] << doc.id
          else
            @iidx[token] = [doc.id]
          end
        end
      end
      # Now sort the document ids and return the inverted index!
      @iidx.each {|k, v| @iidx[k] = v.sort}
    end

    def remove_doc(doc)
      doc.tokens.each do |token|
        # Remove the document id
        @iidx[token].delete(doc.id)
        # Remove the key from the hash if there are no docs
        @iidx.delete(token) if @iidx[token].empty?
      end
      # Once all tokens have been removed,
      # temove the document from the collection.
      @collection.remove_doc(doc)
      @iidx
    end

    # Returns an array of document ids.
    def find(str)
      Rankrb::Tokenizer.new(str)
        .tokenize
        .map {|token| @iidx[token]}
        .compact
        .flatten
        .uniq
        .sort
    end

    # Define query_or and query_and methods.
    %w(and or).each do |op|
      define_method("query_#{op}") do |word_ary|
        doc_ids = Array.new
        word_ary.each {|word| doc_ids << find(word) }
        case op
        when 'and'
          symbol = :&
        when 'or'
          symbol = :|
        end
        doc_ids.inject(symbol)
      end
    end

    def commit!
      if File.exist?(@index_file)
        file = File.read @index_file
        # Merge the new tokens
        index = JSON.parse(file).merge(@iidx)
        File.open(@index_file, 'w+') { |f| f.write(index.to_json) }
      else
        # Create & write to file for the first time
        File.open(@index_file, 'w') { |f| f.write(@iidx) }
      end
    end

  end
end
