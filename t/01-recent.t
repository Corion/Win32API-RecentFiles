#!perl
use 5.020;
use experimental 'signatures';
use Win32;
use File::Basename 'basename';
use Test2::V0 '-no_srand';
use File::Spec;
use utf8;
use Time::HiRes 'sleep';

use Win32API::RecentFiles 'SHAddToRecentDocsA', 'SHAddToRecentDocsU';
my $recent = Win32::GetFolderPath(Win32::CSIDL_RECENT());
diag "Recent files are in '$recent'";

sub wait_for_file( $fn, $wait=1 ) {
    my $timeout = time+$wait;
    while( ! -f $fn and time < $timeout ) {
        sleep 0.1;
    }
}

my $fn = basename( $0 );
my $recent_entry = "$recent\\$fn.lnk";
unlink $recent_entry;
my $f = File::Spec->rel2abs($0);
SHAddToRecentDocsA($f);
wait_for_file( $recent_entry ); # give the system time to make the file show up
ok -f $recent_entry, "$recent_entry was added to recent files";
unlink $recent_entry or warn $^E, $!;

$fn = "fände.txt";
$recent_entry = "$recent\\$fn.lnk";
my $fn_ansi = Win32::GetANSIPathName($recent_entry);
unlink $fn_ansi;
SHAddToRecentDocsU(File::Spec->rel2abs($fn));

wait_for_file( $fn_ansi );
if( !ok -f $fn_ansi, "$fn_ansi was added to recent files)") {
    diag $^E;
    opendir my $dh, $recent
        or diag "$^E while reading $recent";
    diag "Recent entries:";
    for my $entry (readdir $dh) {
        diag $entry;
    };
};

done_testing;
