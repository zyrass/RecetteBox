# Phase 8 — Tests : assurer la stabilité avec Pest

![Phase 8](https://img.shields.io/badge/Phase-08-blue?style=flat-square)
![Pest](https://img.shields.io/badge/Pest-latest-40B5E8?style=flat-square&logo=pest)

> [!IMPORTANT]
> ### Objectif
> Découvrir les tests automatisés avec **Pest** de manière pragmatique. L'idée est d'apprendre à créer des tests concrets (Unit et Feature) pour sécuriser les fonctionnalités critiques (CRUD, filtres, Dashboard) sans complexité inutile.

<br>

---

<br>

## Sommaire

- [Pourquoi tester ?](#pourquoi-tester-)
- [Concepts introduits](#concepts-introduits)
- [Étape 1 — Préparation de l'environnement](#étape-1--préparation-de-lenvironnement)
- [Étape 2 — Test unitaire : valider nos Enums](#étape-2--test-unitaire--valider-nos-enums)
- [Étape 3 — Test de fonctionnalité : la liste des recettes](#étape-3--test-de-fonctionnalité--la-liste-des-recettes)
- [Étape 4 — Tester le Dashboard](#étape-4--tester-le-dashboard)
- [Lancer les tests](#lancer-les-tests)
- [Ce que tu as à la fin de cette phase](#ce-que-tu-as-à-la-fin-de-cette-phase)

<br>

---

<br>

## Pourquoi tester ?

Dans un projet comme RecetteBox, un test automatisé est un script qui vérifie que ton code fait toujours ce qu'il est censé faire. 
- **Éviter les régressions** : Si tu modifies le Dashboard en Phase 9, le test de la Phase 6 te dira tout de suite si tu as cassé quelque chose.
- **Confiance** : Tu peux refactoriser ton code sans peur.
- **Documentation** : Un test décrit le comportement attendu de l'application.

<br>

---

<br>

## Concepts introduits

- **Pest** : Un framework de test PHP élégant et minimaliste, construit au-dessus de PHPUnit.
- **Unit Test** : Teste une petite logique isolée (ex: une méthode d'un Enum).
- **Feature Test** : Teste une fonctionnalité entière (ex: "Est-ce que ma recherche Livewire fonctionne ?").
- **Assertions** : Des fonctions qui vérifient une condition (ex: `expect($value)->toBeTrue()`).

<br>

---

<br>

## Étape 1 — Préparation de l'environnement

Pest est normalement déjà pré-installé avec Laravel 13. Nous allons simplement nous assurer qu'il fonctionne avec notre base de données SQLite.

### `phpunit.xml` (ou `.env.testing`)

Vérifie que tes tests utilisent une base de données en mémoire pour être ultra-rapides.

```xml
<env name="DB_CONNECTION" value="sqlite"/>
<env name="DB_DATABASE" value=":memory:"/>
```

<br>

---

<br>

## Étape 2 — Test unitaire : valider nos Enums

Nous allons vérifier que nos enums renvoient bien les bonnes couleurs pour nos badges UI.

### `tests/Unit/RecipeCategoryTest.php` [NEW]

```php
use App\Enums\RecipeCategory;

test('chaque categorie a une couleur definie', function () {
    foreach (RecipeCategory::cases() as $category) {
        expect($category->color())->toBeString()
            ->not->toBeEmpty();
    }
});

test('la categorie dessert renvoie du rose', function () {
    expect(RecipeCategory::Dessert->color())->toBe('pink');
});
```

<br>

---

<br>

## Étape 3 — Test de fonctionnalité : la liste des recettes

Ici, on teste si notre composant Livewire affiche bien les recettes et si le filtre de recherche fonctionne.

### `tests/Feature/Livewire/RecipeIndexTest.php` [NEW]

```php
use App\Livewire\Pages\RecipeIndex;
use App\Models\Recipe;
use Livewire\Livewire;

test('le composant affiche la liste des recettes', function () {
    Recipe::factory()->create(['title' => 'Pasta Carbonara']);

    Livewire::test(RecipeIndex::class)
        ->assertSee('Pasta Carbonara');
});

test('on peut filtrer les recettes par titre', function () {
    Recipe::factory()->create(['title' => 'Lasagnes']);
    Recipe::factory()->create(['title' => 'Couscous']);

    Livewire::test(RecipeIndex::class)
        ->set('search', 'Las')
        ->assertSee('Lasagnes')
        ->assertDontSee('Couscous');
});
```

<br>

---

<br>

## Étape 4 — Tester le Dashboard

Le Dashboard calcule des moyennes et des comptes. On veut être sûr que le calcul est juste.

### `tests/Feature/Livewire/DashboardTest.php` [NEW]

```php
use App\Livewire\Pages\Dashboard;
use App\Models\Recipe;
use Livewire\Livewire;

test('le dashboard affiche le bon nombre total de recettes', function () {
    Recipe::factory()->count(5)->create();

    Livewire::test(Dashboard::class)
        ->assertSee('5'); // On suppose que le chiffre 5 est affiche
});
```

<br>

---

<br>

## Lancer les tests

Ouvre ton terminal et lance la commande magique :

```bash
php artisan test
```

Ou pour avoir le rendu stylé de Pest :
```bash
./vendor/bin/pest
```

> [!TIP]
> ### Mode Watch
> Si tu veux que les tests se relancent tout seuls à chaque sauvegarde :
> `php artisan test --watch`

<br>

---

<br>

## Ce que tu as à la fin de cette phase

- Un **bouclier de sécurité** autour de tes fonctionnalités clés.
- Une **méthodologie** pour tester tes futurs développements.
- Un projet avec un **score de fiabilité de 100%**.

<br>

---

<br>

> Phase précédente : [07-finitions.md](./07-finitions.md)
> Phase suivante : [09-authentification.md](../09-bonus/09-authentification.md)

<br>
