############################################################################
##
## Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
## All rights reserved.
## Contact: Nokia Corporation (testabilitydriver@nokia.com)
##
## This file is part of Testability Driver.
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
require 'cucumber/formatter/console'
require File.expand_path( File.join( File.dirname( __FILE__ ), 'tdriver_document_writer' ) )
module TDriverDocument
  #Class for formatting cucumber report
  class CucumberReport
    include TDriver_Document_Writer
	
    #This method initializes new test run
    #
    # === params
    # === returns
    # === raises
    def initialize(step_mother, io, options)
      #super(step_mother, io, options)      
      @options = options
      @current_feature_element = nil
      @current_feature = nil
      @tc_status=nil
      @py_string=nil
      @step_name=nil
    end
    
    def after_features(features)
      end_feature(@current_feature_element,@tc_status)
    end
    #This method visits the executed cucumber step and updates the results in to TDriver report
    #
    # === params
    # === returns
    # === raises
    def step_name(keyword, step_match, status, source_indent, background)
      @step_name=step_match.format_args(lambda{|param| "#{param}"})
      
      if status == :passed
        step_name = step_match.format_args(lambda{|param| "#{param}"})
        update_scenario("#{step_name} PASSED") if @step_name!='I execute'
        @tc_status='passed'
      end
      if status == :failed
        step_name = step_match.format_args(lambda{|param| "#{param}"})
        update_scenario("#{step_name} FAILED") if @step_name!='I execute'
        @tc_status='failed'
      end
      if status == :skipped
        step_name = step_match.format_args(lambda{|param| "#{param}"})
        update_scenario("#{step_name} SKIPPED") if @step_name!='I execute'
      end
      if status == :undefined
        step_name = step_match.format_args(lambda{|param| "#{param}"})
        update_scenario("#{step_name} NOT_RUN") if @step_name!='I execute'
        @tc_status='not run'
      end
    end		
    #This method visits the exception caused by a failed step
    #and updates the result in to TDriver report
    #
    # === params
    # === returns
    # === raises
    def exception(exception, status)
      if status == :failed        
        update_scenario_exception("#{exception.message} #{exception.class} #{exception.backtrace}")
      end      
    end
    #This method visits cucumber scenario name and starts a new test case when
    #new scenario is executed
    #and updates the result in to TDriver report
    #
    # === params
    # === returns
    # === raises
    def scenario_name(keyword, name, file_colon_line, source_indent)
      visit_feature_element_name(keyword, name, file_colon_line, source_indent)
    end

    def feature_name(keyword,name)
      start_feature(keyword,name,@feature_file)
    end
    #This method determines when new test case needs to be started
    #based on the scenario name info if scenario name is different then a new test case
    #is started
    #
    # === params
    # === returns
    # === raises
    def visit_feature_element_name(keyword, name, file_colon_line, source_indent)
      line = %Q("#{name}")
      @current_feature_element=line if @current_feature_element.nil?
      unless line == @current_feature_element
        end_scenario(@current_feature_element,@tc_status)
        @current_feature_element=line
      end
      start_scenario(keyword, name, file_colon_line, source_indent)
      @tc_status=nil
    end
    #This method records the cucumber outline table results in to one test case
    #
    # === params
    # === returns
    # === raises
    def before_outline_table(outline_table)
      update_scenario("running outline: ")
    end
    #This method records the cucumber outline table results in to one test case
    #
    # === params
    # === returns
    # === raises
    def after_table_row(table_row)
      if table_row.exception
        @tc_status='failed'
        capture_screen_test_case()
        update_scenario("#{format_table_row(table_row)} FAILED")
        update_scenario(table_row.exception)
      else
        @tc_status='passed' if @tc_status==nil
        update_scenario("#{format_table_row(table_row)} PASSED")
      end
    end
    def format_table_row(row)
      begin
        [row.name, row.line]
      rescue Exception => e
        row
      end
    end
    def tag_name(tag_name)
    end
    def comment_line(comment_line)
      update_scenario(comment_line)
    end
    def after_tags(tags)
    end
    def after_feature_element(feature_element)      
    end
    def after_background(background)
    end
    def before_examples_array(examples_array)
    end
    def examples_name(keyword, name)
    end
    def py_string(string)
	    details="#{@step_name} \"#{string}\" #{@tc_status.upcase}"
      update_scenario(details)
    end
    def before_feature(feature)
      @feature_file=feature.file
    end
    def print_feature_element_name(keyword, name, file_colon_line, source_indent)
      start_scenario(keyword, name, file_colon_line, source_indent)
    end

    def before_table_row(table_row)
      return unless @table
      @col_index = 0
    end
    def table_cell_value(value, status)
      return unless @table
      status ||= @status || :passed
    end
  end
end

