package Palindromes;

use strict;
use warnings;

use Exporter qw(import);

our @EXPORT_OK = qw(
    is_palindrome
);

sub is_palindrome
{
    my $n = shift;
    my @chars = split('', $n);
    my @reverse_chars = reverse @chars;
    my $reverse_n = join('', @reverse_chars);
    return $n == $reverse_n;
}
