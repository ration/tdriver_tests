require 'tdriver'
include TDriverVerify

# This is run before all screnarios
# After is not used
Before do
  @sut = TDriver.sut(:sut_qt_maemo)
end

Given("I launch application $app") do |app|
  @app = @sut.run(:name => 'meego-handset-people')
end

And("I tap text \"$text\"") do |text|
  @app.MLabel( :elidedText => text ).tap
end

And("I tap regular text \"$text\"") do |text|
  @app.MLabel( :text => text ).tap
end

And("I long tap text \"$text\"") do |text|
  @app.MLabel( :text => text ).long_tap
end

# Tap and type text. Tap is needed to set focus.
And("I type \"$text\" to field \"$field\"") do |text, field|
  @app.MTextEdit(:prompt => field).tap
  @app.MTextEdit(:prompt => field).type_text(text)
end


And("I flick $direction from \"$element\"") do |direction, text|
  @app.MLabel( :elidedText => text ).flick(direction == "down" ? :Down : :Up) 
  # The tap goes unnoticed by the application if the flick is still scrolling the view.
  # Normally never use sleep! The framework does this automatically. Without the "jitter" in the ui this shoulnd't be necessary.
  sleep 2  
end

# Verify anything that has the given elided text is on the screen
# We could do this in the label tap as well
Then("I see text \"$name\"") { |name|
  verify(10, name + " was not found from UI") {
    @app.child(:elidedText => name)
  }
}

Then("I close the application") {
  @app.close
}
