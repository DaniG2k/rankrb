require 'spec_helper'

describe Rankrb::InvertedIndex do
  before :each do
    @iidx = Rankrb::InvertedIndex.new
  end

  it 'initializes by taking a docID' do
    @iidx.docid = 3
    expect(@iidx.docid).to eq(3)
  end

  it 'builds and inverted index' do
  #  expect(false).to eq(true)
  end
  
  it 'searches the inverted index' do
  #  expect(false).to eq(true)
  end
  
  it 'deletes the docIDs from the inverted index' do
  #  expect(false).to eq(true)
  end
end