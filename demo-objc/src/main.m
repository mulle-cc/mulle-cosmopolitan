#import "import-private.h"

#include <stdio.h>


@interface Hello : NSObject

+ (void) print;

@end


@implementation Hello

+ (void) print
{
   printf( "VfL Bochum 1848\n");
}

@end



int  main( int argc, char *argv[])
{
#if defined( DEBUG) && defined( __MULLE_OBJC__)
   mulle_objc_global_check_universe( __MULLE_OBJC_UNIVERSENAME__);
#endif
   [Hello print];

   return( 0);
}


/*
 * #### Advertisement ####
 *
 * Check for leaks with mulle-testallocator! Add mulle-testallocator to your
 * project:
 *
 * mulle-sde dependency add --marks all-load,no-singlephase \
 *                          --github mulle-core \
 *                          mulle-testallocator
 *
 * Then build your project again and run your executable with the following
 * environment variables:
 *
 *    MULLE_OBJC_PEDANTIC_EXIT=YES
 *    MULLE_TESTALLOCATOR=YES
 *
 * To easier pin down, where a leak is created. try any of:
 *
 *    MULLE_TESTALLOCATOR_TRACE=3
 *    MULLE_OBJC_TRACE_INSTANCE=YES
 *    MULLE_OBJC_TRACE_METHOD_CALL=YES
 *    MULLE_OBJC_TRACE_UNIVERSE=YES
 *
 * If you are writing singleton code try:
 *
 *    MULLE_OBJC_EPHEMERAL_SINGLETON=YES
 *
 */


/*
 * extension : mulle-objc/objc-demo
 * directory : demo/executable
 * template  : .../main.PROJECT_EXTENSION
 * Suppress this comment with `export MULLE_SDE_GENERATE_FILE_COMMENTS=NO`
 */
