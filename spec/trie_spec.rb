require 'spec_helper'

describe Rankrb::Trie do
  it 'builds a trie given a string' do
  	trie = Rankrb::Trie.new
  	%w(testing to see what kind of a trie i can come up with).each do |word|
  		trie.build(word)
  	end
  	result = {"t"=>{"e"=>{"s"=>{"t"=>{"i"=>{"n"=>{"g"=>{}}}}}}, "o"=>{}, "r"=>{"i"=>{"e"=>{}}}}, "s"=>{"e"=>{"e"=>{}}}, "w"=>{"h"=>{"a"=>{"t"=>{}}}, "i"=>{"t"=>{"h"=>{}}}}, "k"=>{"i"=>{"n"=>{"d"=>{}}}}, "o"=>{"f"=>{}}, "a"=>{}, "i"=>{}, "c"=>{"a"=>{"n"=>{}}, "o"=>{"m"=>{"e"=>{}}}}, "u"=>{"p"=>{}}}
    
    expect(trie).to eq(result)
  end

  it 'searches a trie given a string' do
  	trie = Rankrb::Trie.new
  	%w(testing a test application).each do |word|
  		trie.build word
  	end
  	
    expect(trie.search('testing')).to eq({})
  end
end