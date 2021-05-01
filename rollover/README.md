# Rollover

Move some records from one table into another. First implementation is in `bash` and then again in `python`. The python one leverages the code in the `bash` script to prepare the DB files.

## Usage

```
rollover.sh
```

```
./rollover.sh x
./rollover.py
sqlite3 sink.db -cmd "select * from snk" ""
sqlite3 source.db -cmd "select * from src" ""
rm sink.csv sink.db source.csv source.db
```

## Status

Working

Key differences between piping commands to `sqlite3` and execiting them from Python.

* DB name must be quoted in Python.
* Python requires one SQL statement per `execute()`.
* Python requires an explicit `commit()` before the secondary database can be detached.
