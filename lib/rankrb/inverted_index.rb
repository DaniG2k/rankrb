module Rankrb  
  class InvertedIndex
    attr_accessor :docid

    def initialize(params={})
      #@index_file = params.fetch(:index, Rankrb.configuration.index)
      @index_file = Rails.root.join('db', 'index.json')
    end

    def build(tokens)
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
