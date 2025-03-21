# Utilisation de Python comme base
FROM python:3.9

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de l'application
COPY . /app

# Installer les dépendances
RUN pip3 install --no-cache-dir -r requirements.txt

# Exposer le port Flask
EXPOSE 5000

# Démarrer l'application
CMD ["python3", "run.py"]
