# require "/usr/share/logstash/vendor/bundle/jruby/2.3.0/gems/logstash-devutils-1.3.5-java/lib/logstash/devutils/rspec/spec_helper"
# require 'logstash/devutils/rspec/spec_helper'


require 'support/logs_spec_helper'

RSPEC_ROOT = File.dirname __FILE__

Dir[RSPEC_ROOT + 'support/**/*.rb'].each { |f| require f }


def fixture_path
  File.expand_path("../fixtures", __FILE__) + '/'
end



# if ENV['COVERAGE']
#   require 'simplecov'
#   require 'coveralls'

#   SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
#     SimpleCov::Formatter::HTMLFormatter,
#     Coveralls::SimpleCov::Formatter
#   ]
#   SimpleCov.start do
#     add_filter 'spec/'
#     add_filter 'vendor/'
#   end
# end


# require "logstash-core"
# require "logstash/logging"
# require "logstash/environment"
# require "logstash/devutils/rspec/spec_helper"
# require "logstash/devutils/rspec/logstash_helpers"
# require "logstash/devutils/rspec/shared_examples"
# require "insist"
# require 'logstash/plugin'
# require 'logstash/filters/rest'
# require 'rspec/expectations'


# # running the grok code outside a logstash package means
# # LOGSTASH_HOME will not be defined, so let's set it here
# # before requiring the grok filter
# unless LogStash::Environment.const_defined?(:LOGSTASH_HOME)
#   LogStash::Environment::LOGSTASH_HOME = File.expand_path("../", __FILE__)
# end

# # require "logstash/filters/grok"
# # Dir[Ruby.root.join('spec/support/**/*.rb')].each { |f| require f }

# module GrokHelpers
#   def grok_match(label, message)
#     grok  = build_grok(label)
#     event = build_event(message)
#     grok.filter(event)
#     event.to_hash
#   end

#   def build_grok(label)
#     grok = LogStash::Filters::Grok.new("match" => ["message", "%{#{label}}"])
#     # Manually set patterns_dir so that grok finds them when we're testing patterns
#     grok.patterns_dir = ["/usr/share/logstash/patterns"]
#     grok.register
#     grok
#   end

#   def build_event(message)
#     LogStash::Event.new("message" => message)
#   end
# end

# Thread.abort_on_exception = true

# $TESTING = true
# if RUBY_VERSION < "1.9.2"
#   $stderr.puts "Ruby 1.9.2 or later is required. (You are running: " + RUBY_VERSION + ")"
#   raise LoadError
# end

# if ENV["TEST_DEBUG"]
#   LogStash::Logging::Logger::configure_logging("WARN")
# else
#   LogStash::Logging::Logger::configure_logging("OFF")
# end

# # removed the strictness check, it did not seem to catch anything

# RSpec.configure do |config|
#   # for now both include and extend are required because the newly refactored "input" helper method need to be visible in a "it" block
#   # and this is only possible by calling include on LogStashHelper
#   config.include LogStashHelper
#   config.extend LogStashHelper

#   exclude_tags = { :redis => true, :socket => true, :performance => true, :couchdb => true, :elasticsearch => true, :elasticsearch_secure => true, :export_cypher => true, :integration => true }

#   if LogStash::Environment.windows?
#     exclude_tags[:unix] = true
#   else
#     exclude_tags[:windows] = true
#   end

#   config.filter_run_excluding exclude_tags

#   config.include GrokHelpers

#   # Run specs in random order to surface order dependencies. If you find an
#   # order dependency and want to debug it, you can fix the order by providing
#   # the seed, which is printed after each run.
#   #     --seed 1234
#   config.order = :random
# end

# RSpec::Matchers.define :pass do |expected|
#   match do |actual|
#     !actual.include?("tags")
#   end
# end

# RSpec::Matchers.define :match do |value|
#   match do |grok|
#     grok  = build_grok(grok)
#     event = build_event(value)
#     grok.filter(event)
#     !event.include?("tags")
#   end
# end