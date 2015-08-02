require 'spec_helper'

describe Rankrb::InvertedIndex do
  before :each do
    @index = Rankrb::InvertedIndex.new
    @d1 = Rankrb::Document.new :id => 1, :body => "breakthrough drug for schizophrenia"
    @d2 = Rankrb::Document.new :id => 2, :body => "new schizophrenia drug"
    @d3 = Rankrb::Document.new :id => 3, :body => "new approach for treatment of schizophrenia"
    @d4 = Rankrb::Document.new :id => 4, :body => "new hopes for schizophrenia patients"
    
    @coll = Rankrb::Collection.new
    [@d1,@d2,@d3,@d4].each do |doc|
      @coll.docs << doc
    end
  end

  it "a new InvertedIndex object defaults to having an empty collection" do
    index = Rankrb::InvertedIndex.new
    expect(index.collection).to be_a_kind_of(Rankrb::Collection)
  end

  it '#build makes the inverted index' do
    d1 = Rankrb::Document.new :body => "new home sales top forecasts", :id => 1
    d2 = Rankrb::Document.new :body => "home sales rise in july", :id => 2
    d3 = Rankrb::Document.new :body => "increase in home sales in july", :id => 3
    d4 = Rankrb::Document.new :body => "july new home sales rise", :id => 4
    
    coll = Rankrb::Collection.new
    [d1, d2, d3, d4].each {|d| coll.docs << d}
    @index.collection = coll
    
    result = {
      "new" => [1, 4],
      "home" => [1, 2, 3, 4],
      "sale" => [1, 2, 3, 4],
      "top" => [1],
      "forecast" => [1],
      "rise" => [2, 4],
      "juli" => [2, 3, 4],
      "increas" => [3]
    }
    
    expect(@index.build).to eq(result)
  end

  it "#build sorts the tokens's doc ids" do
    d3 = Rankrb::Document.new :body => "increase in home sales in july", :id => 3
    d1 = Rankrb::Document.new :body => "new home sales top forecasts", :id => 1
    
    coll = Rankrb::Collection.new
    [d1, d3].each {|d| coll.docs << d}
    @index.collection = coll
    
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
    expect(@index.build).not_to eq(result)
  end

  it '#find returns the document ids for a word' do
    d1 = Rankrb::Document.new :id => 1, :body => "breakthrough drug for schizophrenia"
    d2 = Rankrb::Document.new :id => 2, :body => "new schizophrenia drug"
    coll = Rankrb::Collection.new

    [d1,d2].each {|d| coll.docs << d}
    @index.collection = coll
    
    @index.build
    expect(@index.find('breakthrough')).to eq([1])
  end

  it '#query_and performs a conjunctive query' do
    @index.collection = @coll
    @index.build
    expect(@index.query_and(['schizophrenia', 'drug'])).to eq([1, 2])
  end

  it '#query_or performs a disjunctive query' do
    @index.collection = @coll
    @index.build
    expect(@index.query_or(['schizophrenia', 'drug'])).to eq([*1..4])
  end

  it '#remove_doc removes a given document from the inverted index' do
    @index.collection = @coll
    @index.build
    @index.remove_doc(@d1)
    expect(@index.iidx).not_to have_key('breakthrough')
    @index.iidx.each {|k, v| expect(v).not_to include(1)}
  end
end