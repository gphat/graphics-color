use inc::Module::Install;

name     'Graphics-Color';
all_from 'lib/Graphics/Color.pm';
author   'Cory G Watson <cory.watson@iinteractive.com>';

build_requires 'Test::More';

auto_install;

WriteAll;

