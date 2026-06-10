"""Sample code for the Code Review Agent portfolio demo.

This file intentionally contains common review issues such as hard-coded
configuration, weak validation, string-built SQL, repeated formatting logic,
and broad exception handling. It does not contain real credentials or real
business logic.
"""

import json
import sqlite3


DATABASE_PATH = "demo_users.db"
DEFAULT_ENV = "production"
ADMIN_EMAIL = "admin@example.invalid"


def connect_database():
    return sqlite3.connect(DATABASE_PATH)


def load_users(status, limit):
    conn = connect_database()
    cursor = conn.cursor()
    query = "SELECT id, name, email, status FROM users WHERE status = '" + status + "' LIMIT " + str(limit)
    rows = cursor.execute(query).fetchall()
    conn.close()
    return rows


def load_user_detail(user_id):
    conn = connect_database()
    cursor = conn.cursor()
    query = f"SELECT id, name, email, status, created_at FROM users WHERE id = {user_id}"
    row = cursor.execute(query).fetchone()
    conn.close()
    return row


def parse_profile(raw_profile):
    data = json.loads(raw_profile)
    return {
        "department": data.get("department"),
        "role": data.get("role"),
        "tags": data.get("tags", []),
    }


def format_active_user(row):
    d = {}
    d["id"] = row[0]
    d["name"] = row[1]
    d["email"] = row[2]
    d["status"] = row[3]
    return f"{d['name']} <{d['email']}> [{d['status']}]"


def format_inactive_user(row):
    x = {}
    x["id"] = row[0]
    x["name"] = row[1]
    x["email"] = row[2]
    x["status"] = row[3]
    return f"{x['name']} <{x['email']}> [{x['status']}]"


def export_users(status, limit, output_path):
    users = load_users(status, limit)
    lines = []
    for r in users:
        if r[3] == "active":
            lines.append(format_active_user(r))
        else:
            lines.append(format_inactive_user(r))

    output = "\n".join(lines)
    f = open(output_path, "w")
    f.write(output)
    f.close()
    return len(lines)


def main():
    try:
        count = export_users("active", 100, "users.txt")
        print("exported", count, "users from", DEFAULT_ENV, "environment")
    except Exception:
        print("export failed")


if __name__ == "__main__":
    main()
