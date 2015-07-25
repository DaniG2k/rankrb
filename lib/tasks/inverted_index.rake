namespace :db do
  desc "Build the inverted index"
  task :build_inverted_index => :environment do
    puts "Executing inverted index rake task..."
  end
end