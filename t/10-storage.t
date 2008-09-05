use Test::More tests => 2;

use Graphics::Color::RGB;
use Graphics::Color::CMYK;

my $rgb = Graphics::Color::RGB->new(
    red => 1, blue => 1, green => 1, alpah => 1
);

my $rgb2 = Graphics::Color::RGB->unpack($rgb->pack);
is_deeply($rgb, $rgb2, 'RGB serialization');

my $cmyk = Graphics::Color::CMYK->new(
    cyan => 1, magenta => 1, yellow => 1, key => 1
);
my $cmyk2 = Graphics::Color::CMYK->thaw($cmyk->freeze);
is_deeply($cmyk, $cmyk2, 'CMYK serialization');