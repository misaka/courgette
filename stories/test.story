
Story: Using PStories

       As a developper
       I want to use the PStory runner
       So that I can use stories to test my application


Scenario: Getting command-line help.

	  Given the pstory application is installed
          And is in the user's path
	  When pstory is run with the option --help
          Then help information should be displayed



