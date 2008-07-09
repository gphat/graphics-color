use Test::More tests => 7;

BEGIN {
    use_ok('Graphics::Color::YUV');
}

my $color = Graphics::Color::YUV->new(
    luma => 1, blue_luminance=> .5, red_luminance => .2,
);

cmp_ok($color->luma, '==', 1, 'luma');
cmp_ok($color->y, '==', 1, 'luminance short');
cmp_ok($color->blue_luminance, '==', .5, 'blue');
cmp_ok($color->red_luminance, '==', .2, 'red');

my @yuv = $color->as_array();
is_deeply(\@yuv, [1, .5, .2], 'yiq as array');

cmp_ok($color->as_string(), 'eq', '1,0.5,0.2', 'as_string');
