#!/usr/bin/env ruby

require 'sinatra'

# configs

# TL;DR - next line is required only if you're running docker.
#
# By default, Sinatra binds only to 'localhost', meaning the development web
# server will only respond to requests from the local machine. When running in
# a docker container we need to bind to '0.0.0.0' so the server will listen to
# all available interfaces, which allows us to access it from outside the
# docker development container.
set :bind, '0.0.0.0'

