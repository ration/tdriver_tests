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

require 'monkey.rb'

module MobyBase
  
  # Example Qt implementation of TDMonkey
  class QtTDMonkey < TDMonkey
     
    def get_log
      @_log
    end
    
    def get_script
      @_script
    end
        
    def initialize(initial_app = nil)      
      @_sut_id = "sut_qt"
                
      super(initial_app)
   
      @_verbose = true
      @_definitions = {}
      @_actions = {}         
      @_controls = {}      
      @_invalid_targets = {}
      
      # The control variables can be populated using either definitions in a class or an XML file
      #monkey_basic_data = QtFileData.new
      monkey_basic_data = QtData.new
      load_data monkey_basic_data
      
    end
    
    private
        
    def app_width
      begin
        @sut.application.MainWindow.attribute("width").to_i
      rescue 
        400
      end
    end
    
    def app_height
      begin
        @sut.application.MainWindow.attribute("height").to_i
      rescue
        300
       end
    end
    
    # Methods like this one can be used for creating random, repeat input while keeping the actual
    # action definitions compact
    def qt_monkey_random_text      
      return '"generated: " << ("random" * rand(5)) << ( "text" * rand(5))'      
    end
    
  end # QtTDMonkey

 class QtTDMonkeyCalculator < TDMonkey

    def get_log
      @_log
    end

    def get_script
      @_script
    end

    def initialize(initial_app = nil)

      @_sut_id = "sut_qt"

      super(initial_app)

      @_verbose = true
      @_definitions = {}
      @_actions = {}
      @_controls = {}
      @_invalid_targets = {}

      # The control variables can be populated using either definitions in a class or an XML file
      #monkey_basic_data = QtFileData.new
      monkey_basic_data = QtCalculatorData.new
      load_data monkey_basic_data

    end

    private

    def app_width
      begin
        @sut.application.Calculator.attribute("width").to_i
      rescue 
        200
      end
    end
    
    def app_height
      begin
        @sut.application.Calculator.attribute("height").to_i
      rescue
        200
       end
    end

    # Methods like this one can be used for creating random, repeat input while keeping the actual
    # action definitions compact
    def qt_monkey_random_text
      return '"generated: " << ("random" * rand(5)) << ( "text" * rand(5))'
    end

  end # QtTDMonkeyCalculator
    
  # This example demonstrates how control variable data can be loaded from a file.
  class QtFileData < TDMonkeyData
      
    def initialize
      
      super
      
      load_from_xml('monkey_data_example.xml')
            
    end
    
  end
  
  
  # This example demonstrates how control variable data can be defined in the TDMonkeyData data structures
  class QtData < TDMonkeyData
    
    
    def initialize
      
      super           
      
      @_add_definitions = {
        :directions => [":Left", ":Right", ":Up", ":Down"],
        :mouse_buttons => [":Left", ":Right", ":Middle", ":NoButton"]
      }
         
      
      @_add_invalid_targets = { 
                            "Control" => [ 
                              { "text" => "Quit" },
                              { "visibleOnScreen" => "false" }
                             ]
                           }
      @_templates = {
        :Qt_basics => {
          "tap" => [ 
                     'nil',
                     '"#{rand(10) + 1}, #{definition(:mouse_buttons).rnd}"'
                   ],
          "drag" => [                       
                      '"#{rand(361)}, #{rand(300)}, #{definition("mouse_buttons").rnd}"'                      
                    ],
          "flick" => [                     
                      '"#{definition("directions").rnd}, #{definition("mouse_buttons").rnd}"'
                    ],
          "gesture" => [                     
                      '"#{definition(:directions).rnd}, #{rand(5)+1}, #{rand(300)+1}, { :button => #{definition("mouse_buttons").rnd} }"'
                    ]
        }
      }
      
      @_add_actions = {
        "Node" => {
          "tap" => [ 
                     'nil',
                     '"#{rand(10) + 1}, #{definition("mouse_buttons").rnd}"'
                   ],
          "drag" => [ 
                      '":Left, 100, :Left"', 
                      '"#{definition("directions").rnd}, #{rand(300)}, #{definition("mouse_buttons").rnd}"',
                      '"#{rand(361)}, #{rand(300)}, #{definition("mouse_buttons").rnd}"'                      
                    ],
          "flick" => [                     
                      '"#{definition(:directions).rnd}, #{definition(:mouse_buttons).rnd}"'
                    ],
          "gesture" => [                     
                      '"#{definition("directions").rnd}, #{rand(5)+1}, #{rand(300)+1}, { :button => #{definition("mouse_buttons").rnd} }"'
                    ]
        },    
        "Control" => {
          "tap" => [ 
                     'nil',
                     '"#{rand(10) + 1}, #{definition("mouse_buttons").rnd}"'
                   ],
          "flick" => [                     
                      '"#{definition("directions").rnd}, #{definition("mouse_buttons").rnd}"'
                    ],
          "gesture" => [                     
                      '"#{definition(:directions).rnd}, #{rand(5)+1}, #{rand(300)+1}, { :button => #{definition("mouse_buttons").rnd} }"'
                    ]        
        },
        "ControlTab" => {
          :Qt_basics => nil, 
          "drag" => [ 
                      '":Up, 10, :Left"', 
                      '":Down, 10, :Left"'  
                    ]        
        }, 
        "Button" => {
          :Qt_basics => nil
        }
      }
    
      @_add_controls = {        
        "application.MainWindow.MainView.tap_object" => ['"#{rand(app_width).to_s}, #{rand(app_height).to_s}"']
      }
      
      @_add_invalid_targets = { 
                            "Control" => [ 
                              { "text" => "Quit" },
                              { "text" => "Crash" },
                              { "visibleOnScreen" => "false" }
                             ]
                           }
    end                
    
  end # QtData

  class QtCalculatorData < TDMonkeyData


    def initialize

      super

      @_add_definitions = {
        :directions => [":Left", ":Right", ":Up", ":Down"],
        :mouse_buttons => [":Left", ":Right", ":Middle", ":NoButton"]
      }


      @_add_invalid_targets = {}
      @_templates = {
        :Qt_basics => {
          "tap" => [
                     'nil',
                     '"#{rand(10) + 1}, #{definition(:mouse_buttons).rnd}"'
                   ],
          "drag" => [
                      '"#{rand(361)}, #{rand(300)}, #{definition("mouse_buttons").rnd}"'
                    ],
          "flick" => [
                      '"#{definition("directions").rnd}, #{definition("mouse_buttons").rnd}"'
                    ],
          "gesture" => [
                      '"#{definition(:directions).rnd}, #{rand(5)+1}, #{rand(300)+1}, { :button => #{definition("mouse_buttons").rnd} }"'
                    ]
        }
      }

      @_add_actions = {
        "Node" => {
          "tap" => [
                     'nil',
                     '"#{rand(10) + 1}, #{definition("mouse_buttons").rnd}"'
                   ],
          "drag" => [
                      '":Left, 100, :Left"',
                      '"#{definition("directions").rnd}, #{rand(300)}, #{definition("mouse_buttons").rnd}"',
                      '"#{rand(361)}, #{rand(300)}, #{definition("mouse_buttons").rnd}"'
                    ],
          "flick" => [
                      '"#{definition(:directions).rnd}, #{definition(:mouse_buttons).rnd}"'
                    ],
          "gesture" => [
                      '"#{definition("directions").rnd}, #{rand(5)+1}, #{rand(300)+1}, { :button => #{definition("mouse_buttons").rnd} }"'
                    ]
        },
        "Control" => {
          "tap" => [
                     'nil',
                     '"#{rand(10) + 1}, #{definition("mouse_buttons").rnd}"'
                   ],
          "flick" => [
                      '"#{definition("directions").rnd}, #{definition("mouse_buttons").rnd}"'
                    ],
          "gesture" => [
                      '"#{definition(:directions).rnd}, #{rand(5)+1}, #{rand(300)+1}, { :button => #{definition("mouse_buttons").rnd} }"'
                    ]
        },
        "ControlTab" => {
          :Qt_basics => nil,
          "drag" => [
                      '":Up, 10, :Left"',
                      '":Down, 10, :Left"'
                    ]
        },
        "Button" => {
          :Qt_basics => nil
        }
      }

      @_add_controls = {
        "application.Calculator.tap_object" => ['"#{rand(app_width).to_s}, #{rand(app_height).to_s}"'],
        "application.Button(:name => 'clearMemoryButton').tap_object" => ['"1, 1"'],

        }

      @_add_invalid_targets = {
                            "Control" => [
                              { "text" => "Quit" },
                              { "visibleOnScreen" => "false" }
                             ]
                           }
    end

  end # QtCalculatorData
end # MobyBase
