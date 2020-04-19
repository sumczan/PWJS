# ss41518

# przykładowy plik html trzeba podać jako argument
# przy uruchomieniu skryptu
use strict;
use warnings;
use Path::Tiny qw(path);
use Time::Piece;
use POSIX;
use Data::Dumper qw(Dumper);
#use POSIX qw(locale_h);    # linia potrzebna przy trzeciej linii
use POSIX qw(setlocale);
#setlocale(LC_ALL,"pl_PL.iso88592");
setlocale(&POSIX::LC_ALL,"pl");  # drugi argument w zaleznosci od systemu
binmode STDOUT, ":utf8";



my $filename = $ARGV[0];
open(my $fh, '<:encoding(UTF-8)', $filename) or die "Nie można otworzyć pliku '$filename' $!";

my $longRow;

while(my $row = <$fh>)
{
  chomp $row;
  #print "$row\n";
  if($row =~ /tr class/)
  {
    $longRow = $row;
  }
}
close($fh);

#print "$longRow\n";

my @rows = split /<tr class='problemrow'>/, $longRow;
my @rows2;
my $name = "";
my $points = "";
my $string = "";


$filename = 'lab3na3.csv';
$string = '"NAME","POINTS"';
$string = $string . "\n";
open(FH, '>', $filename) or die $!;

foreach my $var(@rows)
{
  #print "$var\n\n";
  @rows2 = split /<td class='mini'>/, $var;
  shift(@rows2);
  shift(@rows2);
  $name = @rows2[0];
  $name =~ s/<a href=.*'>//;
  $name =~ s/<.a>//;
  $name =~ s/<.td>//;
  print "$name  ";

  $points = pop(@rows2);
  $points =~ s/<.td>//;
  $points =~ s/<.tr>//;
  print $points;
  print "\n";

  $string = $string . '"' . $name . '","' . $points . '"';
  $string = $string . "\n";
}

print FH $string;
close(FH);
