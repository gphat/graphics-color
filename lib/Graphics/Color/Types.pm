package Graphics::Color::Types;
use MooseX::Types -declare => [qw(
    Number360OrLess NumberOneOrLess
)];

use MooseX::Types::Moose qw(Num);

subtype Number360OrLess,
    as Num,
    where { $_ <= 360 && $_ >= 0 },
    message { "This number ($_) is not less than or equal to 360!" };

subtype NumberOneOrLess,
    as Num,
    where { $_ <= 1 && $_ >= 0 },
    message { "This number ($_) is not less or equal to one!" };

1;