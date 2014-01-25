require 'bundler'
Bundler.require

require 'dotenv'
Dotenv.load

require 'sinatra/reloader' #if development?

require './app'

run App