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

  
 class MeeGoMonkey < TDMonkey

    def get_log
      @_log
    end

    def get_script
      @_script
    end

    def initialize(initial_app = nil)

      @_sut_id = "sut_qt_maemo"

      super(initial_app)

      @_verbose = true
      @_definitions = {}
      @_actions = {}
      @_controls = {}
      @_invalid_targets = {}

      # The control variables can be populated using either definitions in a class or an XML file
      monkey_basic_data = MeeGoMonkeyData.new
      load_data monkey_basic_data

    end


    def app_width
      begin
        @sut.application.MainWindow.attribute("width").to_i
      rescue # Use N8 value as default
        640
      end

    end
    
    def app_height
      begin
        @sut.application.MainWindow.attribute("height").to_i
      rescue # Use N8 value as default
        360
      end      
    end

  end # MeeGoMonkey
  

  class MeeGoMonkeyData < TDMonkeyData

    def initialize

      super

      @_add_definitions = {
        :directions => [":Left", ":Right", ":Up", ":Down"],
        :mouse_buttons => [":Left", ":Right", ":Middle", ":NoButton"],
        :qt_keycodes => [ ":kBackspace", ":kReturn", ":kEnter", ":kLeft", ":kUp", ":kRight", ":kDown", ":kShift", ":kControl", ":kAlt", ":kMenu", ":kSpace", ":kExclam", ":kQuoteDbl", 
                          ":kDollar", ":kPercent", ":kAmpersand", ":kApostrophe", ":kParenLeft", ":kParenRight", ":kAsterisk", ":kPlus", ":kComma", ":kMinus", ":kPeriod", ":kSlash", 
                          ":k0", ":k1", ":k2", ":k3", ":k4", ":k5", ":k6", ":k7", ":k8", ":k9", ":kColon", ":kSemicolon", ":kLess", ":kEqual", ":kGreater", ":kQuestion", ":kAt", 
                          ":kA", ":kB", ":kC", ":kD", ":kE", ":kF", ":kG", ":kH", ":kI", ":kJ", ":kK", ":kL", ":kM", ":kN", ":kO", ":kP", ":kQ", ":kR", ":kS", ":kT", ":kU", ":kV", 
                          ":kW", ":kX", ":kY", ":kZ", ":kBracketLeft", ":kBackslash", ":kBracketRight", ":kAsciiCircum", ":kUnderscore", ":kQuoteLeft", ":kBraceLeft", ":kBar", 
                          ":kBraceRight", ":kAsciiTilde", ":kcent", ":ksterling", ":kyen", ":kbrokenbar", ":kdiaeresis", ":kcopyright", ":kguillemotleft", ":knotsign", ":khyphen", 
                          ":kregistered", ":kmacron", ":kdegree", ":kplusminus", ":ktwosuperior", ":kthreesuperior", ":kacute", ":kmu", ":kcedilla", ":konesuperior", ":kguillemotright", 
                          ":konequarter", ":konehalf", ":kthreequarters", ":kquestiondown", ":kAgrave", ":kAacute", ":kAcircumflex", ":kAtilde", ":kAdiaeresis", ":kAring", ":kAE", 
                          ":kCcedilla", ":kEgrave", ":kEacute", ":kEcircumflex", ":kEdiaeresis", ":kIgrave", ":kIacute", ":kIcircumflex", ":kIdiaeresis", ":kETH", ":kNtilde", ":kOgrave", 
                          ":kOacute", ":kOcircumflex", ":kOtilde", ":kOdiaeresis", ":kmultiply", ":kOoblique", ":kUgrave", ":kUacute", ":kUcircumflex", ":kUdiaeresis", ":kYacute", 
                          ":kTHORN", ":kssharp", ":kdivision", ":kydiaeresis", ":kMulti_key", ":kMode_switch", ":kDead_Grave", ":kDead_Acute", ":kDead_Circumflex", ":kDead_Tilde", 
                          ":kDead_Macron", ":kDead_Breve", ":kDead_Abovedot", ":kDead_Diaeresis", ":kDead_Abovering", ":kDead_Doubleacute", ":kDead_Caron", ":kDead_Cedilla", 
                          ":kDead_Ogonek", ":kDead_Iota", ":kDead_Voiced_Sound", ":kDead_Semivoiced_Sound", ":kDead_Belowdot", ":kDead_Hook", ":kDead_Horn", ":kVolumeDown", ":kVolumeUp"]
      }

      @_add_invalid_targets = {}
      
      @_templates = {
        :widget_lists => {
          "flick" => [                     
                      '":Up, :Left"',
                      '":Down, :Left"'
                     ]
        },
        :widget_general => {
          "tap" => [                     
                    'nil'
                   ]
        }
      }

      @_add_actions = {                
                        "MComboBox" => {
                                :widget_general => nil                  
                              }, 
                        "MContentItem" => {
                                :widget_general => nil                  
                              }, 
                      #	"MImageWidget" => {
                      #          :widget_general => nil                  
                      #        }, 
                        "GridImageWidget" => {
                                :widget_general => nil                  
                              }, 
                        "PhoneBookCell" => {
                                :widget_general => nil                  
                              }, 
                        "MApplicationMenuButton" => {
                                :widget_general => nil                  
                              }, 
                        "AnalogClock" => {
                                :widget_general => nil                  
                              },
                        "MButton" => {
                                :widget_general => nil                  
                              },
                        "ButtonGroupPage" => {
                                :widget_general => nil,
                                :widget_lists => nil                  
                              },
                        "MListItem" => {
                                :widget_general => nil,
                                :widget_lists => nil                  
                              },
                        "MDetailedListItem" => {
                                :widget_general => nil,
                                :widget_lists => nil                  
                              },
                        "MBubbleItem" => {
                                :widget_general => nil,
                                :widget_lists => nil                  
                              },
                        "DrillDownListItem" => {
                                :widget_general => nil,
                                :widget_lists => nil                  
                              },
                        "MBasicListItem" => {
                                :widget_general => nil,
                                :widget_lists => nil                  
                              },
                        "MList" => {
                                :widget_lists => nil                  
                              },
                        "MPannableViewport" => {
                                :widget_lists => nil                  
                              },
                        "SliderPage" => {
                                :widget_lists => nil                  
                              },
                        "ButtonGroupPage" => {
                                :widget_lists => nil                  
                              },
                        "MPositionIndicator" => {
                                :widget_lists => nil                  
                              }
                    }

      @_add_controls = {
        "tap_screen" => ['"#{rand(app_width).to_s}, #{rand(app_height).to_s}"'],
        "press_key" => ['"#{definition(:qt_keycodes).rnd}"'],
        "application.QGLWidget.gesture_from" => ['"#{rand(app_width)}, #{rand(app_height)}, #{(rand(4)+1)/2.0}, #{rand(200)}, #{definition(:directions).rnd}, :button => :Left"']         
      }

      @_add_invalid_targets = {
                                "MButton" => [
                                  { "text" => "Call" },
                                  { "iconID" => "icon-m-telephony-call" }
                                ]
                              }
    end

  end # MeeGoMonkeyData
end # MobyBase


