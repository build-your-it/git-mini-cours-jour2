#!/usr/bin/env bash
# Mini-cours Git - jour2 : vérifie l'exercice
# Les vérifications portent sur la structure et les titres des commits,
# jamais sur leurs identifiants : elles marchent quelle que soit la configuration de Git.
cd "$HOME/mini-cours-git-exos/jour2/projet" 2>/dev/null || { echo "Dépôt introuvable : lance d'abord  bash jour2/setup.sh"; exit 1; }
ok=0; total=0
check() { total=$((total+1)); if eval "$2" >/dev/null 2>&1; then echo "  OK          $1"; ok=$((ok+1)); else echo "  PAS ENCORE  $1"; fi; }
titre() { git log -1 --format=%s "$1" 2>/dev/null; }       # titre du commit pointé par une référence
existe() { git rev-parse --verify -q "refs/heads/$1" >/dev/null; }

ACCUEIL="Page d'accueil"; CONTACT="Formulaire de contact"
echo "Vérification du jour 2"
check "main pointe sur le commit « Page d'accueil »"             '[ "$(titre main)" = "$ACCUEIL" ] && [ "$(git rev-list --count main)" = 2 ]'
check "La branche contact pointe sur « Formulaire de contact »"  'existe contact && [ "$(titre contact)" = "$CONTACT" ]'
check "contact part bien de main (aucun commit perdu ni dupliqué)" '[ "$(git rev-parse contact~1)" = "$(git rev-parse main)" ]'
check "La branche pied-de-page existe et part de main"           'existe pied-de-page && [ "$(git rev-parse pied-de-page~1)" = "$(git rev-parse main)" ]'
check "Le commit de pied-de-page ajoute footer.html"             'git diff --name-only pied-de-page~1 pied-de-page | grep -qx footer.html'
check "contact.html n'est pas sur pied-de-page"                  '! git cat-file -e pied-de-page:contact.html'

echo
if [ "$ok" = "$total" ]; then echo "Bravo, exercice réussi ($ok/$total) !"; else echo "$ok/$total : encore un petit effort. Tu peux tout recommencer avec  bash jour2/setup.sh"; fi

