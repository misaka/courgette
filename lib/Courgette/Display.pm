package Courgette::Display;

sub feature {
  Courgette::Logger->instance->warning(
    "No display method defined for 'feature'."
  );
}

sub description {
  Courgette::Logger->instance->warning(
    "No display method defined for 'description'."
  );
}

sub step_missing {
  Courgette::Logger->instance->warning(
    "No display method defined for 'step_missing'."
  );
}

sub step_failed {
  Courgette::Logger->instance->warning(
    "No display method defined for 'step_failed'."
  );
}

1;
