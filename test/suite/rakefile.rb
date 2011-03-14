############################################################################
## 
## Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies). 
## All rights reserved. 
## Contact: Nokia Corporation (testabilitydriver@nokia.com) 
## 
## This file is part of MATTI. 
## 
## If you have questions regarding the use of this file, please contact 
## Nokia at testabilitydriver@nokia.com . 
## 
## This library is free software; you can redistribute it and/or 
## modify it under the terms of the GNU Lesser General Public 
## License version 2.1 as published by the Free Software Foundation 
## and appearing in the file LICENSE.LGPL included in the packaging 
## of this file. 
## 
############################################################################

require 'rubygems'
require 'rake/gempackagetask'


spec = Gem::Specification.new do |s| 
  s.name = "tdriver_test_suite"
  s.version = "0.0.3"
  s.author = "TDriver Developer"
  s.email = ""
  s.homepage = ""
  s.platform = Gem::Platform::RUBY
  s.summary = "TestSuite for TDriver Developers"
  s.files = FileList["tdriver_test_suite.rb"].to_a
  s.require_path = "."
  #s.autorequire = ""
  s.has_rdoc = false
  #s.extra_rdoc_files = [""]
  #s.add_dependency("dependency", ">= 0.x.x")
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  #pkg.need_tar = true 
end 

