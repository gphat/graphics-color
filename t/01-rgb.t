use Test::More tests => 17;

BEGIN {
    use_ok('Graphics::Color::RGB');
}

eval {
    my $color = Graphics::Color::RGB->new(
        red => 10, green => .4, blue => .5, alpha => 0
    );
};
ok(defined($@), 'less than/equal to 1');

my $color = Graphics::Color::RGB->new(
    red => 1, green => .4, blue => .5, alpha => 0
);

cmp_ok($color->red, '==', 1, 'red');
cmp_ok($color->r, '==', 1, 'red short');
cmp_ok($color->green, '==', .4, 'green');
cmp_ok($color->blue, '==', .5, 'blue');
cmp_ok($color->alpha, '==', 0, 'alpha');

my @rgb = $color->as_array;
is_deeply(\@rgb, [1, .4, .5], 'rgb as array');

my @rgba = $color->as_array_with_alpha;
is_deeply(\@rgba, [1, .4, .5, 0], 'rgba as array');

cmp_ok($color->as_string, 'eq', '1.00,0.40,0.50,0.00', 'as_string');

cmp_ok($color->as_integer_string, 'eq', '255, 102, 127, 0.00', 'integer string');
cmp_ok($color->as_hex_string, 'eq', '#ff667f', 'hex string');
cmp_ok($color->as_percent_string, 'eq', '100%, 40%, 50%, 0.00', 'percent string');

my $rgb2 = $color->clone;
ok($rgb2->equal_to($color), 'equal_to');

my $new = $color->derive({green => 1});
cmp_ok($new->green, '==', 1, 'derived color, green');
cmp_ok($new->blue, '==', .5, 'derived color, blue');

ok(!$new->equal_to($color), 'not equal_to');