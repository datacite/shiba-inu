# frozen_string_literal: true
#--
# Copyright 2006, 2007 by Chad Fowler, Rich Kilmer, Jim Weirich, Eric Hodel
# and others.
# All rights reserved.
# See LICENSE.txt for permissions.
#++

# Make sure rubygems isn't already loaded.
if ENV['RUBYOPT'] or defined? Gem
  ENV.delete 'RUBYOPT'

  require 'rbconfig'
  cmd = [RbConfig.ruby, 'setup.rb', *ARGV].compact
  cmd[1,0] = "--disable-gems"

  exec(*cmd)
end

Dir.chdir File.dirname(__FILE__)

$:.unshift File.expand_path('lib')
require 'rubygems'
require 'rubygems/gem_runner'
require 'rubygems/exceptions'

Gem::CommandManager.instance.register_command :setup

args = ARGV.clone
if ENV["GEM_PREV_VER"]
  args = [ '--previous-version', ENV["GEM_PREV_VER"] ] + args
end
args.unshift 'setup'

begin
  Gem::GemRunner.new.run args
rescue Gem::SystemExitException => e
  exit e.exit_code
end
