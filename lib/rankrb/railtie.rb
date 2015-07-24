module Rankrb
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/inverted_index.rake'
    end
  end
end