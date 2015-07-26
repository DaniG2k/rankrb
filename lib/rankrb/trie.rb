module Rankrb
  class Trie < Hash
    def initialize
      # Ensure that this is not a special Hash by disallowing
      # initialization options.
      super
    end

    def build str
      str.chars.inject(self) { |hash, char| hash[char] ||= {} }
    end
  end
end