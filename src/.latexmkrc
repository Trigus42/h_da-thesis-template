# Add glossaries support
# This configuration handles standard glossaries (.glo -> .gls) and acronyms (.acn -> .acr).
# If you define new glossary types with different extensions (e.g. \newglossary[nlg]{notation}{not}{nlo}{Notation}),
# you will need to add a corresponding add_cus_dep line here.

$max_repeat = 10;

add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
add_cus_dep('nlo', 'nls', 0, 'run_makeglossaries');

sub run_makeglossaries {
    my ($base_name, $path) = fileparse( $_[0] );
    pushd $path;
    my $return = system "makeglossaries $base_name";
    popd;
    return $return;
}

# Always process glossaries
$makeindex = 'makeindex %O -o %D %S';