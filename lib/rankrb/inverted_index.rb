module Rankrb  
  class InvertedIndex
    attr_accessor :docs

    def initialize(params={})
      @docs = params.fetch(:docs, [])
      #@index_file = params.fetch(:index, Rankrb.configuration.index)
      #@index_file = Rails.root.join('db', 'index.json')
      @index_file = 'db/index.json'
    end

    def build
      iidx = Hash.new
      @docs.each do |doc|
        doc.tokens.each do |token|
          if iidx[token]
            iidx[token] << doc.id
          else
            iidx[token] = [doc.id]
          end
        end
      end
      # Now sort the document ids!
      iidx.each {|k, v| iidx[k] = v.sort}
    end

    def write(tokens)
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

    def search(str)
    end

    def delete(str)
    end
  end
end
