#!/usr/bin/env ruby

require 'sinatra'
require 'json'
require 'slim'

# 1. Basic DSL
get '/' do
  "Hello World!\n"
end

# 2. Pattern Matching and Parameters
get '/patterns/params/:name?' do
  name = params.delete(:name) || "Guest"
  other_params_str = params.map { |k, v| "#{k}=#{v}"}.join(' ') || '(none)'
  "Hello, #{name}. Here are the parameters you gave me: #{other_params_str}\n"
end

post '/patterns/post' do
  payload =
    begin
      JSON.parse request.body.read
    rescue JSON::ParserError, TypeError
      { error: "You did not send me valid JSON" }
    end
  JSON.pretty_generate payload
end

get '/patterns/splats/*.*' do |path, ext|
  "Request Path: #{path}\nExtension: #{ext}\n"
end

# 3. Templates
get '/templates/slim' do
  slim :'demo', locals: params
end

# 4. Session and State
enable :sessions

get '/sessions/me' do
  session['count'] ||= 0
  session['count'] += 1
  "You've called me #{session['count']} times"
end

# This will keep a count of calls to this endpoint until the server is reset
anyone_call_counter = 0
get '/sessions/anyone' do
  anyone_call_counter += 1
  "I've been called #{anyone_call_counter} times\n"
end

# configs

# TL;DR - next line is required only if you're running docker.
#
# By default, Sinatra binds only to 'localhost', meaning the development web
# server will only respond to requests from the local machine. When running in
# a docker container we need to bind to '0.0.0.0' so the server will listen to
# all available interfaces, which allows us to access it from outside the
# docker development container.
set :bind, '0.0.0.0'

