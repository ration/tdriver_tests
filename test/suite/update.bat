@echo off
del /F /Q pkg\
cmd /c "gem uninstall tdriver_test_suite -a -x -I"
cmd /c "rake gem"
cmd /c "gem install pkg\tdriver_test_suite*.gem --LOCAL --no-ri --no-rdoc"

