module Rankrb  
  class InvertedIndex
    attr_accessor :docs

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

    # Returns an array of document ids.
    def query(word)
      @iidx[word]
    end

    def query_and(word_ary)
      doc_ids = Array.new
      word_ary.each {|word| doc_ids << query(word) }
      doc_ids.inject(:&)
    end

    def query_or(word_ary)
      doc_ids = Array.new
      word_ary.each {|word| doc_ids << query(word) }
      doc_ids.inject(:|)
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
