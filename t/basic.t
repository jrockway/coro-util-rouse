use strict;
use warnings;
use Test::More;
use Test::Exception;
require Coro;

sub async(&){ goto &Coro::async };

use Coro::Util::Rouse qw(rouse_cb rouse_wait);

async {
    my ($ok, $bad) = rouse_cb;
    $ok->(1,2,3);
    is_deeply [rouse_wait], [1,2,3], 'success in list context works';
}->join;

async {
    my ($ok, $bad) = rouse_cb;
    $ok->(42,69,13);
    is scalar rouse_wait, 13, 'success in scalar context works';
}->join;


async {
    my ($ok, $bad) = rouse_cb;
    # example from http://icanhascheezburger.files.wordpress.com/2007/08/oh-noes.jpg
    $bad->('OH NOES!  I HAS LET GO!');

    throws_ok {
        my $whatever = rouse_wait;
    } qr/oh noes.*i has let go/i, 'failure of one arg works';
}->join;

async {
    my ($ok, $bad) = rouse_cb;
    # example from http://icanhascheezburger.files.wordpress.com/2007/08/oh-noes.jpg
    $bad->('OH NOES!', '  ', 'I HAS LET GO!');

    throws_ok {
        my $whatever = rouse_wait;
    } qr/oh noes.*i has let go/i, 'failure of multiple args works';
}->join;

done_testing;
