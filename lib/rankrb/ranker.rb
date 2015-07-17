module Rankrb
	class Ranker
		attr_accessor :collection, :query
		
		def initialize(params={:collection => nil, :query => nil})
			@collection = params[:collection]
			@query = params[:query]
		end
	end
end