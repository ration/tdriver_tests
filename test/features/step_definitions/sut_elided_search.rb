
Given /^I set elisis search to "([^\"]*)"$/ do |arg1|
  @__sut.parameter[:elided_search] = arg1
end

Then /^I reset elisis search to "([^\"]*)"$/ do |arg1|
  @__sut.parameter[:elided_search] = arg1
end
