#!/usr/bin/env python3

import sqlite3
import atexit

# source and sink DB
source_db = 'source.db'
sink_db = 'sink.db'


def close_connection(some_con):
    some_con.commit()
    some_con.close()


conn = sqlite3.connect(source_db)
atexit.register(close_connection, conn)
c = conn.cursor()

sql='''
    ATTACH DATABASE {} AS sink;
    INSERT INTO sink.snk(indx, i, a)
        SELECT indx, i, a
        FROM src
        WHERE i < 25;
    DETACH sink;
    delete from src WHERE i < 25;
'''.format(sink_db)
print(sql)
c.execute(sql)
