module Rankrb  
  class InvertedIndex
    attr_accessor :docs, :iidx

    def initialize(params={})
      @docs = params.fetch(:docs, [])
      #@index_file = params.fetch(:index, Rankrb.configuration.index)
      #@index_file = Rails.root.join('db', 'index.json')
      @index_file = 'db/index.json'
      @iidx = Hash.new
    end

    def build
      @docs.each do |doc|
        doc.tokens.each do |token|
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
      @iidx
    end

    # Returns an array of document ids.
    def query(word)
      @iidx[word]
    end

    # Define query_or and query_and methods.
    %w(and or).each do |op|
      define_method("query_#{op}") do |word_ary|
        doc_ids = Array.new
        word_ary.each {|word| doc_ids << query(word) }
        case op
        when 'and'
          symbol = :&
        when 'or'
          symbol = :|
        end
        doc_ids.inject(symbol)
      end
    end

    def commit(tokens)
      if File.exist?(@index_file)
        file = File.read @index_file
        # Merge the new tokens
        iidx = JSON.parse(file).merge(tokens)
        File.open(@index_file, 'w+') do |f|
          f.write iidx.to_json
        end
      else
        # Create & write to file for the first time
        File.open(@index_file, 'w') do |f|
          f.write(tokens)
        end
      end
    end

  end
end
