############################################################################
## 
## Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies). 
## All rights reserved. 
## Contact: Nokia Corporation (testabilitydriver@nokia.com) 
## 
## This file is part of TDriver. 
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


class ImedoCiFormatter < Cucumber::Ast::Visitor

  def initialize(step_mother, io, options)
    super(step_mother)
    @io = io
    @options = options
    @errors             = []
    @passed_scenarios   = []
    @failed_scenarios   = []
    @pending_scenarios  = []
    @current_feature_name = ""
    @current_scenario_name = ""
    @empty_scenario = false
  end

  def visit_features(features)
    super
    print_summary
  end
  
  def visit_feature_name(name)
    s = name.split("\n").first.gsub(/^(Feature|Story):[ ]*/, '')
    @current_feature_name = s
    @io.print "\n#{@current_feature_name}\t"
  end
      
  def visit_feature_element(feature_element)
    super
    if feature_element.failed?
      @failed_scenarios << "#{@current_feature_name}: #{@current_scenario_name}"
      @errors << feature_element.exception
      @io.print "F"
    elsif feature_element.passed? and not @empty_scenario
      @passed_scenarios << "#{@current_feature_name}: #{@current_scenario_name}"
      @io.print "."
    else
      @pending_scenarios <<"#{@current_feature_name}: #{@current_scenario_name}"
      @io.print "P"
    end  
  end

  def visit_scenario_name(keyword, name, file_colon_line, source_indent)
    visit_feature_element_name(keyword, name, file_colon_line, source_indent)
  end

  def visit_feature_element_name(keyword, name, file_colon_line, source_indent)
    @current_scenario_name = name
  end
  
  def visit_steps(steps)
    super
    @empty_scenario = steps.empty?
  end

  def print_summary
    @io.puts
    @io.puts "\nPending Scenarios:\n\n" if @pending_scenarios.any?
    @pending_scenarios.uniq.each_with_index do |scenario_string, n|
      @io.puts "#{n+1}) #{scenario_string}"
    end
    @io.puts "\nFailed:" if @errors.any?
    @errors.each_with_index do |error,n|
      @io.puts
      @io.puts "#{n+1}) #{error.message}"
      @io.puts error.backtrace.join("\n")
    end
    @io.puts
    if @passed_scenarios.any?
      @io.puts "#{@passed_scenarios.length} scenarios passed"
    end
    if @failed_scenarios.any?
      @io.puts "#{@failed_scenarios.length} scenarios failed"
    end
    if @pending_scenarios.any?
      @io.puts "#{@pending_scenarios.length} scenarios pending"
    end
  end
end
