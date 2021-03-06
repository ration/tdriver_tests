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

require 'tdriver'

class Array  
  def random_element    
      return self[rand(self.size)]      
  end  
  
  def rnd    
      return self[rand(self.size)]      
  end
  
end

module MobyBase

  # Monkey tester main class. Contains algorithms for choosing targets and actions, as well as reporting.
  # Actual test classes must inherit this class and populate the control instance variables with values suitable
  # for the SUT.
  class TDMonkey
    
    # Creates a new TDMonkey and initializes it. The new object is connected to the sut, also if an application is
    # given that application is launched
    # 
    # === params
    # target_app:: (optional) String, this application is launched during initialization. If the app is closed during 
    #              testing, TDMonkey will start it again
    def initialize(target_app = nil)
      
      Kernel::raise ArgumentError.new "A sut type must be defined (non empty String)" unless @_sut_id.kind_of? String and !@_sut_id.empty?
      #Kernel::raise ArgumentError.new "The provided target application was not a non empty String." unless target_app.nil? or (target_app.kind_of? String and !target_app.nil?)
   
      # Control instance variables. 
      # These must be populated by subclasses of TDMonkey
      # All values that are to be executed must be given as Strings, as they are processed with eval at runtime

      # Define value groups (enumerations) that can be used in action definitions etc.
      # Example: Key - :mouse_buttons, value - [":Right", ":Left"]
      # Key - Symbol - definition set name
      # Value - Array - values of this set    
      @_definitions = {}      
      
      # Permitted target objects and actions that can be performed on them
      # 1st level - Hash 
      #   Key - String - object type (eg. "Button")
      #   Value - Hash - Actions and their argument choices (eg. {"tap" => ["argument_set1", "argument_set2"]})
      #     2nd level - Hash
      #       Key - String - action name (eg. "flick")
      #       Value - Array - argument choices (eg. [":Left, :Left", ":Right, :noButton"])
      #         3rd level - Array - argument choices (see above)
      @_actions = {}
      
      # Methods for interacting directly with the SUT, ie. regardless of the state. Controls can e.g. 
      # include input via keys or touch, or some other functionality provided directly by the SUT
      # 1st level - Hash 
      #   Key - String - control name (eg. "type_text")
      #   Value - Array - argument choices (eg. ["Text1", "Longer Text"])
      #     2nd level - Array - argument choicese (see above)
      @_controls = {}
      
      # These objects cannot be the target of any TDMonkey actions (however, as controls are not sensitive 
      # to state those might still trigger objects defined here)
      # 1st level - Hash
      #   Key - String - object type (eg. Softkey)
      #   Value - Array - attribute combinations that are not permitted
      #     2nd level - Array - each item contains a Hash with attrobute type - value pairs that define a blocked object 
      #                         Example: [{"Text" => "Exit", "Visible" => "True"}, {"Text" => "Call"}]
      #       3rd level - Hash
      #         Key - String - Type of attribute used for blocking (see above for example)
      #         Value - String  - Blocked value
      @_invalid_targets = {}
      
      # Conditional triggers. These perform any user specified actions or code when the trigger condition is met
      # 1st levl - Hash
      #   Key - String - Triggering Object type
      #   Value - Hash - Trigger configuration
      #     Key - Symbol - Can be either 
      #       :macro - Code to be executed if the trigger is applied
      #       :xpath - The condition is detected using a custom xpath executed as provided, any match will trigger the condition
      #       :attributes - Array - Contains Hashes whith attribute name and value combinations. The condition triggers if any of the Hash conditions is met.
      #         Key - String - Name of the attribute
      #         Value - String - Value of the attribute
      @_triggers = []

      # Filter for object parents
      # 1st level - Hash
      #   Key - String - Object type that is limeted based on parents
      #   Value - Hash 
      #     Key - String - Type of limiting parent object
      #     Value - Hash
      #       Key - String - Type of parent attribute that is checked
      #       Value - String Array - List of attribute values which block the object if any of them match
      @_limited_objects = {}
      
      
      @_custom_states = []
      
      # Test object types can be weighted to make them more likely to be selected when objects are randomly chosen by the monkey.
      # The default value of this Hash is also the default weight of objects and should be 1.0 unless circumstances require otherwise.
      # Example: { "softkey" => 0.5, "list_item" => 2 }
      @_object_weights = Hash.new( 1.0 )
            
      puts "Initializing TDMonkey for SUT: " << @_sut_id.to_s
      
      # These are used if execution data is to be collected in TDMonkey
      #@_log = ""
      #@_script = ""
      
      # Testing can be limited to an application using this variable
      @_app = target_app
      @_app = [ target_app ] if target_app.kind_of? String
      # setting this to true will cause TDMonkey to print all performed actions
      @_verbose = false
      write_log( "Initializing TDMonkey, sut id: " << @_sut_id.to_s ) 
      
      @sut = TDriver.sut(:Id => @_sut_id)
	    write_script( "require 'tdriver'")
      write_script( "@sut = TDriver.sut(:Id => '#{@_sut_id}')")
      
      if !@_app.nil?
        write_log( "TDMonkey target application: " << @_app[ 0 ] ) 
        @sut.run( :name => @_app[ 0 ], :arguments => '-testability' )
        write_script( "@sut.run(:name => '#{@_app[ 0 ]}', :arguments => '-testability')")
      end

    end
    
    # Simple monkey: apply random control action to the SUT, eg. touch a random spot
    def gorilla   
    
      check_triggers
      
      random_control = controls.keys.random_element
      random_variant = rand( controls[ random_control ].size )
      random_attributes = control( random_control, random_variant )
      
      if !random_attributes.nil?
        random_control += "(" << random_attributes.to_s << ")"
      end
         
      puts("Control: " + random_control) if @_verbose
      
      write_log( "Control activated: #{random_control}" )      
       
      begin
        @sut.instance_eval(random_control)
        write_script( "@sut.#{random_control}" )
      rescue Exception => e
        write_log( "Encountered gorilla error: " << e.class.to_s )
        write_script( "@sut.#{random_control} # This action failed due to a #{e.class.to_s}" )
        raise e
      end

      digest
      
    end

    
    # Smart monkey: perfoms a random action on a random available UI object
    def chimp
     
      digest
      @sut.refresh # refresh before checking the sut for targets
      
      5.times do
        break unless check_triggers
        @sut.refresh # refresh again if a trigger was activated        
      end
      
      # check custom states      
      default_state = nil
      default_lo = nil
      custom_state = check_states
      unless custom_state == false
        default_state = @_actions
        default_lo = @_limited_objects
        @_actions = custom_state
        @_limited_objects = {}
      end      
      
      target = random_target
      action = random_action(target.type)
      
      t_name = nil
      begin
        t_name = target.attribute("objectName")
      rescue
      end
      
      t_text = nil
      begin
        t_text = target.attribute("text")
      rescue
      end
      
      script_id = "(:id => '#{target.id}')"
      if t_text != nil and t_text.to_s != ""
        script_id = "(:text => '#{t_text}')"
      end
      
      if t_name != nil and t_name.to_s != ""
        script_id = "(:objectName => '#{t_name}')"
      end
      
      puts( "Target: " + target.type + ":" + script_id.to_s + " Action: " + action ) if @_verbose
	  
      write_log( "Action performed. Target: #{target.type}#{script_id} Action: #{action}" )
       
      begin
        target.instance_eval(action)
        write_script( "@sut.application.#{target.type}#{script_id}.#{action}" )
      rescue Exception => e
        write_log( "Encountered chimp error: " << e.class.to_s )
        write_script( "@sut.application.#{target.type}#{script_id}.#{action} # This action failed due to a #{e.class.to_s}" )
        raise e
      ensure
        unless default_state.nil?
          @_actions = default_state
          @_limited_objects = default_lo
        end
      end
        
      #digest
      
      # TODO: call oracle here
     
    end
    
    # Use a TDMonkeyData object to populate the control variables of this object.
    # Multiple objects can be loaded, depending on how these objects are defined data will
    # either be merger or overwritten. Thus a more generic data object can be loaded first followed
    # by application and test specific ones.
    #
    # === params
    # data_object:: TDMonkeyData object containing control data for populating the control variables of 
    #               this object
    def load_data( data_object )
     
      raise ArgumentError.new( "The TDMonkey data object was not of class TDMonkeyData, it was of class \"#{data_object.class.to_s}\"" ) unless data_object.kind_of?( TDMonkeyData )
      
      # load definitions, merge if definition set already exists  
      data_object.definitions_to_add.each do | def_name, def_value |      
        if @_definitions.key?( def_name )
          @_definitions[def_name] |= def_value
        else
          @_definitions[def_name] = def_value
        end
      end
      
      data_object.definitions_to_replace.each do | def_name, def_value |
          @_definitions[def_name] = def_value
      end
      
      # load actions, merge if action argument set already exists  
      data_object.actions_to_add.each do | target_type, target_actions |      
        if @_actions.key?( target_type )
          
          target_actions.each do | action_type, action_args |            
            if (@_actions[ target_type ].key?( action_type )) && !action_type.kind_of?(Symbol)
              @_actions[target_type][action_type] |= action_args
            else
              @_actions[target_type][action_type] = action_args  
            end          
          end        
        
        else
          @_actions[target_type] = target_actions
        end
      end
      
      # replace actions
      data_object.actions_to_replace.each do | target_type, target_actions |
        @_actions[target_type] = target_actions
      end
      
      # populate using templates
      templates_found = false
      begin
        templates_found = false
        @_actions.each do | target_type, target_actions |
          
          target_actions.each do | action_type, action_args |
            if action_type.kind_of? Symbol
              templates_found = true
              template_actions = data_object.templates[action_type]
          
              if template_actions.kind_of? Hash
                
                template_actions.each do | template_action, template_args |
                  if @_actions[ target_type ].key?(template_action) && template_action.kind_of?(Symbol)
                    @_actions[ target_type ][ template_action ] |= template_args
                  else
                    @_actions[target_type][template_action] = template_args  
                  end               
                end
                
                target_actions.delete( action_type )
                
              end              
            end          
          end
        end
      end while templates_found # continue while some templates are found

      
      # load controls, merge if control argument set already exists  
      data_object.controls_to_add.each do | control_type, control_args |      
        if @_controls.key?( control_type )
          
          @_controls[control_type] |= control_args       
         
        else
          @_controls[control_type] = control_args
        end
      end
      
      data_object.controls_to_replace.each do | control_type, control_args |
          @_controls[control_type] = control_args
      end
      
      # load blocked objects   
      data_object.invalid_targets_to_add.each do | target_type,  target_args |      
        if @_invalid_targets.key?( target_type )
          
          @_invalid_targets[target_type] |= target_args       
         
        else
          @_invalid_targets[target_type] = target_args
        end
      end
      
      # load blocked objects   
      data_object.invalid_targets_to_replace.each do | target_type,  target_args |      
        @_invalid_targets[target_type] = target_args
      end       
      
      # load triggers
      if data_object.triggers_to_replace.empty?
        @_triggers += data_object.triggers_to_add
      else
        @_triggers = data_object.triggers_to_replace
      end
          
      # load parent filter      
      data_object.limited_objects_to_add.each do | limited_type, parent_type |      
        if @_limited_objects.key?( limited_type )
          
          @_limited_objects[limited_type] = parent_type.merge @_limited_objects[limited_type]       
         
        else

          @_limited_objects[limited_type] = parent_type
        end
      end
      
      data_object.limited_objects_to_replace.each do | limited_type,  parent_type |      
        @_limited_objects[limited_type] = parent_type
      end
      
      # load weights
      data_object.weights_to_add.each do | object_type, object_weight |
         @_object_weights[ object_type ] = object_weight       
      end
      
      # load custom states
      @_custom_states = data_object.custom_states_to_add
      
      # populate custom states using templates
      @_custom_states.each do | custom_state |
        templates_found = false
        begin
          templates_found = false
          custom_state[ :actions ].each do | target_type, target_actions |
            
            target_actions.each do | action_type, action_args |
              if action_type.kind_of? Symbol
                templates_found = true
                template_actions = data_object.templates[action_type]
            
                if template_actions.kind_of? Hash
                  
                  template_actions.each do | template_action, template_args |
                    if @_actions[ target_type ].key?(template_action) && template_action.kind_of?(Symbol)
                      @_actions[ target_type ][ template_action ] |= template_args
                    else
                      @_actions[target_type][template_action] = template_args  
                    end               
                  end
                  
                  target_actions.delete( action_type )
                  
                end              
              end          
            end
          end
        end while templates_found # continue while some templates are found
      end # each custom_state
    
    end
        
    private
  
    # these members must be populated in the constructors of classes inheriting TDMonkey
    
    # oracle methods for actions, not implemented yet
    @_oracle = {}
    
    # chooses a random accessible test object from those available on the sut
    def random_target
     
      non_limited = actions.keys - @_limited_objects.keys

      targets_xpath = '*//obj[@type="' << non_limited.join("\" or @type=\"")  << '"'
      limited_targets = ""
      
      @_limited_objects.each do | limited_object, parent_types |
            
        limited_targets << ' or (@type="' + limited_object + '" and not('        
        limiting_parents = ""
        
        parent_types.each do | parent_type, parent_attributes |
          
          parent_attributes.each do | parent_attribute, parent_values |
          
            parent_values.each do | parent_value |
              limiting_parents << ' or ' unless limiting_parents.empty?
              limiting_parents << 'ancestor::obj[@type="' + parent_type + '" and attr[@name="' + parent_attribute + '" and text()="' + parent_value + '"]]'
            end
          
          end
        
        end
        
        limited_targets << limiting_parents
        limited_targets << '))'
      
      end
                 
      targets_xpath << limited_targets
      targets_xpath << ']'
  
      target_node_set = @sut.xml_data.xpath(targets_xpath)
      
      # retry once
      if target_node_set.empty?
        @sut.refresh
        target_node_set = @sut.xml_data.xpath(targets_xpath)        
      end
      
      Kernel::raise(TDMonkeyNoTargetsError.new("No test objects found matching allowed target types.")) if target_node_set.empty?
 
      target_nodes = target_node_set.to_a
      target_node_set = nil
      
      weighted_nodes = {}

      weight_total = 0.0

      target_nodes.each do | target_node |
      
        
        #change to add on target_node type
        weight_total += weighted_nodes[ target_node ] = @_object_weights[ target_node.attribute( "type" ) ]

      end
              
      while !weighted_nodes.empty? do
        
        weighted_rand = rand*weight_total

        weighted_nodes_keys = weighted_nodes.keys
 
        weighted_nodes_index = 0
        weight_sum = weighted_nodes[ weighted_nodes_keys[ weighted_nodes_index ] ]

        while weighted_rand > weight_sum and weighted_nodes_index+1 < weighted_nodes_keys.length

          weighted_nodes_index += 1  
          weight_sum += weighted_nodes[ weighted_nodes_keys[ weighted_nodes_index ] ]

        end
   
        #target_node = target_nodes.delete_at(rand(target_nodes.length.to_i))
        target_node = weighted_nodes_keys[ weighted_nodes_index ]
        target_type = target_node.attribute( "type" )
        target_id = target_node.attribute( "id" )      
        
        candidate = nil
       
        begin
        
          begin
            if target_type == "application"
              candidate = @sut.application({ :id => target_id, :name => target_node.attribute("name"), :__timeout => 0 })
            else
              candidate = @sut.application.child({ :type => target_type, :id => target_id, :__timeout => 0 })
            end
          rescue MultipleTestObjectsIdentifiedError
            write_log( "TDMonkey failed to get an object due to multiple matching objects ( Type : #{target_type}) Id: #{target_id} )" )            
            if target_type == "application"
              candidate = @sut.application({ :id => target_id, :name => target_node.attribute("name"), :__index => 0 })
            else
              candidate = @sut.application.child({ :type => target_type, :id => target_id, :__timeout => 0, :__index => 0 })
            end
          end
          return candidate if valid_target?( candidate )
          # else retry
          
        rescue TestObjectNotFoundError, TestObjectNotVisibleError, MultipleTestObjectsIdentifiedError => eee
          # retry if array has nodes left
        end
      
        # delete the node        
        weight_total -= weighted_nodes.delete( weighted_nodes_keys[ weighted_nodes_index ] )         
        
      end # while
      
      Kernel::raise(TDMonkeyNoTargetsError.new("No test object could be created matching allowed target types."))
     
    end
    
    # chooses a random action that can be performed on a test object of the given type
    def random_action(target)
   
      valid_actions = actions.fetch(target) { Kernel::raise(RuntimeError.new("No actions found for object type '#{target}'."))}

      Kernel::raise(TDMonkeyNoActionsError.new("No actions found for object type '#{target}'.")) if valid_actions.empty?

      chosen_action = valid_actions.keys.random_element   
      chosen_var = rand(valid_actions[chosen_action].size)     
      chosen_arguments = action(target, chosen_action, chosen_var)
      
      if (!chosen_arguments.nil? && !chosen_arguments != "")
        chosen_action += ("(" + chosen_arguments + ")")        
      end
            
      return chosen_action
      
    end
    
    # Check if the test object is a valid target
    def valid_target? ( test_object, action = nil )
            
      # Check if the test object matches an entry on the list of invalid targets 
      @_invalid_targets.keys.each do | invalid_type |
                
      if test_object.type == invalid_type
        
        # Check if all attributes match         
          
        set_matched = false
        @_invalid_targets[ invalid_type ].each { | set |          
        
          all_matched = true
           
          set.each { | blocking_limit, value |           
          
            blocking_operator = "="
            
            blocking_attribute, blocking_operator = *blocking_limit
            blocking_operator = "=" if blocking_operator.nil?
                        
            begin
              case blocking_operator
              when ">"
                all_matched = false if test_object.attribute(blocking_attribute).to_i <= value.to_i
              when ">="
                all_matched = false if test_object.attribute(blocking_attribute).to_i < value.to_i
              when "<"
                all_matched = false if test_object.attribute(blocking_attribute).to_i >= value.to_i
              when "<="
                all_matched = false if test_object.attribute(blocking_attribute).to_i > value.to_i              
              else
                all_matched = false if test_object.attribute(blocking_attribute) != value
              end
            rescue Exception => e	
              all_matched = false
            end
            
          }
          
          if all_matched
            set_matched = true
          end
            
        }
		  
        return false if set_matched 
          
        end
        
      end

      return true
    
    end
	
    def check_triggers    
      
      return false if @_triggers.empty? 
      
      @_triggers.each do | trigger |     

        xpaths = []
        xpaths << trigger[ :condition ] if trigger[ :condition ].kind_of? String
                
        if xpaths.empty?
        
          trigger[ :condition ].each do | trigger_object_type, trigger_object_attributes |
        
            objects_xpath = '*//obj['     
            objects_xpath << '@type="' << trigger_object_type << '"'
            attributes_xpath = ''
            trigger_object_attributes.each do | attribute_type, attribute_values |
            
              attributes_xpath << ' and attr[@name="' << attribute_type << '" and (('

              values_xpath = ''
              attribute_values.each do | attribute_value |
                values_xpath << ') or (' unless values_xpath.empty?
                values_xpath << 'text()="' << attribute_value << '"'
              end # each attribute_value
              values_xpath << ')' unless values_xpath.empty?
                
              attributes_xpath << values_xpath << ')]'
              
            end # each attribute_type, attribute_values
            objects_xpath << attributes_xpath << "]"            
            xpaths << objects_xpath
          end # each trigger_object_type, trigger_object_attributes

        end # search_xpath.nil?

        matching_xpaths = 0
        
        xpaths.each do | trigger_xpath |
          # check each xpath to see if this trigger applies      
          matching_xpaths += 1 unless @sut.xml_data.xpath( trigger_xpath ).empty?                       
        end # each trigger_xpath

        if matching_xpaths >= xpaths.size and matching_xpaths > 0
        
            # execute trigger
            puts( "Trigger matched, executing macro: " << trigger[ :macro ].to_s ) if @_verbose

            begin
              
              eval(trigger[ :macro ].to_s)
              write_log( "Executing trigger: " << trigger[ :macro ].to_s )
              write_script( trigger[ :macro ].to_s )
                          
            rescue Exception => e
              raise TDMonkeyError.new("Error executing macro: " << trigger[ :macro ].to_s << ".\nDetails: " << e.inspect << "\n" << e.backtrace.join( "\n" ))
            end
            
            # report trigger match, stop checking for further triggers
            return true

        end # if matching_xpaths >= xpaths.size

      end # each trigger
      
      return false # no matching trigger      

    end	
    
    def check_states 
     
      return false if @_custom_states.empty? 
      
      @_custom_states.each do | state |     

        xpaths = []
                      
        if xpaths.empty?
        
          state[ :condition ].each do | state_object_type, state_object_attributes |
        
            objects_xpath = '*//obj['     
            objects_xpath << '@type="' << state_object_type << '"'
            attributes_xpath = ''
            state_object_attributes.each do | attribute_type, attribute_values |
           
              attributes_xpath << ' and attr[@name="' << attribute_type << '" and (('

              values_xpath = ''
              attribute_values.each do | attribute_value |
                values_xpath << ') or (' unless values_xpath.empty?
                values_xpath << 'text()="' << attribute_value << '"'
              end # each attribute_value
              values_xpath << ')' unless values_xpath.empty?
                
              attributes_xpath << values_xpath << ')]'              
              
            end # each attribute_type, attribute_values
            objects_xpath << attributes_xpath << "]"            
            xpaths << objects_xpath
          end # each state_object_type, state_object_attributes

        end # search_xpath.nil?

        matching_xpaths = 0

        xpaths.each do | state_xpath |
          # check each xpath to see if this state applies      
          matching_xpaths += 1 unless @sut.xml_data.xpath( state_xpath ).empty?                       
        end # each trigger_xpath

        if matching_xpaths >= xpaths.size and matching_xpaths > 0
        
            # state matched
            puts( "Custom state matched" ) if @_verbose
            return state[ :actions ]
        
        end # if matching_xpaths >= xpaths.size

      end # each state
      
      return false # no matching state

    end	
        
    # width of the sut display
    def app_width
      Kernel::raise RuntimeError.new "TDMonkey#app_width is a pure virtual method, no implementation was defined."
    end
    
    # height of the sut display
    def app_height
      Kernel::raise RuntimeError.new "TDMonkey#app_height is a pure virtual method, no implementation was defined."
    end
    
    # finishes the action, satisfying synchronization requirements and checking that target application limits are maintained
    def digest  

      # Check if the target application must be restarted 
      if @_app != nil
      
        @sut.refresh
        @sut.freeze
              
        app_found = false
        
        begin
          @_app.each do | app_name |
            begin
              
              @sut.application(:FullName => app_name, :__timeout => 0 )
              app_found = true
              break
              
            rescue TestObjectNotFoundError        
            end
          end
        rescue Exceptino => e
          raise e
        ensure
          @sut.unfreeze
        end
        
        if !app_found
        
          begin
          
            @sut.application(:FullName => @_app[ 0 ], :__timeout => 0 ).bring_to_foreground

          rescue
          
            begin
              write_log( "Restarting target application: " << @_app[ 0 ] )
              write_script( "@sut.run(:name => '#{@_app[ 0 ]}', :arguments => '-testability')" )
        
              @_fg_app = @sut.run(:name => @_app[ 0 ], :arguments => '-testability')
            rescue
              write_log( "Failed to restart target application." )
              raise TDMonkeyNoApplicationError.new("Failed to start application #{ @_app[ 0 ] }.")
            end # rescue run          
          end # rescue bring_to_foreground     
        end # if !app_found
      end  # if @_app != nil

    end
    
    # Adds a message to the (human readable, timestamped) log
    def write_log( message )
            
      File.open('m_log.txt', "a") do |l_file|      
        l_file << "\n" << Time.now.to_s << ": " << message
      end
      
    end
    
    # Adds a line to the script log. This log can be used to recreate the TDMonkey test session
    def write_script( action )
  
      File.open('m_script.txt', "a") do |s_file|      
        s_file << "\n" << action         
      end
      
    end
    
    # Access to definition sets
    #
    # === params
    # key:: Symbol or String, name of definition set
    def definition(key)     
      @_definitions[key.to_sym]      
    end
     
    # Access to action root 
    def actions
      @_actions
    end
    
    # Fetch and evaluate an action, resolving any random elements that are to be set at runtime
    # Example: action("Node", "flick", 0)
    #
    # === params
    # target_type:: String, object type (eg. "Button")
    # action:: String, action name (eg. "tap")
    # variant:: Integer, index of argument variation to use
    # === returns
    # String:: evaluated complete action, ready to be called    
    def action(target_type, action, variant)
      return eval(@_actions[target_type][action][variant])
    end
    
     # Access to control root 
    def controls
      @_controls
    end
    
    # Fetch and evaluate a control, resolving any random elements that are to be set at runtime
    # Example: control("type_texte", 0)
    #
    # === params
    # name:: String, type of control(eg. "type_text")
    # variant:: Integer, index of argument variation to use
    # === returns
    # String:: evaluated complete control, ready to be called    
    def control(name, variant)
      return eval(@_controls[name][variant])
    end
    
  end # TDMonkey
  
  # TDMonkeyError is the superclass of all TDMonkey specific errors
  class TDMonkeyError < StandardError    
  end
  
  class TDMonkeyNoApplicationError < TDMonkeyError    
  end
  
  class TDMonkeyNoActionsError < TDMonkeyError
  end
  
  class TDMonkeyNoTargetsError < TDMonkeyError
  end

  class TDMonkeyXmlDataParseError < TDMonkeyError
  end
      
  # Classes that are used to populate control variables must inherit TDMonkeyData. 
  class TDMonkeyData
        
    def initialize
      
      # Variables containing control data. Any starting with _add_ are merged to data priviously existing
      # in a TDMonkey object, data in _replace_ structures replaces any data that is affected by data stored
      # in the structure. 
      @_add_definitions = {}
      @_replace_definitions = {}
      @_templates = {}
      @_add_actions = {}
      @_replace_actions = {}
      @_add_controls = {}
      @_replace_controls = {}
      @_add_invalid_targets = {}
      @_replace_invalid_targets = {}
      @_add_triggers = {}
      @_replace_triggers = {}
      @_add_limited_objects = {}
      @_replace_limited_objects = {}
      @_add_custom_states = []
      @_add_weights = {}
      
    end         
  
    def definitions_to_add      
      @_add_definitions
    end
    
    def definitions_to_replace
      @_replace_definitions
    end 
    
    def templates
      @_templates
    end
    
    def actions_to_add
      @_add_actions
    end
    
    def actions_to_replace
      @_replace_actions
    end
    
    def controls_to_add
      @_add_controls
    end
      
    def controls_to_replace
      @_replace_controls
    end
    
    def invalid_targets_to_add
      @_add_invalid_targets
    end
    
     def invalid_targets_to_replace
      @_replace_invalid_targets
    end
  
    def triggers_to_add
      @_add_triggers
    end
  
    def triggers_to_replace
      @_replace_triggers
    end
  
    def limited_objects_to_add
      @_add_limited_objects
    end
    
    def limited_objects_to_replace
      @_replace_limited_objects
    end
  
    def triggers_to_add
      @_add_triggers
    end
    
    def triggers_to_replace
      @_replace_triggers
    end
    
    def custom_states_to_add
      @_add_custom_states
    end
    
    def weights_to_add
      @_add_weights
    end
    
    # Loads control variable content from a XML file. Note that a single TDMonkeyData class can only contain data
    # from one source.
    def load_from_xml( file_path )
      
      # clear any previous data
      @_add_definitions = {}
      @_replace_definitions = {}
      @_templates = {}
      @_add_actions = {}
      @_replace_actions = {}
      @_add_controls = {}
      @_replace_controls = {}
      @_add_invalid_targets = {}
      @_replace_invalid_targets = {}  
      @_add_triggers = {}
      @_replace_triggers = {}
      @_add_limited_objects = {}
      @_replace_limited_objects = {}
      @_add_triggers = []
      @_replace_triggers = []
      @_add_custom_states = []
      @_add_weights = {}
      
      doc = MobyUtil::XML.parse_file( file_path )

      #go through each node type
      target_nodes = doc.root.xpath("targets/target")
      target_nodes.each do | target_node |
        
        target_name = target_node.attribute("name")
        raise TDMonkeyXmlDataParseError.new("Target node with no name encountered.") if target_name.nil?
      
        target_weight = target_node.attribute("weight")
        
        unless target_weight.nil?          
          @_add_weights[ target_name ] = target_weight.to_f          
        end
        
        replace_target = (target_node.attribute("replace").to_s.downcase == "true")
              
        # add actions
        target_node.xpath("actions/action").each do | action_node |
          action_name = action_node.attribute("name")
          raise TDMonkeyXmlDataParseError.new("The node '#{target_name}' has an action with a missing name attribute.") if action_name.nil?
      
          action_node.xpath("argument").each do | argument_node |
      
            argument_string = argument_node.attribute("value")
            
            target_hash = nil
            if replace_target
              target_hash = @_replace_actions
            else
              target_hash = @_add_actions
            end
            
            if target_hash.key?(target_name)
              if target_hash[target_name].key?(action_name)
                target_hash[target_name][action_name] |= [argument_string]
              else
                target_hash[target_name][action_name] = [argument_string]
              end
            else
              target_hash[target_name] = {action_name => [argument_string]}
            end  

          end
        end        
      
        # add templates to target object
        target_node.xpath("actions/include").each do | template_node |
          
          template_name = template_node.attribute("name") 
          raise TDMonkeyXmlDataParseError.new("The node '#{target_name}' has an include with a missing name attribute.") if template_name.nil?
                    
          target_hash = nil
          if replace_target
            target_hash = @_replace_actions
          else
            target_hash = @_add_actions
          end
        
          if target_hash.key? target_name
            target_hash[target_name].merge!({template_name.to_sym => nil})
          else
            target_hash[target_name] = {template_name.to_sym => nil}
          end
          

        end        
     
        # add blocking attributes

        blocking_set = []
        target_node.xpath("blocking-attributes/set").each do | arg_set |
        
          block_arguments = {}
          arg_set.xpath("attribute").each do | attribute_node |
            attribute_name = attribute_node.attribute("name")           
            attribute_condition = attribute_node.attribute("condition")
            attribute_value = attribute_node.attribute("value")
            raise TDMonkeyXmlDataParseError.new("The target '#{target_name}' has an a set of blocking attributes with a missing name-value attribute pair.") if (attribute_name.nil? || attribute_value.nil?)
            attribute_key = [ attribute_name ]
            attribute_key << attribute_condition unless attribute_condition.nil?
            block_arguments[ attribute_key ] = attribute_value 
          end
          
          blocking_set << block_arguments
          
        end # blocking-attributes/set
        
        # merge loaded blocking attributes into data structure
        target_hash = nil
        if replace_target
          target_hash = @_replace_invalid_targets
        else
          target_hash = @_add_invalid_targets
        end
        
        if target_hash.key?(target_name)
          target_hash[target_name] << blocking_set
        else
          target_hash[target_name] = blocking_set
        end
                
        # add blocking parents
        blocking_parents = {}
        target_node.xpath("blocking-parents/blocking-parent").each do | blocking_parent |
                  
          parent_name = blocking_parent.attribute("name")           
         
          blocking_attributes = {}
          blocking_parent.xpath("attribute").each do | attribute_node |
            attribute_name = attribute_node.attribute("name")           
            attribute_value = attribute_node.attribute("value")
            raise TDMonkeyXmlDataParseError.new("The target '#{target_name}' has an a blocking parent (#{parent_name}) with a missing name-value attribute pair.") if (attribute_name.nil? || attribute_value.nil?)
            if blocking_attributes[attribute_name].nil?
              blocking_attributes[attribute_name] = [ attribute_value ]
            else          
              blocking_attributes[attribute_name] << attribute_value
            end
          end     
          
          blocking_parents[ parent_name ] = blocking_attributes
          
        end # blocking-parents/blocking-parent
        
        unless blocking_parents.empty?
          # merge loaded blocking parents into data structure
          target_hash = nil
          if replace_target
            target_hash = @_replace_limited_objects
          else
            target_hash = @_add_limited_objects
          end
          
          if target_hash.key?(target_name)
            target_hash[target_name] << blocking_parents
          else
            target_hash[target_name] = blocking_parents
          end
        end
        
      end # targets/target
      
      # add triggers
      found_triggers = []
      doc.root.xpath( "triggers/trigger" ).each do | trigger |
      
        trigger_macro = trigger.attribute("macro")           
       
        trigger_objects = {}
        trigger.xpath("object").each do | trigger_object |
        
          object_name = trigger_object.attribute("name")
          object_attributes = {}
          
          trigger_object.xpath( "attribute" ).each do | attribute_node |
          
            attribute_name = attribute_node.attribute("name")
            attribute_values = []
            
            attribute_node.xpath( "value" ).each do | value_node |
            
              attribute_values <<  value_node.text
            
            end # each value_node
            
            object_attributes[ attribute_name ] = attribute_values
            
          end # each attribute_node
          
          trigger_objects[ object_name ] = object_attributes
          
        end # each trigger_object
        
        found_triggers << { :macro => trigger_macro, :condition => trigger_objects }
                    
      end # each trigger
      
      doc.root.xpath( "triggers/custom-trigger" ).each do | custom_trigger |
      
        trigger_xpath = custom_trigger.attribute( "xpath" )
        trigger_macro = custom_trigger.attribute( "macro" )
        found_triggers  << { :macro => trigger_macro, :condition => trigger_xpath }
        
      end # each custom_trigger
       
      replace_target = (doc.root.xpath("triggers").first.attribute("replace").to_s.downcase == "true") unless doc.root.xpath("triggers").empty?
                    
      # add loaded triggers into data structure
      if replace_target
        @_replace_triggers = found_triggers
      else
        @_add_triggers = found_triggers
      end
      
      
      # add custom states
      @_add_custom_states = []
      doc.root.xpath( "states/state" ).each do | state |
       
        # collect defining objects
        state_objects = {}
        state.xpath("object").each do | state_object |
        
          object_name = state_object.attribute("name")
          object_attributes = {}
          
          state_object.xpath( "attribute" ).each do | attribute_node |
          
            attribute_name = attribute_node.attribute("name")
            attribute_values = []
            
            attribute_node.xpath( "value" ).each do | value_node |
            
              attribute_values <<  value_node.text
            
            end # each value_node
            
            object_attributes[ attribute_name ] = attribute_values
            
          end # each attribute_node
          
          state_objects[ object_name ] = object_attributes
          
        end # each state_object
        
        # create custom actions
        custom_actions = {}
        target_nodes = state.xpath("targets/target")
        target_nodes.each do | target_node |
          
          target_name = target_node.attribute("name")     
          raise TDMonkeyXmlDataParseError.new("Target node with no name encountered.") if target_name.nil?
                   
          replace_target = (target_node.attribute("replace").to_s.downcase == "true")
                
          # add actions
          target_node.xpath("actions/action").each do | action_node |
            action_name = action_node.attribute("name")
            raise TDMonkeyXmlDataParseError.new("The node '#{target_name}' has an action with a missing name attribute.") if action_name.nil?
        
            action_node.xpath("argument").each do | argument_node |
        
              argument_string = argument_node.attribute("value")
