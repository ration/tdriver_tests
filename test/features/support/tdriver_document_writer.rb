# To change this template, choose Tools | Templates
# and open the template in the editor.

module TDriver_Document_Writer

  @@status_table = { 
    :passed => { :text => 'PASSED', :color => 32 }, 
    :failed => { :text => 'FAILED', :color => 31 }, 
    :skipped => { :text => 'SKIPPED', :color => 31 }, 
    :undefined => { :text => 'NOT_RUN', :color => 33 }
  }

  @@first_feature = true

  @@status_table.default = { :text => '', :color => 37 }

  def start_feature( keyword,name, feature_file )

    lines = name.split("\n")

    puts "\n#{ colorize( "Feature:  " + lines.first, 36, true ) }"


    puts colorize( lines[1..-1].collect{ | line | "        " + line }.join("\n"), 36, false )

    puts "\n" if @@first_feature

    @@first_feature = false

    @xml_folder="feature_xml"
    if File::directory?(@xml_folder)==false
          FileUtils.mkdir_p @xml_folder
    end
    @feature_xml_file="#{@xml_folder}/#{File.basename(feature_file)}.xml"
    @feature_element_name = "#{name.split("\n").first}"
    @feature_element_description = "#{name[@feature_element_name.length..name.length]}"
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.feature{
        xml.description @feature_element_name
        xml.description @feature_element_description
        xml.scenarios{

        }
      }

    end
    File.open(@feature_xml_file, 'w') {|f| f.write(builder.to_xml) }
  end

  def start_scenario(keyword, name, file_colon_line, source_indent)

    #line_size = "Scenario: #{ name }".length

    line = colorize( "          Scenario: ", 35, false) + colorize( name, 35, true )

    puts "#{ line } " + colorize( file_colon_line.to_s + ' ' + source_indent.to_s, 30, true )

    @scenario_name=name
    io = File.open(@feature_xml_file, 'r')
    xml_data = Nokogiri::XML(io){ |config| config.options = Nokogiri::XML::ParseOptions::STRICT }
    xml_data.root.xpath("//feature/scenarios").each do |node|
      @scenario= Nokogiri::XML::Node.new("scenario",node)
      scenario_name = Nokogiri::XML::Node.new("description",@scenario)
      scenario_name.content = name
      @scenario.add_child(scenario_name)
      node.add_child(@scenario)
    end
    File.open(@feature_xml_file, 'w') {|f| f.write(xml_data.to_xml) }
  end

  def colorize( text, color_code = '37', highlight = false )

    color_code = case color_code
    
      when :red

        "31"

      when :green

        "32"

      when :gray

        "37"

      when :cyan

        "36"

    else

      color_code

    end

    "\e[#{ highlight ? '1;' : '0;' }#{ color_code }m#{ text }\e[0m"

  end

  def update_scenario( details, status = nil, keyword = nil )

    puts "          #{ colorize( keyword.to_s + details, @@status_table[ status ][ :color ] ) } " ##{ colorize( status.to_s.upcase, @@status_table[ status ][ :color ] ) }"
    
    io = File.open( @feature_xml_file, 'r' )

    xml_data = Nokogiri::XML(io){ |config| config.options = Nokogiri::XML::ParseOptions::STRICT }

    xml_data.root.xpath("//feature/scenarios/scenario").each do |node|

      if node.child.text == @scenario_name

        if details.index("I execute")==0
          scenario_step = Nokogiri::XML::Node.new("example_step",node)
        else
          scenario_step = Nokogiri::XML::Node.new("step",node)
        end

        scenario_step.set_attribute("status", status.to_s )

        scenario_step.content = "#{ details } #{ @@status_table[ status ][ :text ] }"

        node.add_child(scenario_step)

      end

    end

    File.open(@feature_xml_file, 'w') {|f| f.write(xml_data.to_xml) }

  end

  def update_scenario_exception( exception)

    puts "          #{ colorize( exception, :red ) }\n"

    io = File.open(@feature_xml_file, 'r')
    xml_data = Nokogiri::XML(io){ |config| config.options = Nokogiri::XML::ParseOptions::STRICT }
    xml_data.root.xpath("//feature/scenarios/scenario").each do |node|
      if node.child.text == @scenario_name
        scenario_step = Nokogiri::XML::Node.new("exception",node)
        scenario_step.content = exception
        node.add_child(scenario_step)
      end
    end
    File.open(@feature_xml_file, 'w') {|f| f.write(xml_data.to_xml) }
  end

  def end_scenario(current_feature,feature_status)
    #p "Ending scenario: #{current_feature} #{ feature_status.to_s.upcase }"
    puts "\n"
  end

  def end_feature(current_feature,feature_status)

    #p "Ending feature: #{current_feature} #{ feature_status.to_s.upcase }"
    puts "\n\n\n"

  end


end
