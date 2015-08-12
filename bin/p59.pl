#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";

=pod
XOR decryption
Each character on a computer is assigned a unique code and the preferred standard is ASCII (American Standard Code for Information Interchange). For example, uppercase A = 65, asterisk (*) = 42, and lowercase k = 107.

A modern encryption method is to take a text file, convert the bytes to ASCII, then XOR each byte with a given value, taken from a secret key. The advantage with the XOR function is that using the same encryption key on the cipher text, restores the plain text; for example, 65 XOR 42 = 107, then 107 XOR 42 = 65.

For unbreakable encryption, the key is the same length as the plain text message, and the key is made up of random bytes. The user would keep the encrypted message and the encryption key in different locations, and without both "halves", it is impossible to decrypt the message.

Unfortunately, this method is impractical for most users, so the modified method is to use a password as a key. If the password is shorter than the message, which is likely, the key is repeated cyclically throughout the message. The balance for this method is using a sufficiently long password key for security, but short enough to be memorable.

Your task has been made easy, as the encryption key consists of three lower case characters. Using cipher.txt (right click and 'Save Link/Target As...'), a file containing the encrypted ASCII codes, and the knowledge that the plain text must contain common English words, decrypt the message and find the sum of the ASCII values in the original text.
=cut

my $solution;

# get the encrypted message
my $file = "$Bin/../data/p59.txt";
open(my $fh, $file);
my $line = <$fh>;
chomp $line;
close $fh;

# get the dictionary
$file = "$Bin/../data/dictionary.txt";
open($fh, $file);
my $words_string = <$fh>;
close $fh;

my @words = split(',', $words_string);
@words = map { $_ =~ s/"//g; $_ } @words;
my %dictionary = map { lc($_) => 1 } @words;

my ($best_key, $best_msg, $most_dictionary_words) = (undef, undef, 0);
my @ascii_codes = split(m{\s*,\s*}, $line);
foreach my $l1 ('a'..'z')
{
    foreach my $l2 ('a'..'z')
    {
        foreach my $l3 ('a'..'z')
        {
            my $possible_key = "$l1$l2$l3";
            my $msg = decrypt(\@ascii_codes, $possible_key);
            my @msg_words = split(m{\s+}, lc $msg);
            my $dictionary_words_count = 0;
            foreach my $w (@msg_words)
            {
                $dictionary_words_count++ if $dictionary{$w};
            }

            if($dictionary_words_count > $most_dictionary_words)
            {
                $most_dictionary_words = $dictionary_words_count;
                $best_msg = $msg;
                $best_key = $possible_key;
            }
        }
    }
}

my $sum_of_ascii = 0;
for(my $k = 0; $k < length($best_msg); $k++)
{
    my $char = substr($best_msg, $k, 1);
    my $ascii_val = ord($char);
    $sum_of_ascii += $ascii_val;
}

$solution = $sum_of_ascii;

say "Solution = $solution" if $solution; # 107359 

sub decrypt
{
    my ($ascii_codes, $key) = @_;
    my $msg = "";
    for(my $k = 0; $k < scalar @$ascii_codes; $k++)
    {
        my $key_char = substr($key, $k%length($key), 1);
        my $decrypted_char = chr($ascii_codes->[$k] ^ ord($key_char));
        $msg .= $decrypted_char;
    }
    return $msg;
}

