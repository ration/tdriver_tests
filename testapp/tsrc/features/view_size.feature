Feature: MATTI test application UI size is relative to screen
        As a MATTI developer
        I want MATTI test application to have relative UI size to screen size
        so that application can be used in any OS and device

    Scenario: The application ui starts relative to screen mode
        Given no active plugins
        And I run "testapp"
        Then "testapp" width no more than 1600 and height no more than 1200
