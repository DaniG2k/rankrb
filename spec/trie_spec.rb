require 'spec_helper'

describe Rankrb::Trie do
  before :each do
    @trie = Rankrb::Trie.new
  end

  it 'builds a trie given a string' do
    %w(testing to see what kind of a trie i can come up with).each do |word|
      @trie.build(word)
    end
    result = {"t"=>{"e"=>{"s"=>{"t"=>{"i"=>{"n"=>{"g"=>{}}}}}}, "o"=>{}, "r"=>{"i"=>{"e"=>{}}}}, "s"=>{"e"=>{"e"=>{}}}, "w"=>{"h"=>{"a"=>{"t"=>{}}}, "i"=>{"t"=>{"h"=>{}}}}, "k"=>{"i"=>{"n"=>{"d"=>{}}}}, "o"=>{"f"=>{}}, "a"=>{}, "i"=>{}, "c"=>{"a"=>{"n"=>{}}, "o"=>{"m"=>{"e"=>{}}}}, "u"=>{"p"=>{}}}
    
    expect(@trie).to eq(result)
  end

  it 'searches a trie given a string' do
    %w(testing a test application).each do |word|
      @trie.build word
    end
    
    expect(@trie.search('testing')).to eq({})
    expect(@trie.search('test')).to eq({"i"=>{"n"=>{"g"=>{}}}})
  end

  it "returns nil if the string wasn't found in the trie" do
    %w(testing a trie).each do |word|
      @trie.build word
    end
    expect(@trie.search('nil')).to be_nil
  end
end