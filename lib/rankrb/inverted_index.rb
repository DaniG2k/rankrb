module Rankrb  
  class InvertedIndex
    attr_accessor :docid

    def initialize(params={})
      @index_file = params.fetch(:index, Rankrb.configuration.index)
    end

    def build(tokens)
      filename = 'db/index.json'

      if File.exist?(filename)
        file = File.read(filename)
        #merge the new tokens
        iidx = JSON.parse(file).merge({"a" => "1", "b" => "2"})

        File.open(filename, 'w+') do |f|
          f.write iidx.to_json
        end
      else
        File.open(filename, 'w') do |f|
          f.write('This is a test!')
        end
      end
    end

    def search(str)
    end

    def delete(str)
    end
  end
end
