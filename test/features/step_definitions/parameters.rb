Given "I have parameter class initialized" do

  raise RuntimeError, "parameter class not initialized" unless defined?( MobyUtil::Parameter )

end

Then "delete parameter \"$key\"" do | key |

  MobyUtil::Parameter.delete( key )

end
