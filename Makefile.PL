use inc::Module::Install 0.75;

name     'Graphics-Color';
all_from 'lib/Graphics/Color.pm';
author   'Cory G Watson <gphat@cpan.org>';

build_requires 'Test::More';

requires 'Color::Library' => '0.02';
requires 'Moose' => '0.74';
requires 'MooseX::Clone' => '0.03';

WriteAll;

