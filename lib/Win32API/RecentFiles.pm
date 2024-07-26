package Win32API::RecentFiles 0.01;
use 5.020;
use experimental 'signatures';
use Exporter 'import';
require DynaLoader;
our @ISA = qw(Exporter DynaLoader);

our @EXPORT_OK = qw(SHAddToRecentDocsA SHAddToRecentDocsW);

our $VERSION = '0.01';

bootstrap Win32API::RecentFiles;
1;

=encoding utf8

=head1 NAME

Win32API::RecentFiles - recently accessed file API functions on Windows

=head1 SYNOPSIS

  use Win32API::RecentFiles qw(SHAddToRecentDocsA SHAddToRecentDocsW);
  use Win32;
  SHAddToRecentDocsA('C:\\Full\\Path\\To\\Makefile.PL');
  SHAddToRecentDocsW('C:\\Full\\Path\\To\\fünf.txt');
  my $recent_dir = Win32::GetFolderPath(Win32::CSIDL_RECENT());
  # $recent_dir\\fünf.txt.lnk exists

=head1 DESCRIPTION

This module exports the SHAddToRecentDocsA and SHAddToRecentDocsW functions.

=head1 SEE ALSO

Microsoft documentation at L<https://learn.microsoft.com/de-de/windows/win32/api/shlobj_core/nf-shlobj_core-shaddtorecentdocs>

=cut