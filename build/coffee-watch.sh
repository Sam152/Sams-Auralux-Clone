#!/bin/sh
#
# todo: convert to a cakefile or something better suited to building JS. Would
# be nice to include a packed jsmin version of the code for inclusion.

coffee --watch --output bin/ src/
