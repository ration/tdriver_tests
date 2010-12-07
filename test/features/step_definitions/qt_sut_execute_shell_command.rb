Then /^the retuned @pid is not null$/ do
  verify_true(1, "@pid should be not nil" ) { @pid.nil? == false}
end

Then /^get a RuntimeError exception$/ do
  verify_true(1, "Expected exception not received" ) { @__exception.nil? == false}
  verify_true(1, "Unexpected exception received" ) { @__exception.kind_of? RuntimeError}
  @__exception = nil
end
