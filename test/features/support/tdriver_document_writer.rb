# To change this template, choose Tools | Templates
# and open the template in the editor.

module TDriver_Document_Writer
  
  def start_feature(keyword,name, feature_file)
    p "Starting feature: #{keyword} #{name} #{feature_file}"
    @feature_xml_file="#{File.basename(feature_file)}.xml"        
    @feature_element_description = "#{name}"
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.feature{
        xml.description @feature_element_description
        xml.scenarios{

        }
      }

    end
    File.open(@feature_xml_file, 'w') {|f| f.write(builder.to_xml) }
  end

  def start_scenario(keyword, name, file_colon_line, source_indent)
    p "Starting scenario: #{keyword} #{name} #{file_colon_line} #{source_indent}"
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

  def update_scenario(details)
    p "Updating scenario: #{details}"
    io = File.open(@feature_xml_file, 'r')
    xml_data = Nokogiri::XML(io){ |config| config.options = Nokogiri::XML::ParseOptions::STRICT }
    xml_data.root.xpath("//feature/scenarios/scenario").each do |node|  
      if node.child.text == @scenario_name
        scenario_step = Nokogiri::XML::Node.new("step",node)
        scenario_step.content = details
        node.add_child(scenario_step)
      end
    end
    File.open(@feature_xml_file, 'w') {|f| f.write(xml_data.to_xml) }
  end

  def update_scenario_exception(exception)
    p "Updating scenario: #{exception}"

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
    p "Ending scenario: #{current_feature} #{feature_status}"
    puts ""
  end

  def end_feature(current_feature,feature_status)
    p "Ending feature: #{current_feature} #{feature_status}"
    
  end

      
end
