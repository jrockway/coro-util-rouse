use inc::Module::Install;
use strict;

name 'Coro-Util-Rouse';
all_from 'lib/Coro/Util/Rouse.pm';

requires 'Sub::Exporter';
requires 'Coro';

test_requires 'Test::More';
test_requires 'Test::Exception';

WriteAll;
