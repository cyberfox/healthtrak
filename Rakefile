# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bubble-wrap'
require 'formotion'
require 'motion-cocoapods'
require 'nano-store'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Healthtrak'
  app.icons = ['Healthtrak.png']
  app.libs += ['/usr/lib/libsqlite3.dylib'] 

  # Add the pod NanoStore to your project
  app.pods do
    pod 'NanoStore', '~> 2.6.0'
  end
end
