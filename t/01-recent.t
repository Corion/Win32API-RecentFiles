#!perl
use 5.020;
use experimental 'signatures';
use File::Spec;
use utf8;

use Win32API::RecentFiles 'SHAddToRecentDocsA', 'SHAddToRecentDocsW';
use Win32;
use File::Basename 'dirname';
use Test2::V0 '-no_srand';
my $recent = Win32::GetFolderPath(Win32::CSIDL_RECENT());

my $f = File::Spec->rel2abs($0);
SHAddToRecentDocsA($f);
my $fn = dirname( $0 );
ok -f "$recent/$fn.lnk", "$fn was added to recent files";
unlink "$recent/$fn.lnk";

my $fn = "fände.txt";
SHAddToRecentDocsW($fn);
my $fn_ansi = Win32::GetANSIPathName("$recent/$fn.lnk");
ok -f $fn_ansi, "$fn was added to recent files";

done_testing;