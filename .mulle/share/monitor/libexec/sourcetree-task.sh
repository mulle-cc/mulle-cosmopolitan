#! /usr/bin/env bash
#
#   Copyright (c) 2018 Nat! - Mulle kybernetiK
#   All rights reserved.
#
#   Redistribution and use in source and binary forms, with or without
#   modification, are permitted provided that the following conditions are met:
#
#   Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
#   Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
#   Neither the name of Mulle kybernetiK nor the names of its contributors
#   may be used to endorse or promote products derived from this software
#   without specific prior written permission.
#
#   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
#   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
#   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
#   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
#   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
#   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
#   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
#   POSSIBILITY OF SUCH DAMAGE.
#

#
# Overwrite inherited task and add mulle-mulle-sourcetree-to-c.
# It would be nice to inherit this properly instead of clobbering it.
# Also mulle-sourcetree-to-c doesn't really require cmake to exist, this
# is another bug.
#
sourcetree_task_run()
{
   log_entry "mulle-sde/c-cmake::sourcetree_task_run" "$@"

   local runs

   case "${MULLE_SOURCETREE_TO_CMAKE_RUN}" in
      NO|DISABLE*|OFF)
      ;;

      *)
         runs="cmake"
      ;;
   esac

   case "${MULLE_SOURCETREE_TO_C_RUN}" in
      NO|DISABLE*|OFF)
      ;;

      *)
         r_comma_concat "${runs}" "c"
         runs="${RVAL}"
      ;;
   esac

   if [ -z "${runs}" ]
   then
      return
   fi

   log_info "Reflecting ${C_MAGENTA}${C_BOLD}${PROJECT_NAME:-.}${C_INFO} sourcetree ${C_RESET_BOLD}${MULLE_SOURCETREE_CONFIG_NAME:-config}"

   local rval

   rval=0
   case ",${runs}," in
      *,cmake,*)
         exekutor mulle-sourcetree-to-cmake ${MULLE_TECHNICAL_FLAGS} "$@"
         rval=$?
         if [ $rval -ne 0 ]
         then
            log_error "mulle-sourcetree-to-cmake ${MULLE_TECHNICAL_FLAGS} $* failed ($rval)"
         fi
      ;;
   esac

   local rval2

   rval2=0
   case ",${runs}," in
      *,c,*)
         exekutor mulle-sourcetree-to-c ${MULLE_TECHNICAL_FLAGS} "$@"
         rval2=$?
         if [ $rval2 -ne 0 ]
         then
            log_error "mulle-sourcetree-to-c ${MULLE_TECHNICAL_FLAGS} $* failed ($rval2)"
         fi
      ;;
   esac

   [ $rval -eq 0 -a $rval2 -eq 0 ]
}
