# ss41518 grupa 31C
# wersja na 4, opcja -L jest uwzględniona, ale polecenie getpwuid nie działa pod Windows'em
# domyślna sciezka jest ustawiona na katalog bieżący i
# w odniesieniu do niego trzeba się poruszać między katalogami
# przy czym scieżkę trzeba zacząć podawać od '/'
# dla przykładu aby wyświetlic katalog nadrzędny trzeba w konsoli
# napisać: perl PWJS_Lab01_myls.pl /..
# opcje -l i -L wpisuje się domyślnie
use Cwd qw(cwd);
use DateTime;

my $dir = cwd;
my @dirList = ();

my $check = @ARGV;

if($check!=0)
{
  if($ARGV[0] !~ m[-])
  {
    $dir = $dir . $ARGV[0];
  }
  if($ARGV[1] !~ m[-])
  {
    $dir = $dir . $ARGV[1];
  }
  if($ARGV[0] !~ m[-])
  {
    $dir = $dir . $ARGV[2];
  }
}

opendir(DIR, $dir) || die "Nie można otworzyc $dir\n";
while(( $filename = readdir(DIR)))
{
  push @dirList, $filename;
}
closedir(DIR);

@dirList = sort @dirList;
foreach my $var(@dirList)
{
  my $currentFile = $dir . '/' . $var;
  my @statArray = stat($currentFile);  # 0-dev, 1-inode, 2-file type and perm, 3-hard links, 4-uid, 5-gid, 6-device identifier, 7-size bytes, 8-access time, 9-modify time, 10-inode change time, 11-jakis inny size, 12-blocks usage,

  if($ARGV[0] =~ /-l/ || $ARGV[1] =~ /-l/ || $ARGV[2] =~ /-l/)
  {
    my $filePerm = "";
    my $modeform = $statArray[2] & 07777;
    $modeform = sprintf("%03o", $modeform);
    if(-d $currentFile)
    {
      $filePerm = "d";
    }
    else
    {
      $filePerm = "-";
    }

    foreach my $var2(split('',$modeform))
    {
      if($var2==7)
      {
          $filePerm = $filePerm . 'rwx';
      }
      if($var2==6)
      {
          $filePerm = $filePerm . 'rw-';
      }
      if($var2==5)
      {
          $filePerm = $filePerm . 'r-x';
      }
      if($var2==4)
      {
          $filePerm = $filePerm . 'r--';
      }
      if($var2==3)
      {
          $filePerm = $filePerm . '-wx';
      }
      if($var2==2)
      {
          $filePerm = $filePerm . '-w-';
      }
      if($var2==1)
      {
          $filePerm = $filePerm . '--x';
      }
      if($var2==0)
      {
          $filePerm = $filePerm . '---';
      }
    }
    print "$filePerm  ";
  }

  if($ARGV[0] =~ /-L/ || $ARGV[1] =~ /-L/ || $ARGV[2] =~ /-L/)
  {
    my $user = (getpwuid $statArray[4])[0];
    print "$user  ";
  }

  $var = sprintf("%30s", $var);

  print "$var ";

  if($ARGV[0] =~ /-l/ || $ARGV[1] =~ /-l/ || $ARGV[2] =~ /-l/)
  {
    $dt = DateTime->from_epoch(epoch => $statArray[9]);
    my $modTime = $dt->ymd.' '.$dt->hms;

    print "$statArray[7]  ";
    print "$modTime ";
  }
  print "\n";
  #print "$filePerm | $var | $statArray[7] | $modTime \n";
}
