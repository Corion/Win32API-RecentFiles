#!perl
use 5.020;
use experimental 'signatures';
use Win32;
use File::Basename 'basename';
use Test2::V0 '-no_srand';
use File::Spec;
use utf8;
use Time::HiRes 'sleep';
use Encode 'encode';

use Win32API::RecentFiles 'SHAddToRecentDocsA', 'SHAddToRecentDocsU', 'SHAddToRecentDocsW';
my $recent = Win32::GetFolderPath(Win32::CSIDL_RECENT());
diag "Recent files are in '$recent'";

sub wait_for_file( $filename, $wait=3 ) {
    my $fn = Win32::GetANSIPathName($filename);
    my $timeout = time+$wait;
    while( ! -f $fn and time < $timeout ) {
        sleep 0.1;
    }
    return -f $fn;
}

sub unlink_file( $filename ) {
    my $fn = Win32::GetANSIPathName($filename);
    unlink $fn;
}

my $fn = basename( $0 );
my $recent_entry = "$recent\\$fn.lnk";
unlink $recent_entry;
my $f = File::Spec->rel2abs($0);
SHAddToRecentDocsA($f);
ok wait_for_file( $recent_entry ), "$recent_entry was added to recent files";
{
    opendir my $dh, $recent
        or diag "$^E while reading $recent";
    diag "Recent entries:";
    for my $entry (readdir $dh) {
        diag $entry;
    };
    diag "---";
}
unlink $recent_entry or warn $^E, $!;

$fn = "fände.txt";
$recent_entry = "$recent\\$fn.lnk";
my $fn_wide = encode('UTF16-LE', $recent_entry );
unlink_file( $recent_entry );
SHAddToRecentDocsW($fn_wide);

wait_for_file( $recent_entry );
if( !ok -f $fn_wide, "$fn was added to recent files (as Wide string)") {
    diag $^E;
    opendir my $dh, $recent
        or diag "$^E while reading $recent";
    diag "Recent entries:";
    for my $entry (readdir $dh) {
        diag $entry;
        diag sprintf "%vX", $entry;
    };
    diag "---";
};
unlink_file( $recent_entry );

$fn = "fände.txt";
$recent_entry = "$recent\\$fn.lnk";
my $fn_ansi = Win32::GetANSIPathName($recent_entry);
unlink_file( $recent_entry );
SHAddToRecentDocsU(File::Spec->rel2abs($fn));

if( !ok wait_for_file( $recent_entry ), "$fn_ansi was added to recent files (as Unicode-string)") {
    diag $^E;
    opendir my $dh, $recent
        or diag "$^E while reading $recent";
    diag "Recent entries:";
    for my $entry (readdir $dh) {
        diag $entry;
        diag sprintf "%vX", $entry;
    };
    diag "---";
};
unlink_file( $recent_entry );

done_testing;
