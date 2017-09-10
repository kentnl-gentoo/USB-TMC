#!/usr/bin/env perl
use 5.010;
use warnings;
use strict;

use Perl::Tidy;
use File::Find;
use File::Spec::Functions 'catfile';

my @files;

if (@ARGV) {
    @files = @ARGV;
}
else {
    find(
        {
            wanted => sub {
                my $file = $_;
                if ( $file =~ /\.(pm|t|pl)$/ ) {
                    push @files, $file;
                }
            },
            no_chdir => 1,
        },
        'lib',
        't',
    );
}

perltidy( perltidyrc => 'perltidyrc', argv => [ '-b', '-bext=/', @files ], );

