FROM python

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier les fichiers de votre projet dans le conteneur
# COPY . /app

# Installation de bats pour les tests
RUN apt-get update && apt-get install -y bats

# Définir un volume pour monter le projet réel
# VOLUME ["/app"]

# Définir la commande par défaut pour exécuter les tests bats
CMD ["bats", "tests/cabine.bats"]