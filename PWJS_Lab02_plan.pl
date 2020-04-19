# ss41518
# wersja na 3
# plik *.ics trzeba podać jako argument przy uruchomieniu skryptu
use strict;
use warnings;
use Path::Tiny qw(path);
use Time::Piece;
use POSIX;

#my $file = shift or die "Usage: $ARGV[0] FILENAME";
#my $content = path($file)->slurp_utf8;
#print $content;

my $filename = $ARGV[0];
open(my $fh, '<:encoding(UTF-8)', $filename) or die "Nie można otworzyć pliku '$filename' $!";

my $beginTime = "";
my $endTime = "";
my $totalSeconds = 0;

while(my $row = <$fh>)
{
  chomp $row;
  if($row =~ /DTSTART/)
  {
    if($row =~ /(T\d{6})/)
    {
      $beginTime = $1;
      $beginTime = substr($beginTime,1,6);
      $beginTime = Time::Piece->strptime($beginTime, "%H%M%S");
      $beginTime = $beginTime->epoch;
      $beginTime = $beginTime + 15*60;
    }
  }
  if($row =~ /DTEND/)
  {
    if($row =~ /(T\d{6})/)
    {
      $endTime = $1;
      $endTime = substr($endTime,1,6);
      $endTime = Time::Piece->strptime($endTime, "%H%M%S");
      $endTime = $endTime->epoch;
      $totalSeconds = $totalSeconds + ($endTime-$beginTime);
    }
  }
};
my $totalHours = floor($totalSeconds/2700);
print "LACZNE GODZINY LEKCYJNE: $totalHours\n";
