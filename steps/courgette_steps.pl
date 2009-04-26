
use File::Which;

Given "courgette is in the user's path", sub {
  my $self = shift;

  $self->{ courgette_path } = $0;
  $self->assert_true(
    $self->{ courgette_path },
    "courgette script not found in path"
   );
};


When "courgette is run with the option --help", sub {
  my $self = shift;

  return "Courgette has been run";
};


Then "help information should be displayed", sub {
  my $self = shift;

  my $courgette_path = $self->{ courgette_path };

  my $courgette_output = `$courgette_path --help`;
  $self->assert_matches(
    qr/Usage:\n\s+courgette \[options\] \[feature_file \| feature_dir\]/,
    $courgette_output,
    "help information is correct"
  );
};

1;

