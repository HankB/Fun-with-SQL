# Rollover

Move some records from one table into another. First implementation is in `bash` and then again in `python`. The python one leverages the code in the `bash` script to prepare the DB files.

## Usage

```
rollover.sh
```

```
rollover.sh x
rollover.py
sqlite3 sink.db -cmd "select * from snk" ""
sqlite3 source.db -cmd "select * from src" ""
rm sink.csv sink.db source.csv source.db
```

## Status

Python script errors out.

```text
hbarta@rocinante:~/Programming/SQL/Fun-with-SQL/rollover$ ./rollover.py

    ATTACH DATABASE sink.db AS sink;
    INSERT INTO sink.snk(indx, i, a)
        SELECT indx, i, a
        FROM src
        WHERE i < 25;
    DETACH sink;
    delete from src WHERE i < 25;

Traceback (most recent call last):
  File "/home/hbarta/Programming/SQL/Fun-with-SQL/rollover/./rollover.py", line 30, in <module>
    c.execute(sql)
sqlite3.OperationalError: no such column: sink.db
hbarta@rocinante:~/Programming/SQL/Fun-with-SQL/rollover$ 
```
