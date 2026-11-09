#!/usr/bin/env bash
# Mini-cours « 5 jours pour ne plus avoir peur de Git »
# Jour 2 : commits et branches
# Crée (ou recrée) le dépôt d'exercice dans ~/mini-cours-git-exos/jour2/projet
# Relançable à volonté : chaque exécution remet le dépôt à l'état de départ.
set -e
SCRIPTS="$(cd "$(dirname "$0")" && pwd)"
JOUR=jour2
BASE="$HOME/mini-cours-git-exos/$JOUR"

export GIT_AUTHOR_NAME="Dev Démo" GIT_AUTHOR_EMAIL="dev@demo.local"
export GIT_COMMITTER_NAME="Dev Démo" GIT_COMMITTER_EMAIL="dev@demo.local"
T=1762765200
commit() { T=$((T+3600)); GIT_AUTHOR_DATE="$T +0100" GIT_COMMITTER_DATE="$T +0100" git commit -q --no-verify "$@"; }

rm -rf "$BASE" && mkdir -p "$BASE" && cd "$BASE"
cp "$SCRIPTS/verifier.sh" "$BASE/verifier.sh"
git init -q projet && cd projet
git symbolic-ref HEAD refs/heads/main
git config user.name "Dev Démo"
git config user.email "dev@demo.local"
git config core.autocrlf false
# Neutralise les réglages personnels qui modifieraient les commits (signature, hooks, encodage)
git config commit.gpgsign false
git config core.hooksPath .git/aucun-hook
git config i18n.commitEncoding UTF-8

printf '<h1>Mon site</h1>\n' > index.html
git add index.html
commit -m "Création du site"

printf '%s\n' '<h2>Accueil</h2>' "<p>Bienvenue sur la page d'accueil.</p>" > accueil.html
git add accueil.html
commit -m "Page d'accueil"

# Le commit fait par erreur sur main (il aurait dû aller sur une branche "contact")
printf '<form>\n  <input name="email">\n  <button>Envoyer</button>\n</form>\n' > contact.html
git add contact.html
commit -m "Formulaire de contact"

echo
echo "Dépôt du jour 2 prêt. Pour commencer :"
echo "  cd ~/mini-cours-git-exos/$JOUR/projet"
echo "  git log --oneline --graph --all"
echo
echo "Quand tu as terminé, vérifie ton travail (depuis le dossier projet) :"
echo "  bash ../verifier.sh"
