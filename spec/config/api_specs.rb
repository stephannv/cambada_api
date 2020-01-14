RSpec.configure do |config|
  config.include RSpec::Rails::RequestExampleGroup, type: :api
end
