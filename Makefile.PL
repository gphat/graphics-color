use inc::Module::Install 0.75;

name     'Graphics-Color';
all_from 'lib/Graphics/Color.pm';
author   'Cory G Watson <gphat@cpan.org>';

build_requires 'Test::More';

test_requires 'Pod::Coverage::Moose';

requires 'Moose';
requires 'MooseX::Clone';

auto_install;

WriteAll;

