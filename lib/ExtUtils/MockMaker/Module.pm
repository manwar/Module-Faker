package ExtUtils::MockMaker::Module;
use Moose;

use ExtUtils::MockMaker::Package;

has filename => (
  is  => 'ro',
  isa => 'Str',
  required => 1,
);

has packages => (
  is         => 'ro',
  isa        => 'ArrayRef[ExtUtils::MockMaker::Package]',
  required   => 1,
  auto_deref => 1,
);

sub as_string {
  my ($self) = @_;

  my $string = '';

  my $did_name;
  for my $pkg ($self->packages) {
    $string .= sprintf "package %s;\n", $pkg->name;
    $string .= sprintf "our \$VERSION = '%s';\n", $pkg->version
      if defined $pkg->version;

    $string .= sprintf "\n=head1 NAME\n\n%s - %s\n\n=cut\n\n", $pkg->name, '?'
      unless $did_name++;
  }

  $string .= "1\n";
}

no Moose;
1;
