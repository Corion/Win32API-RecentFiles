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
