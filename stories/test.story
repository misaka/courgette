
Story: Using PStories

       As a developper
       I want to use the PStory runner
       So that I can use stories to test my application


Scenario: Getting command-line help.

	  Given the zucchini application is installed
          And is in the user's path
	  When zucchini is run with the option --help
          Then help information should be displayed



