require 'spec_helper'

describe Rankrb::SpellingSuggester do
  before :each do
    @suggestor = Rankrb::SpellingSuggester.new
  end
  
  it '#levenshtein_distance returns the edit distance between two words' do
    expect(@suggestor.levenshtein_distance('fire', 'water')).to eq(4)
    expect(@suggestor.levenshtein_distance('cat','hat')).to eq(1)
    expect(@suggestor.levenshtein_distance('amazing', 'horse')).to eq(7)
  end
end