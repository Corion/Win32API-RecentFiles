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

  use Win32API::RecentFiles qw(SHAddToREcentDocsA SHAddToRecentDocsW);
  SHAddToRecentDocsA('C:\\Full\\Path\\To\\Makefile.PL');
  SHAddToRecentDocsW('C:\\Full\\Path\\To\\fünf.txt');

=cut