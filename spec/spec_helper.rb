$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rails'
require 'action_controller'
require 'action_controller/test_case'
require 'action_controller/railtie'
require 'active_support/json'
require 'active_model_serializers'
require 'active_model_serializers/jsonapi_embedded_records_deserializer'

require 'rspec/rails'

Dir[File.join('./spec/support/**/*.rb')].each { |f| require f }
