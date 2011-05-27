Given "I have parameter class initialized" do

  raise RuntimeError, "parameter class not initialized" unless defined?( TDriver::Parameter )

end

Then /^delete parameter \:(.+)$/ do | key |

  TDriver::Parameter.delete( key.to_sym )

end

Then /^delete parameter \"(.+)\"$/ do | key |

  TDriver::Parameter.delete( key )

end

