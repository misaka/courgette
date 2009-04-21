
use File::Which;

Given "courgette is in the user's path", sub {
  my $self = shift;

  $self->{ courgette_path } = '../bin/courgette';
  ok( $self->{ courgette_path }, "courgette script not found in path" );
};


When "courgette is run with the option --help", sub {
  my $self = shift;

#   return $courgette_output = `bin/courgette --help`;
  return "Courgette has been run";
};


Then "help information should be displayed", sub {
  my $self = shift;

  my $courgette_path = $self->{ courgette_path };

  my $courgette_output = `/opt/local/bin/courgette --help`;
  ok( $courgette_output, "help information is incorrect" );
};

1;

