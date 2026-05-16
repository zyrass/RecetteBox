# Phase 0 — Environnement (Linux)

![Linux](https://img.shields.io/badge/Platform-Linux-FCC624?style=flat-square&logo=linux&logoColor=black)
![PHP](https://img.shields.io/badge/PHP-8.4-777BB4?style=flat-square&logo=php)

> [!IMPORTANT]
> ### Objectif
> Préparer un environnement de développement Laravel sur Linux (Ubuntu, Debian, Fedora, etc.) en utilisant les dépôts officiels ou la méthode simplifiée `php.new`.
<br>

---

<br>
## Sommaire

- [Phase 0 — Environnement (Linux)](#phase-0--environnement-linux)
  - [Sommaire](#sommaire)
  - [Étape 1 — Mise à jour système](#étape-1--mise-à-jour-système)
  - [Étape 2 — Installer PHP et ses dépendances](#étape-2--installer-php-et-ses-dépendances)
  - [Étape 3 — Installer Composer et Laravel CLI](#étape-3--installer-composer-et-laravel-cli)
  - [Étape 4 — Installer Node.js et VS Code](#étape-4--installer-nodejs-et-vs-code)
  - [Étape 5 — Préparer le dossier projet](#étape-5--préparer-le-dossier-projet)
  - [Vérifications finales](#vérifications-finales)
<br>

---

<br>
## Étape 1 — Mise à jour système

Avant toute installation, on s'assure que le système est à jour.

### ðŸ§ Terminal (Debian/Ubuntu)
```bash
sudo apt update && sudo apt upgrade -y
```
<br>

---

<br>
## Étape 2 — Installer l'environnement (Méthode Recommandée)

La méthode **php.new** est le moyen le plus simple sur Linux. Elle installe PHP, Composer et l'installeur Laravel dans un environnement isolé sans modifier vos fichiers système.

### ðŸ§ Terminal Linux
```bash
# Installation automatique de PHP, Composer et Laravel CLI
/bin/bash -c "$(curl -fsSL https://php.new/install/linux)"
```

*Note : À la fin de l'installation, fermez et rouvrez votre terminal pour activer les commandes.*
<br>

---

<br>
## Étape 2 bis — Méthode Traditionnelle (Puriste)

Si vous préférez gérer vos paquets manuellement via `apt` (sur Debian/Ubuntu), suivez ces étapes.

### ðŸ§ Terminal (Debian/Ubuntu)
```bash
# Ajout du dépôt PHP (pour Ubuntu)
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update

# Installation de PHP 8.4 et des extensions critiques
sudo apt install php8.4 php8.4-cli php8.4-common php8.4-sqlite3 php8.4-curl php8.4-mbstring php8.4-xml php8.4-zip unzip -y
```
<br>

---

<br>
## Étape 3 — Installer Composer et Laravel CLI (Traditionnel)

Si vous n'avez pas utilisé la méthode `php.new` à l'étape 2, installez les outils manuellement.

### ðŸ§ Terminal Linux
```bash
# Téléchargement et installation de Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Installation du programme d'installation Laravel
composer global require laravel/installer
```

*Note : Assure-toi que `~/.config/composer/vendor/bin` est dans ton `$PATH`.*
<br>

---

<br>
## Étape 4 — Installer Node.js et VS Code

### Node.js (via NodeSource)
```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs
```

### Visual Studio Code
```bash
# Installation via Snap (le plus simple sur Ubuntu)
sudo snap install code --classic

# Extensions VS Code
code --install-extension bradlc.vscode-tailwindcss
code --install-extension amiralizadeh9480.laravel-extra-intellisense
code --install-extension shufo.vscode-blade-formatter
code --install-extension livewire.vscode-livewire-control
```
<br>

---

<br>
## Étape 5 — Préparer le dossier projet

### ðŸ§ Terminal Linux
```bash
# Crée le dossier projet
mkdir -p ~/Documents/Projets/recettebox
cd ~/Documents/Projets/recettebox

# Initialisation Git
git init
git branch -M main

# Premier commit
git add .
git commit -m "docs: initialisation de l'environnement Linux"
```
<br>

---

<br>
## Vérifications finales

### ðŸ§ Rapport de version (Linux)
```bash
php -v
composer -v
node -v
npm -v
git --version
code --version
```

> [!NOTE]
> ### Prochaine étape
> Ton environnement est prêt. Tu peux maintenant passer à la [Phase 1 — Squelette Laravel](../01-cursus/01-squelette.md).

<br>

