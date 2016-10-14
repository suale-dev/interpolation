#!/bin/bash
set -e;

# location of this file in filesystem
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd );

# location of sql databases
ADDRESS_DB='/data/address.db';
STREET_DB='/data/street.db';

# location of stdio files
PROC_STDOUT='/data/conflate.out';
PROC_STDERR='/data/conflate.err';
PROC_CONFERR='/data/conflate.skip';

# a directory with enough free space to store sqlite tmp files
export SQLITE_TMPDIR='/data/tmp';

# ensure tmpdir exists
[ -d $SQLITE_TMPDIR ] || mkdir $SQLITE_TMPDIR;

# delete stdio files
rm -f $PROC_STDOUT $PROC_STDERR $PROC_CONFERR;

# run import
$DIR/concat_oa.sh | time -p node $DIR/../cmd/oa.js $ADDRESS_DB $STREET_DB 1>$PROC_STDOUT 2>$PROC_STDERR 3>$PROC_CONFERR;
