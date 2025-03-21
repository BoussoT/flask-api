import sqlite3

def get_db_connection():
    conn = sqlite3.connect('servers.db')
    conn.row_factory = sqlite3.Row
    return conn

def init_db():
    with get_db_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS servers (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                ip_address TEXT NOT NULL,
                os TEXT NOT NULL,
                ram TEXT NOT NULL,
                cpu TEXT NOT NULL,
                storage TEXT NOT NULL,
                location TEXT NOT NULL,
                status TEXT NOT NULL,
                owner TEXT NOT NULL,
                uptime TEXT NOT NULL,
                last_maintenance TEXT NOT NULL
            )
        ''')
        conn.commit()
