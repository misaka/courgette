Feature: Using Zucchini

As a developper
I want to use the Zucchini runner
So that I can use stories to test my application

Scenario: Getting command-line help.

          Given the Zucchini application is installed
          And is in the user's path
	  When zucchini is run with the option --help
          Then help information should be displayed

Scenario: Running the tests.

	  Given we're in the Zucchini project dir
	  When 'make test' is run
          Then all the tests should pass
	  And there should be much cause for celebration
