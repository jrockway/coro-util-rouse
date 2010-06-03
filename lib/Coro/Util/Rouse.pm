package Coro::Util::Rouse;
use strict;
use warnings;
use Context::Preserve;
use Sub::Exporter -setup => {
    exports => [qw/rouse_cb rouse_wait/],
};

require Coro;

sub rouse_cb() {
    my $cb = Coro::rouse_cb();
    return sub { $cb->('success', @_) }, sub { $cb->('error', @_) };
}

sub rouse_wait() {
    my ($status, @result) = Coro::rouse_wait();
    return @result if $status eq 'success' && wantarray;
    return $result[-1] if $status eq 'success';
    die @result;
}
