#!/usr/bin/env bats

# Crée un répertoire temporaire
TMPDIR=$(mktemp -d)
export TMPDIR

setup() { 
    # Crée et active un environnement virtuel
    python3 -m venv $TMPDIR/venv
    source $TMPDIR/venv/bin/activate

    #copier les fichiers nécessaire dans le répertoire temporaire
    ls -la $TMPDIR
    cp -r /app/* $TMPDIR/
}

teardown() { 
    # Désactive l'environnement virtuel et supprime le répertoire temporaire
    deactivate
    rm -rf $TMPDIR
}

@test "Test si le script de cabine fonctionne" {
    run ls
    [ "$status" -eq 0 ]
}