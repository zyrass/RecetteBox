# Guide de Rétrocompatibilité & Coexistence des Versions (Multi-OS)

Ce guide s'adresse aux apprenants qui font face à des restrictions techniques sur leur poste de travail :

- **Impossibilité de mettre à jour** les outils systèmes (anciennes versions verrouillées de PHP, Node ou Composer).
- **Absence de droits administrateur** (ordinateurs d'entreprise, d'école, ou de bibliothèque).
- **Besoin de faire coexister** ce cursus avec des projets professionnels plus anciens (ex: projet sous PHP 8.1 ou Node 18) sans casser l'environnement existant.

<br>

---

<br>

## Table des matières

1. [Coexistence de plusieurs versions de PHP](#1-coexistence-de-plusieurs-versions-de-php)
2. [Installer PHP et Composer sans droits Administrateur](#2-installer-php-et-composer-sans-droits-administrateur)
3. [Forcer Composer à accepter d'anciennes versions de PHP](#3-forcer-composer-à-accepter-danciennes-versions-de-php)
4. [Faire coexister plusieurs versions de Node.js (nvm / fnm)](#4-faire-coexister-plusieurs-versions-de-nodejs-nvm--fnm)
5. [Adaptation syntaxique du code (PHP 8.4 vers PHP 8.2/8.3)](#5-adaptation-syntaxique-du-code-php-84-vers-php-8283)

<br>

---

<br>

## 1. Coexistence de plusieurs versions de PHP

Si vous avez déjà PHP 8.1 ou 8.2 d'installé par défaut sur votre machine et que vous devez le garder pour d'autres projets, voici comment utiliser PHP 8.4 spécifiquement pour **RecetteBox**.

### 💻 Windows (PowerShell)

Ne modifiez pas votre variable d'environnement `PATH` globale. Téléchargez PHP 8.4 en version `.zip` (Non-Thread-Safe) et extrayez-le dans un dossier local, par exemple `C:\tools\php84\`.

Créez un alias temporaire dans votre session PowerShell active, ou ajoutez-le à votre profil PowerShell :

```powershell
# Déclarer un alias local pour PHP 8.4
function php84 { & "C:\tools\php84\php.exe" $args }

# Déclarer un alias local pour Composer utilisant PHP 8.4
function composer84 { & "C:\tools\php84\php.exe" "C:\ProgramData\ComposerSetup\bin\composer.phar" $args }
```

Désormais, pour ce projet :

- Utilisez `php84 artisan serve` au lieu de `php artisan serve`.
- Utilisez `composer84 install` au lieu de `composer install`.

<br>

---

<br>

### 🍎 macOS (Terminal Zsh)

Utilisez Homebrew pour installer plusieurs versions en parallèle. Brew n'écrase pas votre version par défaut si vous ne la « liez » pas.

```bash
# Installer PHP 8.4 sans le définir par défaut
brew install php@8.4

# Créer un alias dans votre ~/.zshrc ou ~/.bashrc
alias php84="$(brew --prefix php@8.4)/bin/php"
alias composer84="php84 $(which composer)"
```
Rechargez votre terminal (`source ~/.zshrc`). Vous pouvez maintenant taper `php84` pour ce projet et conserver votre ancien `php` par défaut pour les autres.

<br>

---

<br>

### 🐧 Linux (Ubuntu / Debian)

Utilisez le dépôt d'Ondřej Surý pour installer plusieurs versions côte à côte :

```bash
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php8.4-cli php8.4-sqlite3 php8.4-curl php8.4-xml php8.4-zip php8.4-mbstring

# Créer un alias dans votre ~/.bashrc ou ~/.zshrc
alias php84="/usr/bin/php8.4"
alias composer84="php84 /usr/local/bin/composer"
```

<br>

---

<br>

## 2. Installer PHP et Composer sans droits Administrateur

Si les commandes `winget`, `brew` or `apt` vous sont interdites car vous n'avez pas de droits `sudo` ou `admin` :

### 💻 Windows

1. Téléchargez la version `.zip` de PHP 8.4 sur [windows.php.net](https://windows.php.net/download/).
2. Extrayez le dossier dans votre espace utilisateur, par exemple `C:\Users\VotreNom\php84\`.
3. Copiez le fichier `php.ini-development` et renommez-le en `php.ini`.
4. Ouvrez `php.ini`, recherchez la ligne `;extension_dir = "ext"` et remplacez-la par `extension_dir = "ext"`. Décommentez les lignes suivantes en enlevant le `;` au début :

   - `extension=curl`
   - `extension=mbstring`
   - `extension=openssl`
   - `extension=pdo_sqlite`
   - `extension=sqlite3`

5. Téléchargez `composer.phar` directement sur [getcomposer.org](https://getcomposer.org/download/) et placez-le dans le dossier `C:\Users\VotreNom\php84\`.
6. Exécutez Composer localement sans toucher au PATH global :
   ```powershell
   C:\Users\VotreNom\php84\php.exe C:\Users\VotreNom\php84\composer.phar install
   ```

<br>

---

<br>

### 🍎/🐧 macOS & Linux

Vous pouvez installer PHP et Composer entièrement dans votre répertoire personnel (`$HOME`).

```bash
# 1. Créer un dossier pour vos binaires utilisateur
mkdir -p ~/.local/bin

# 2. Télécharger Composer localement
curl -sS https://getcomposer.org/installer | php -- --install-dir=$HOME/.local/bin --filename=composer

# 3. Ajouter ce dossier à votre PATH utilisateur (dans ~/.zshrc ou ~/.bashrc)
export PATH="$HOME/.local/bin:$PATH"
```

<br>

---

<br>

## 3. Forcer Composer à accepter d'anciennes versions de PHP

Si votre serveur ou votre machine locale est bloquée sur une version antérieure de PHP (ex: PHP 8.2) et que Composer refuse d'installer Laravel 13 en déclarant que votre version PHP est trop ancienne :

### Option A : Déclarer la compatibilité dans le `composer.json`

Vous pouvez mentir poliment à Composer en lui indiquant d'émuler la version cible requise. Ajoutez ou modifiez le bloc `config` dans votre fichier `composer.json` :

```json
"config": {
    "platform": {
        "php": "8.4.0"
    },
    "allow-plugins": {
        "pestphp/pest-plugin": true
    }
}
```
*Cette configuration indique à Composer d'agir comme si vous aviez PHP 8.4, ce qui débloque la résolution des dépendances.*

### Option B : Ignorer les restrictions à l'installation

Si vous ne souhaitez pas modifier le fichier de configuration partagé, passez l'argument d'ignorance lors de l'installation ou de la mise à jour des dépendances :

```bash
composer install --ignore-platform-reqs
# ou
composer update --ignore-platform-req=php
```

<br>

---

<br>

## 4. Faire coexister plusieurs versions de Node.js (nvm / fnm)

Vite et Tailwind CSS 4 requièrent Node.js 22 LTS ou supérieur. Si vos anciens projets nécessitent Node 18 ou Node 16, l'utilisation d'un **gestionnaire de version Node** est indispensable pour basculer en une seconde.

### 💻 Windows

Utilisez **nvm-windows** (téléchargeable sans droits admin via le repository Github `coreybutler/nvm-windows`) :

```powershell
# Installer la version 22
nvm install 22.11.0

# Activer la version 22 pour ce projet
nvm use 22.11.0

# Confirmer la version active
node --version # Affiche v22.11.0
```

### 🍎/🐧 macOS & Linux

Utilisez **fnm** (Fast Node Manager) ou **nvm** :

```bash
# Installer fnm via curl
curl -fsSL https://fnm.vercel.app/install | bash

# Installer et utiliser la version LTS (22)
fnm install 22
fnm use 22
```
*Astuce pro :* Créez un fichier `.node-version` à la racine contenant simplement `22`. Fnm détectera automatiquement la bonne version à chaque fois que vous entrerez dans ce dossier.

<br>

---

<br>

## 5. Adaptation syntaxique du code (PHP 8.4 vers PHP 8.2/8.3)

Si vous devez exécuter l'application sur un serveur ou une machine verrouillée en **PHP 8.2** ou **PHP 8.3**, le code de nos guides peut contenir des fonctionnalités propres à PHP 8.4. Voici comment les traduire dans un dialecte compatible.

### A. Les Property Hooks (Nouveauté PHP 8.4)

PHP 8.4 introduit les Property Hooks pour éviter d'écrire des getters/setters manuels.

❌ **Syntaxe PHP 8.4 (utilisée dans le cursus) :**
```php
class Recipe {
    public string $title;
    
    // Property hook pour renvoyer le titre en majuscules
    public string $slug {
        get => Str::slug($this->title);
    }
}
```

🟢 **Traduction pour PHP 8.2 / 8.3 :**
Remplacez le property hook par un attribut standard combiné à un getter classique ou un attribut calculé Eloquent :
```php
class Recipe {
    public string $title;

    // Getter classique
    public function getSlug(): string 
    {
        return Str::slug($this->title);
    }
}
```

### B. Visibilité Asymétrique (`private(set)`)

PHP 8.4 permet d'avoir une propriété lisible publiquement mais modifiable uniquement en interne.

❌ **Syntaxe PHP 8.4 :**
```php
class Recipe {
    public private(set) string $status = 'draft';
}
```

🟢 **Traduction pour PHP 8.2 / 8.3 :**

Utilisez le modèle d'encapsulation traditionnel (attribut privé + getter public) :
```php
class Recipe {
    private string $status = 'draft';

    public function getStatus(): string
    {
        return $this->status;
    }
}
```

### C. Instanciation sans parenthèses `new MyClass()->method()`

Avant PHP 8.4, vous ne pouviez pas enchaîner directement après un constructeur sans entourer l'instanciation de parenthèses.

❌ **Syntaxe PHP 8.4 :**
```php
$status = new RecipeService()->getStatus();
```

🟢 **Traduction pour PHP 8.2 / 8.3 :**

Entourez le bloc d'instanciation de parenthèses, ou décomposez la variable :
```php
// Option 1 : Parenthèses (compatible PHP 8.2+)
$status = (new RecipeService())->getStatus();

// Option 2 : Décomposition
$service = new RecipeService();
$status = $service->getStatus();
```

<br>

---

<br>

## En résumé : Votre plan d'attaque en cas de blocage

| Problème rencontré | Action corrective immédiate | Commandes clés |
|---|---|---|
| **Pas de droits Admin (Win)** | Télécharger PHP zip + exécuter Composer via PHP directement | `C:\php\php.exe C:\php\composer.phar install` |
| **PHP trop ancien verrouillé** | Forcer Composer à ignorer ou émuler la plateforme | `--ignore-platform-reqs` ou `"platform": { "php": "8.4" }` |
| **Node.js en conflit** | Installer un gestionnaire de versions et isoler le runtime | `nvm use 22` ou `fnm use 22` |
| **Version PHP 8.2 obligatoire** | Remplacer les *Property Hooks* par des getters classiques | `public function getAttribute()` |
