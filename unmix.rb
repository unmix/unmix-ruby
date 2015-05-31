#!/usr/bin/env ruby
require "thor"
require 'pry'
require 'open3'
require "awesome_print"
require "table_print"
require 'securerandom'
require 'restclient'

# global path configs
UNMIX_ROOT = File.dirname(__FILE__)
UNMIX_APP_ROOT = File.join( UNMIX_ROOT, 'app' )
EXTERNALS_COMMANDS = %i(youtube-dl ffmpeg dudud)

# required application sources
require "./app/unmix_thor.rb"
require "./app/unmix_helper.rb"
require "./app/sources/source_base.rb"
Dir[File.join(UNMIX_APP_ROOT, 'sources', '*.rb')].each {|file| require file }
Dir[File.join(UNMIX_APP_ROOT, 'services', '*.rb')].each {|file| require file }

# START APPLICATION!
Unmix::UnmixThor.start