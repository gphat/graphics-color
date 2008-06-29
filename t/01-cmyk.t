use Test::More tests => 9;

BEGIN {
    use_ok('Graphics::Color::CMYK');
}

eval {
    my $color = Graphics::Color::HSL->new(
        cyan => 10, magenta => .4, yellow => .5, key => .3
    );
};
ok(defined($@), 'less than/equal to 1');

my $color = Graphics::Color::CMYK->new(
    cyan => .10, magenta => .4, yellow => .5, key => .30
);

cmp_ok($color->cyan, '==', .1, 'cyan');
cmp_ok($color->magenta, '==', .4, 'magenta');
cmp_ok($color->yellow, '==', .5, 'yellow');
cmp_ok($color->key, '==', .3, 'key');

my @cmyk = $color->as_array();
is_deeply(\@cmyk, [.1, .4, .5, .3], 'cmyk as array');

cmp_ok($color->as_string(), '==', '0.10,0.40,0.50,0.30', 'as_string');

cmp_ok($color->as_percent_string, 'eq', '10%, 40%, 50%, 30%', 'percent string');