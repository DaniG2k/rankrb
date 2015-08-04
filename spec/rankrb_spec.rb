require 'spec_helper'

describe Rankrb do
  it 'has a version number' do
    expect(Rankrb::VERSION).not_to be nil
  end

  it '❨╯°□°❩╯︵┻━┻ tells angry developers to calm down' do
  	expect(Rankrb.❨╯°□°❩╯︵┻━┻).to eq('Calm down yo!')
  end

  it 'allows configuration via a block' do
  	Rankrb.configure do |conf|
  		conf.index_file = 'indexfile.idx'
  	end
  	expect(Rankrb.configuration.index_file).to eq('indexfile.idx')
  end
end
