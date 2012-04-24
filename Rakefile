ENGINE_PATH = File.dirname(__FILE__)
APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)

if File.exists?(APP_RAKEFILE)
  load 'rails/tasks/extension.rake'
end

require "refinerycms-testing"
Refinery::Testing::Railtie.load_tasks
