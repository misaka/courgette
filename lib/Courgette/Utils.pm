package Courgette::Utils;

require Exporter;

our @ISA       = qw( Exporter );
our @EXPORT_OK = qw( attr_accessor );

sub attr_accessor {
  my $name = shift;

  my $set_eval = <<EVAL;
  sub set_$name {
    my \$self = shift;
    my \$new_value = shift;
    my \$old_value = \$self->{ $name };

    \$self->{ $name } = \$new_value;
    return \$old_value;
  }
EVAL
  eval $set_eval;
  die( "Error evaling setter for $name accessor: $@" ) if $@;

  my $get_eval = <<EVAL;
  sub get_$name {
    return \$_[0]->{ $name };
  }
EVAL
  eval $get_eval;
  die( "Error evaling getter for $name accessor: $@" ) if $@;
}


1;
