
Given "the zucchini application is installed", sub {
  1;
};

When "zucchini is run with the option --help", sub {
#   return $zucchini_output = `bin/zucchini --help`;
  return "Zucchini has been run";
};


Then "help information should be displayed", sub {
  is( $zucchini_output, "..." );
};

1;

