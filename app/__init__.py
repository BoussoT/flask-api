from flask import Flask
from .routes import server_routes

app = Flask(__name__)
app.register_blueprint(server_routes)
