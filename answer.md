```md
## Les targets

Les targets sont les environnements dans lequel notre application va être déployée.


## Files
AppDelegate est le point d'entrée de notre application et va gérer le cycle de vie de notre application.
SceneDelegates va quant à lui gérer le cycle de vie de notre écran.
Le ViewController va lui servir à contrôler ce qui est dans notre vue, la mettre à jour, gérer les interactions utilisateurs, gérer l'interface et même interagir avec d'autres vues.


## Le dossier `Assets.xcassets`

Ce dossier va contenir tous les fichiers qu'on va importés, que ce soit visuel ou des documents diverses.

## Le Stroyboard
Un storyboard sert à configurer visuellement le contenu des contrôleurs et des vues

## Simulateur

Un simulateur va nous permettre d'émuler notre iPhone pour nous permettre d'afficher ce que l'on est entrain de développer.

## Cmd + R

Cela sert à lancer un build de l'application.

## Cmd + shift + 0 

Cela sert à ouvrir la documentation.


## Commenter 
Cmd + /

## Indenter 
Ctrl + I 

# Navigation

## Exercice 1
On vient de créer un composant mère qui comporte notre DocumentTablieView qui est son enfant.
Un NavigationController va permettre de gérer la navigation et permet de gérer des éléments comme le titre de une ou plusieurs vues.

La navigationBar va permettre de gérer l'espace consacré au titre tandis que le NavigationController va permettre de gérer le comportement de tout le composant navigation.

# Ecran Détail

## Exercice 1
Un segue est un moyen de lier deux composants dans le storyboard et il permet de gérer la transition de la hiérarchie et la transition de composants.

## Exercice 2
Une contrainte de positionnement sera utile pour que l'image soit au bon format et adaptable à tous les écrans.
AutoLayout est l'objet dans le storyboard qui va permettre de gérer le positionnement de le l'image et donc les contraintes vont modifier cet autolayout.

# QLPreview
## Questions

- Il serait plus pertinent de changer l'accessory de nos cellules pour un disclosureIndicator pour améliorer notre interface et que l'utilisateur comprenne facilement que notre cellule est cliquable


# Importations
## Questions

Le selector sert à pointer vers une fonction objc .
 
.add représente l'icône "+" du bouton

Nous devons mettre le mot clé @objc devant la fonction ciblée car c'est une fonction Objective-C, c'est à dire qu'elle s'execute pendant le runtime.

Oui c'est possible en faisant un tableau de UIButton et en l'affectant à notre navigation.

Defer sert à différer l'exécution à la fin du chargement du document.


```
