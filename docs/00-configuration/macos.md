# Phase 0 — Environnement (macOS)

![macOS](https://img.shields.io/badge/Platform-macOS-000000?style=flat-square&logo=apple)
![Laravel Herd](https://img.shields.io/badge/Laravel_Herd-latest-FF2D20?style=flat-square&logo=laravel)

> [!IMPORTANT]
> ### Objectif
> Préparer un environnement de développement professionnel sur macOS en utilisant **Laravel Herd**, le standard moderne qui permet d'installer PHP, Nginx et Node.js en quelques secondes sans aucune configuration manuelle.
<br>

---

<br>
## Sommaire

- [Phase 0 — Environnement (macOS)](#phase-0--environnement-macos)
  - [Sommaire](#sommaire)
  - [Étape 1 — Installer Homebrew](#étape-1--installer-homebrew)
  - [Étape 2 — Installer Laravel Herd](#étape-2--installer-laravel-herd)
  - [Étape 3 — Installer Visual Studio Code](#étape-3--installer-visual-studio-code)
  - [Étape 4 — Préparer le dossier projet](#étape-4--préparer-le-dossier-projet)
  - [Vérifications finales](#vérifications-finales)
<br>

---

<br>
## Étape 1 — Installer Homebrew

Homebrew est le gestionnaire de paquets indispensable sur Mac pour installer des outils techniques proprement.

### ðŸŽ Terminal macOS
```bash
# Installation de Homebrew (copie-colle cette ligne dans ton Terminal)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Une fois l'installation terminée, suis les instructions à l'écran pour ajouter `brew` à ton PATH (les lignes commençant par `(echo...`).
<br>

---

<br>
## Étape 2 — Installer Laravel Herd

Sur Mac, on n'installe plus PHP manuellement. On utilise **Herd**, une application ultra-légère qui fournit tout le nécessaire.

1.  Télécharge Herd sur [herd.laravel.com](https://herd.laravel.com).
2.  Ouvre le fichier `.dmg` et glisse Herd dans tes Applications.
3.  Lance Herd. Il va installer automatiquement **PHP 8.3/8.4**, **Composer** et **Nginx**.

### Vérification dans le Terminal
```bash
# Vérifie que PHP et Composer sont accessibles
php -v
composer -v
```

> [!TIP]
> ### Node.js & NVM
> Herd permet aussi d'installer Node.js via son interface graphique (onglet "Node"). Active la version LTS (22.x) depuis les réglages de Herd.
<br>

---

<br>
## Étape 3 — Installer Visual Studio Code

On utilise Homebrew pour installer VS Code et ses extensions en une ligne.

### ðŸŽ Terminal macOS
```bash
# Installation de VS Code
brew install --cask visual-studio-code

# Installation des extensions recommandées
code --install-extension bradlc.vscode-tailwindcss
code --install-extension amiralizadeh9480.laravel-extra-intellisense
code --install-extension shufo.vscode-blade-formatter
code --install-extension livewire.vscode-livewire-control
```
<br>

---

<br>
## Étape 4 — Préparer le dossier projet

On prépare l'arborescence pour accueillir le code de la Phase 1.

### ðŸŽ Terminal macOS
```bash
# Crée le dossier projet dans tes Documents
mkdir -p ~/Documents/Projets/recettebox
cd ~/Documents/Projets/recettebox

# Initialisation Git
git init
git branch -M main

# Premier commit de documentation
git add .
git commit -m "docs: initialisation de l'environnement macOS"
```
<br>

---

<br>
## Vérifications finales

Exécute ce rapport pour confirmer que tout est prêt :

### ðŸŽ Rapport de version (macOS)
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

