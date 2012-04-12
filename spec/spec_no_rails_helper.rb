require 'active_record'
require 'database_cleaner'

db = YAML.load(File.open('config/database.yml'))['test']
ActiveRecord::Base.establish_connection(db)

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end unless defined?(Rails)
