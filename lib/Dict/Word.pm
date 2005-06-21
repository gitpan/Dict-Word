package Dict::Word;

use 5.008006;
use strict;
use warnings;
use utf8;

use Dict::Word::Radix;	#needed to find the radix
use Dict::Db;	#needed to get the translation
use Switch;


our @ISA = qw();

our $VERSION = '1.3';


sub new{

	my $this={};
	$this->{WORD}=$_[1];
	$this->{RADIX}=&radix($this->{WORD});
	$this->{TRANSLATION}="";
	$this->{ARABTEX}=&encode($this->{WORD});

	bless($this);
return $this;
}



sub get_word{

	my $this=shift;
return "WORD: $this->{WORD}\n";
}

sub get_radix{

	my $this=shift;
return "RADIX: $this->{RADIX}\n";

}

sub get_arabtex{

	my $this=shift;
return "ARABTEX: $this->{ARABTEX}\n";

}

sub get_translation{

	my $this=shift;
	$this->{TRANSLATION}=Dict::Db::translate($this->{WORD},$_[0]);
return "TRANSLATION: $this->{TRANSLATION}\n";

}




1;
__END__

=head1 NAME

Dict::Word - Perl extension for getting the radix and the translation of Arabic words

=head1 SYNOPSIS

use utf8;

my $word=Dict::Word->new(ARABIC_WORD_IN_UTF8);


open FOUTPUT, ">>TEST" or die "Cannot create TEST: $!\n";
binmode(FOUTPUT,":utf8");

print FOUTPUT $word->get_word();
print FOUTPUT $word->get_radix();
print FOUTPUT $word->get_arabtex();

my $db=Dict::Db->new("./dicts","en");
print FOUTPUT $word->get_translation($db);

close FOUTPUT;


=head1 DESCRIPTION

In order to work on an Arabic word, you need to create the object Dict::Word, passing the Arabic word encoded in utf8 to the constructor.
You will then be able to get the radix through get_radix().
You will get the ArabTeX translittered form through get_arabtex().
If you also want the translation, you'll need to create the $db object (described in the Dict::Db module), so that it may look for its meaning in the correct Database.

Remember that input-output directly to shell will not be useful as long as your shell doesn't support utf8 encoded characters.
That's because I piped the output to another file, forcing its writing in utf8.



=head1 SEE ALSO

You may find more info about ArabTeX encoding at ftp://ftp.informatik.uni-stuttgart.de/pub/arabtex/arabtex.htm



=head1 AUTHOR

Andrea Benazzo, E<lt>andy@slacky.itE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2005 Andrea Benazzo. All rights reserved.
 This program is free software; you can redistribute it and/or
 modify it under the same terms as Perl itself.


=cut
