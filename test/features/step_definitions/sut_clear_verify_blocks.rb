Given /^I add a verify_always block on the sut$/ do
  @sut.verify_always("ok",nil){puts "ok"}
end