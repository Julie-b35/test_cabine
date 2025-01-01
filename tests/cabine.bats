#!/usr/bin/env bats

# Crée un répertoire temporaire
TMPDIR=$(mktemp -d)
export TMPDIR

setup() { 
    # Crée et active un environnement virtuel
    python3 -m venv $TMPDIR/venv
    source $TMPDIR/venv/bin/activate

    #copier les fichiers nécessaire dans le répertoire temporaire
    cp -r /app/* $TMPDIR/
}

teardown() { 
    # Désactive l'environnement virtuel et supprime le répertoire temporaire
    deactivate
    rm -rf $TMPDIR
}

@test "Test si le script de cabine fonctionne" {
    run bin/cabine
    [ "$status" -eq 0 ]
}