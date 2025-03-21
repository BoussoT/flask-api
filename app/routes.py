from flask import Blueprint, request, jsonify
from app.database import get_db_connection


server_routes = Blueprint('server_routes', __name__)

@server_routes.route('/', methods=['GET'])
def home():
    return jsonify({"message": "Bienvenue sur l'API des serveurs"}), 200

@server_routes.route('/servers', methods=['GET'])
def get_servers():
    with get_db_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM servers")
        servers = [dict(row) for row in cursor.fetchall()]
    return jsonify(servers)

@server_routes.route('/servers/add', methods=['POST'])
def add_server():
    data = request.get_json()
    required_fields = ['name', 'ip_address', 'os', 'ram', 'cpu', 'storage', 'location', 'status', 'owner', 'uptime', 'last_maintenance']
    if not all(field in data for field in required_fields):
        return jsonify({'error': 'Missing required fields'}), 400
    with get_db_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("INSERT INTO servers (name, ip_address, os, ram, cpu, storage, location, status, owner, uptime, last_maintenance) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
                       tuple(data[field] for field in required_fields))
        conn.commit()
    return jsonify({'message': 'Server added successfully'}), 201

@server_routes.route('/servers/<int:server_id>', methods=['DELETE'])
def delete_server(server_id):
    with get_db_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("DELETE FROM servers WHERE id = ?", (server_id,))
        conn.commit()
    return jsonify({'message': 'Server deleted successfully'})
