#!/usr/bin/env bash
# Bash3 Boilerplate. Copyright (c) 2014, kvz.io

set -o errexit
set -o pipefail
set -o nounset

readonly source_db="source.db"
readonly source_data="source.csv"
readonly sink_db="sink.db"
readonly sink_data="sink.csv"

if [ -e "$source_db" ]
then
    rm "$source_db"
fi

test -e "$sink_db" && rm "$sink_db"


# Create source DB
cat <<EOF | sqlite3 "$source_db"
CREATE TABLE src
    (indx INTEGER PRIMARY KEY AUTOINCREMENT, 
    i INTEGER, 
    a TEXT)
EOF

# create source data
cat <<EOF >"$source_data"
3,10,"this"
4,20,"is"
5,30,"some"
6,40,"text"
EOF

# populate source database
cat <<EOF | sqlite3 "$source_db"
.mode csv
.import $source_data src
EOF

# create sink DB (note no autoincrement column) and populate

# Create source DB
cat <<EOF | sqlite3 "$sink_db"
CREATE TABLE src
    (indx INTEGER PRIMARY KEY, 
    i INTEGER, 
    a TEXT)
EOF

# sink data
# create source data
cat <<EOF >"$sink_data"
1,10,"ipsum"
2,20,"delorum"
EOF

# populate sink database
cat <<EOF | sqlite3 "$sink_db"
.mode csv
.import "$sink_data" src
EOF
