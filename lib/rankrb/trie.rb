module Rankrb
  class Trie < Hash
    def initialize
      # Ensure that this is not a special Hash by disallowing
      # initialization options.
      super
    end

    def build(str)
      str.chars.inject(self) do |hash, char|
        hash[char] ||= {}
      end
      self
    end

    def search(str, obj=self)
      if str.length <= 1
        obj[str]
      else
        str_array = str.chars
        next_trie = obj[str_array.shift]

        if next_trie
          # Recurse inside the returned trie.
          search(str_array.join, next_trie)
        else
          # String wasn't found in trie.
          nil
        end
      end
    end
  end

end