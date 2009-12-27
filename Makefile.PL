use inc::Module::Install 0.75;

name     'Graphics-Color';
all_from 'lib/Graphics/Color.pm';
author   'Cory G Watson <gphat@cpan.org>';

build_requires 'Test::More';
test_requires 'Test::Number::Delta';

requires 'Color::Library' => '0.02';
requires 'Moose' => '0.74';
requires 'MooseX::Aliases' => '0.03';
requires 'MooseX::Clone' => '0.03';
requires 'MooseX::Storage' => '0.23';
requires 'MooseX::Types' => '0.19';

WriteAll;

