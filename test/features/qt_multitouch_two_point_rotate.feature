Feature: TestObject::two_point_rotate (Rename this to be more descriptive)
  As a test scripter writer
  I want to use two_point_rotate method to [DO_SOMETHING] in [TARGET_APPLICATION]
  so that I can test the MobyBehaviour::QT::Multitouch behaviour

  Scenario: Testing two_point_rotate method with required argument(s) (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].two_point_rotate(radius, start_angle, rotate_direction, distance, speed)"
    Then [ADD_YOUR_VERIFICATION_HERE]

  Scenario: Testing two_point_rotate method with optional argument 'center_point' (Rename this to be more descriptive)
    Given I launch application [APPLICATION_NAME] as @app
    When I execute "@app.[SOME_OBJECT].two_point_rotate(radius, start_angle, rotate_direction, distance, speed, center_point)"
    Then [ADD_YOUR_VERIFICATION_HERE]

