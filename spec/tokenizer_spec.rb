require 'spec_helper'

describe Rankrb::Tokenizer do
  it 'tokenizes a string' do
    str = "This is a body."
    tokenizer = Rankrb::Tokenizer.new(str)
    expect(tokenizer.tokenize).to eq(%w(this is a body))
  end
end