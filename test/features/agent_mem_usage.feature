@linux, @windows, @symbian, @meego

Feature: SUT::agent_mem_usage should return positive integer
	As a test scripter writer
	I want to see how much memory the TDriver agent process is using at the target device
	so that I can test verify that memory problems are not caused by it.

	Scenario: Query TDriver mem usage of TDriver agent
	        When I execute "@sut_agent_mem_usage = @__sut.agent_mem_usage"
	        Then mem usage result is a positive integer
