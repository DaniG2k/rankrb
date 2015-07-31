require 'spec_helper'

describe Rankrb::InvertedIndex do
  before :each do
    @iidx = Rankrb::InvertedIndex.new
  end

  it '#build defaults to an empty hash' do
    expect(@iidx.build).to be_kind_of(Hash)
  end

  it '#build makes the inverted index' do
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

  it '#build sorts the tokens\'s doc ids' do
    d3 = Rankrb::Document.new :body => "increase in home sales in july", :id => 3
    d1 = Rankrb::Document.new :body => "new home sales top forecasts", :id => 1
    @iidx.docs = [d3, d1]
    
    result = {
      "increase"=>[3],
      "in"=>[3],
      "home"=>[3, 1],
      "sales"=>[3, 1],
      "july"=>[3],
      "new"=>[1],
      "top"=>[1],
      "forecasts"=>[1]
    }
    expect(@iidx.build).not_to eq(result)
  end
end