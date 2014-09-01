# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require "rubygems"
require 'bundler'
Bundler.require
require 'sugarcube-classic'
require 'sugarcube-attributedstring'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'testpro'
end
task :"build:simulator" => :"schema:build"
