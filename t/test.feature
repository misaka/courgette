Feature: Using Courgette

As a developper
I want to use the Courgette runner
So that I can use stories to test my application

Scenario: Getting command-line help.

          Given the Courgette application is installed
          And is in the user's path
	  When courgette is run with the option --help
          Then help information should be displayed

Scenario: Running the tests.

	  Given we're in the Courgette project dir
	  When 'make test' is run
          Then all the tests should pass
	  And there should be much cause for celebration

Feature: Feature Two

As a develapper
I want a bowl of cerael
So that I do not starve before 12

Scenario: No starving

    Given I have the hunger
    When I feed it some cereal
    Then the hunger should go away

