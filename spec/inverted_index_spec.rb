require 'spec_helper'

describe Rankrb::InvertedIndex do
  before :each do
    @iidx = Rankrb::InvertedIndex.new
  end

  it 'builds an empty array if no docs provided' do
    expect(@iidx.build).to be_empty
  end

  it 'builds and inverted index' do
    d1 = Rankrb::Document.new :body => "new home sales top forecasts", :id => 1
    d2 = Rankrb::Document.new :body => "home sales rise in july", :id => 2
    d3 = Rankrb::Document.new :body => "increase in home sales in july", :id => 3
    d4 = Rankrb::Document.new :body => "july new home sales rise", :id => 4
    
    @iidx.docs = [d1, d2, d3, d4]
    result = {
      "new"=>[1, 4],
      "home"=>[1, 2, 3, 4],
      "sales"=>[1, 2, 3, 4],
      "top"=>[1],
      "forecasts"=>[1],
      "rise"=>[2, 4],
      "in"=>[2, 3],
      "july"=>[2, 3, 4],
      "increase"=>[3]
    }
    expect(@iidx.build).to eq(result)
  end
  
  it 'searches the inverted index' do
  #  expect(false).to eq(true)
  end
  
  it 'deletes the docIDs from the inverted index' do
  #  expect(false).to eq(true)
  end
end