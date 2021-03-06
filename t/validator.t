use strict;
use warnings;
use Test::More 0.88;

use CPAN::Meta;
use CPAN::Meta::Validator;
use File::Spec;
use IO::Dir;

my $data_dir = IO::Dir->new( 't/data' );
my @files = sort grep { /^\w/ } $data_dir->read;

use Data::Dumper;

for my $f ( @files ) {
  my $meta = CPAN::Meta->_load_file( File::Spec->catfile('t','data',$f) );
  my $cmv = CPAN::Meta::Validator->new({%$meta});
  ok( $cmv->is_valid, "$f validates" )
    or diag( "ERRORS:\n" . join( "\n", $cmv->errors ) );
}

done_testing;

