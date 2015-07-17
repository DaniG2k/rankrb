require 'spec_helper'

describe Rankrb::Ranker do
	before(:each) do
    @ranker = Rankrb::Ranker.new
  end

	it 'has a nil collection by default' do
    expect(@ranker.collection).to be_nil
  end

  it 'has a nil query by default' do
    expect(@ranker.query).to be_nil
  end
end