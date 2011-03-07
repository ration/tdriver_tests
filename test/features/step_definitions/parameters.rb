Given "I have parameter class initialized" do

  raise RuntimeError, "parameter class not initialized" unless defined?( MobyUtil::Parameter )

end

Then /^delete parameter \:(.+)$/ do | key |

  MobyUtil::Parameter.delete( key.to_sym )

end

Then /^delete parameter \"(.+)\"$/ do | key |

  MobyUtil::Parameter.delete( key )

end

