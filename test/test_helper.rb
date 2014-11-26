require "minitest/autorun"
require 'webmock/minitest'
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each {|f| require f}

require "./dm"

def load_fixrute(name)
  File.read "./test/fixtures/#{name}"
end
