namespace :db do
  desc "Create inverted index table"
  task :create_inverted_index => :environment do
    `rails g migration RankrbIndex word:string:index unit_id:string`
    `rake db:migrate`
  end

  desc "Build the inverted index"
  task :build_inverted_index => :environment do
    puts "Executing inverted index rake task..."
  end
end