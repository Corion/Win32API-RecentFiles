#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"


#include "shlobj.h"

void SHAddToRecentDocsA(const char* path) {
    SHAddToRecentDocs(
        SHARD_PATHA,
        path
    );
}

void SHAddToRecentDocsW(SV* _path) {
    STRLEN len;
    char* s = SvPVutf8(_path, len);
    STRLEN length = MultiByteToWideChar(CP_UTF8, 0, s, len, 0, 0);
    //printf("len:    %d\n", len);
    //printf("length: %d\n", length);
    wchar_t* path;
    Newx(path, len+1, wchar_t);
    
    if( path ) {
        MultiByteToWideChar(CP_UTF8, 0, s, len, path, length);
        path[length] = L'\0';    
    }
    
    SHAddToRecentDocs(
        SHARD_PATHW,
        path
    );
    
    Safefree(path);
}

MODULE = Win32API::RecentFiles  PACKAGE = Win32API::RecentFiles  

PROTOTYPES: DISABLE


void
SHAddToRecentDocsA (path)
	const char *	path
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        SHAddToRecentDocsA(path);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
SHAddToRecentDocsW (_path)
	SV *	_path
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        SHAddToRecentDocsW(_path);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */
