use Test::More tests => 6;

BEGIN {
    use_ok('Graphics::Color::YIQ');
}

my $color = Graphics::Color::YIQ->new(
    luminance => 1, in_phase => .4, quadrature => .5,
);

cmp_ok($color->luminance, '==', 1, 'luminance');
cmp_ok($color->in_phase, '==', .4, 'in_phase');
cmp_ok($color->quadrature, '==', .5, 'lightness');

my @yiq = $color->as_array();
is_deeply(\@yiq, [1, .4, .5], 'yiq as array');

cmp_ok($color->as_string(), '==', '1,.4,.5', 'as_string');