=begin              
              target_hash = nil
              if replace_target
                target_hash = @_replace_actions
              else
                target_hash = @_add_actions
              end
=end              
              target_hash = custom_actions
              if target_hash.key?(target_name)
                if target_hash[target_name].key?(action_name)
                  target_hash[target_name][action_name] |= [argument_string]
                else
                  target_hash[target_name][action_name] = [argument_string]
                end
              else
                target_hash[target_name] = {action_name => [argument_string]}
              end  

            end # 
          end  # each actions/action      
        
          # add templates to target object
          target_node.xpath("actions/include").each do | template_node |
            
            template_name = template_node.attribute("name") 
            raise TDMonkeyXmlDataParseError.new("The node '#{target_name}' has an include with a missing name attribute.") if template_name.nil?
=begin                      
            target_hash = nil
            if replace_target
              target_hash = @_replace_actions
            else
              target_hash = @_add_actions
            end
=end
            target_hash = custom_actions
            
            if target_hash.key? target_name
              target_hash[target_name].merge!({template_name.to_sym => nil})
            else
              target_hash[target_name] = {template_name.to_sym => nil}
            end         

          end # each actions/include
        end # targets/target
       
        @_add_custom_states << { :actions => custom_actions, :condition => state_objects }
                    
      end # each state
      
      # add controls
      doc.root.xpath("controls/control").each do | control_node |
        
        control_name = control_node.attribute("name")
        raise TDMonkeyXmlDataParseError.new("A control node with no name attribute was encountered.") if control_name.nil?
        
        replace_target = (control_node.attribute("replace").to_s.downcase == "true")
        
        argument_sets = []
        control_node.xpath("argument").each do | argument_node |
          argument_sets << argument_node.attribute("value")   
        end
        
        target_hash = nil
        if replace_target
          target_hash = @_replace_controls
        else
          target_hash = @_add_controls
        end
      
        target_hash[control_name] = argument_sets
                
      end
      
      # load templates  
      doc.root.xpath("action-templates/template").each do | template_node |
        
        template_name = template_node.attribute("name")
        raise TDMonkeyXmlDataParseError.new("A template with no name attribute was encountered.") if template_name.nil?
                
        # add actions
        template_node.xpath("action").each do | action_node |
        
          action_name = action_node.attribute("name")
          raise TDMonkeyXmlDataParseError.new("The template '#{template_name}' has an action with a missing name attribute.") if action_name.nil?
          
          action_node.xpath("argument").each do | argument_node |
            argument_string = argument_node.attribute("value")
            
            template_name = template_name.to_sym
            
            if @_templates.key?(template_name)
              if @_templates[template_name].key?(action_name)
                @_templates[template_name][action_name] |= [argument_string]
              else
                @_templates[template_name][action_name] = [argument_string]
              end
            else
              @_templates[template_name] = {action_name => [argument_string]}
            end  

          end
        end 
      end # action-templates/template
      
      # add definitions
      doc.root.xpath("definitions/definition").each do | definition_node |
        
        definition_name = definition_node.attribute("name")
        raise TDMonkeyXmlDataParseError.new("A definition with no name attribute was encountered.") if definition_name.nil?
        
        replace_target = (definition_node.attribute("replace").to_s.downcase == "true")
        
        set_contents = []
        definition_node.xpath("item").each do | definition_item |
          item_value = definition_item.attribute("value")
          raise TDMonkeyXmlDataParseError.new("The definition set '#{definition_name}' has an item without a value.") if item_value.nil?
          set_contents << item_value   
        end
        
        target_hash = nil
        if replace_target
          target_hash = @_replace_definitions
        else
          target_hash = @_add_definitions
        end
      
        target_hash[definition_name.to_sym] = set_contents
                
      end
      
    end
        
  end # TDMonkeyData  
 
end # MobyBase
