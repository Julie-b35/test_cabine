FROM python

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Installation de bats pour les tests
RUN apt-get update && apt-get install -y \
    bats \
    build-essential \
    libgpiod-dev \
    python3-pip \
    autoconf-archive \
    libasound2-dev \
    swig \
    git 


# Copier les fichiers nécessaires.
COPY Makefile.patch /app/Makefile.patch
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY ./app/requirements.txt /app/requirements.txt

# Rendre le script d'entrée exécutable
RUN chmod +x /usr/local/bin/entrypoint.sh


# Installer lgpio depuis les sources 
# Cette partie bug, je vais teste manuellement pour comprendre avec de debuger 'pip install -r /app/requirements.txt'
RUN git clone https://github.com/joan2937/lg.git \
    && cd lg \
    && sed -i 's/lgpio_m1="""/lgpio_m1=r"""/' DOC/bin/cmakdoc.py \
    && sed -i 's/rgpio_m1="""/rgpio_m1=r"""/' DOC/bin/cmakdoc.py \
    && patch -p0 < /app/Makefile.patch \
    && make \
    && make install \
    && pip install --upgrade pip lgpio --root-user-action=ignore 

# Nettoyer les fichiers inutiles
RUN cd .. \
    && rm -rf lg \
    && rm -rf /app/Makefile.patch

# Installer les dépendances python nécessaires
RUN pip install -r /app/requirements.txt --root-user-action=ignore

# Définir l'entrée du conteneur
ENTRYPOINT ["entrypoint.sh"]
