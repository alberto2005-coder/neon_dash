# Neon Dash

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Flame](https://img.shields.io/badge/Flame-1.18%2B-FF6D00)](https://flame-engine.org/)
[![itch.io](https://img.shields.io/badge/Jugar-itch.io-FA5C5C?logo=itchdotio&logoColor=white)](https://alberto-coder2005.itch.io/neon-dash)
[![MIT](https://img.shields.io/badge/Licencia-MIT-green)](LICENSE)

[Español](#español) · [English](#english)

---

## Español

### Índice

- [Descripción](#descripción)
- [Cómo jugar](#cómo-jugar)
- [Características](#características)
- [Descarga](#descarga)
- [Guía de desarrollo](#guía-de-desarrollo)
- [Estructura del proyecto](#estructura-del-proyecto)
- [Compilación](#compilación)
- [Licencia](#licencia)

### Descripción

**Neon Dash** es un *endless runner* arcade construido con **Flutter** y el motor **Flame**. Controlas una figura geométrica que avanza sin parar por un mundo cibernético: salta los obstáculos, aguanta todo lo que puedas y persigue tu mejor marca. La dificultad sube con la velocidad, la música cambia y la puntuación se guarda en el dispositivo.

### Cómo jugar

| Plataforma | Control |
|---|---|
| Móvil | Toca la pantalla para saltar |
| Web / escritorio | `Espacio` o `↑` para saltar |

- Toca o pulsa **una vez** por salto; el salto doble no existe, así que mide el momento.
- Los obstáculos aparecen en patrones cada vez más rápidos.
- La partida termina al chocar; el mejor resultado se guarda con `shared_preferences`.
- En escritorio aparece un botón de salir; en móvil se usa el gesto del sistema.

### Características

- **Motor Flame** con bucle de juego propio y gestión de escenas.
- **Dificultad progresiva**: la velocidad aumenta con la distancia recorrida.
- **Generación de obstáculos** por patrones, con varios tipos y separaciones variables.
- **Sistema de partículas** para saltos y colisiones.
- **Fondo dinámico** que cambia de color según la partida.
- **Audio** de menú, música de juego y efectos de salto y explosión.
- **Selección de color** del jugador y menús bilingües español/inglés.
- **Récord persistente** entre sesiones.

### Descarga

- **itch.io:** <https://alberto-coder2005.itch.io/neon-dash>
- **Versión:** 1.0.0
- También puedes compilarlo tú mismo desde el código fuente (ver más abajo).

### Guía de desarrollo

Esta sección recoge la antigua guía interna del proyecto, ahora pública, para saber dónde tocar cada cosa.

| Si quieres cambiar… | Ve a este archivo |
|---|---|
| Puntuación y velocidad | `lib/neon_dash_game.dart` |
| Colores y formas del jugador | `lib/components/player.dart` |
| Obstáculos (tipos y frecuencia) | `lib/components/obstacle_manager.dart` |
| Textos y traducciones | `lib/neon_dash_game.dart` (mapa `_translations`) |
| Menús (diseño y botones) | `lib/main.dart` |
| Fondo y colores dinámicos | `lib/components/background.dart` |
| Logo de la app | `assets/images/logo.png` |

**Ajustar la dificultad.** En `lib/neon_dash_game.dart`, dentro de `update`, la línea `currentSpeed += 20;` controla la aceleración: sube o baja ese `20` para que la partida se acelere antes o después.

**Traducciones.** En `lib/neon_dash_game.dart`, el mapa `_translations` contiene las claves `es` y `en`. Añadir una palabra es añadirla en ambos idiomas.

**Añadir un color al jugador.** En `lib/main.dart`, busca `_colorButton` y duplica el botón con el color nuevo.

**Cambiar el icono.** Sustituye `assets/images/logo.png` y ejecuta `flutter pub run flutter_launcher_icons`.

### Estructura del proyecto

```text
neon_dash/
├── lib/
│   ├── main.dart                     # Arranque, menús y selección de color
│   ├── neon_dash_game.dart           # Bucle principal, puntuación, velocidad y textos
│   └── components/
│       ├── player.dart               # Jugador y salto
│       ├── obstacle.dart             # Obstáculo individual
│       ├── obstacle_manager.dart     # Patrones y frecuencia de obstáculos
│       ├── background.dart           # Fondo y colores dinámicos
│       └── particle_system.dart      # Partículas de salto y colisión
├── assets/
│   ├── audio/                        # Música y efectos
│   └── images/logo.png               # Icono de la app
├── android/ · ios/ · web/ · windows/ · macos/ · linux/
├── test/widget_test.dart
├── pubspec.yaml
├── LICENSE
└── README.md
```

### Compilación

Requisitos: **Flutter 3.x** (Dart 3.11+) y un emulador, dispositivo o navegador.

```bash
git clone https://github.com/alberto2005-coder/neon_dash.git
cd neon_dash
flutter pub get
flutter run                # desarrollo
flutter build apk --release    # Android
flutter build appbundle --release  # Google Play / Galaxy Store
flutter build web              # web estática en build/web
```

Comandos de mantenimiento:

```bash
flutter clean       # si algo deja de compilar
flutter pub get     # al descargar el proyecto de nuevo
```

### Licencia

**MIT** — consulta [LICENSE](LICENSE).

---

## English

### Table of contents

- [Overview](#overview)
- [How to play](#how-to-play)
- [Features](#features)
- [Download](#download)
- [Development guide](#development-guide)
- [Project structure](#project-structure)
- [Building](#building)
- [License](#license)

### Overview

**Neon Dash** is an arcade *endless runner* built with **Flutter** and the **Flame** engine. You control a geometric shape racing through a cyber world: jump the obstacles, survive as long as you can and chase your best score. Difficulty ramps up with speed, the music shifts and your record is stored on the device.

### How to play

| Platform | Control |
|---|---|
| Mobile | Tap the screen to jump |
| Web / desktop | `Space` or `↑` to jump |

- Tap or press **once** per jump; there is no double jump, so time it well.
- Obstacles arrive in patterns that get faster and tighter.
- The run ends on collision; the best score is saved with `shared_preferences`.
- Desktop builds show a quit button; mobile uses the system gesture.

### Features

- **Flame engine** with its own game loop and scene handling.
- **Progressive difficulty**: speed increases with distance travelled.
- **Pattern-based obstacle generation** with several types and varying gaps.
- **Particle system** for jumps and collisions.
- **Dynamic background** that shifts colour as you run.
- **Audio**: menu theme, gameplay music and jump/explosion effects.
- **Player colour picker** and bilingual Spanish/English menus.
- **Persistent high score** across sessions.

### Download

- **itch.io:** <https://alberto-coder2005.itch.io/neon-dash>
- **Version:** 1.0.0
- You can also build it yourself from source (see below).

### Development guide

This section turns the project's former internal notes into public documentation, so you know where to change what.

| If you want to change… | Go to this file |
|---|---|
| Score and speed | `lib/neon_dash_game.dart` |
| Player colours and shapes | `lib/components/player.dart` |
| Obstacles (types and frequency) | `lib/components/obstacle_manager.dart` |
| Texts and translations | `lib/neon_dash_game.dart` (`_translations` map) |
| Menus (layout and buttons) | `lib/main.dart` |
| Background and dynamic colours | `lib/components/background.dart` |
| App logo | `assets/images/logo.png` |

**Tune the difficulty.** In `lib/neon_dash_game.dart`, inside `update`, the line `currentSpeed += 20;` drives acceleration: raise or lower that `20` to speed the run up sooner or later.

**Translations.** In `lib/neon_dash_game.dart`, the `_translations` map holds the `es` and `en` keys. Add a word to both languages.

**Add a player colour.** In `lib/main.dart`, find `_colorButton` and duplicate the button with the new colour.

**Change the icon.** Replace `assets/images/logo.png` and run `flutter pub run flutter_launcher_icons`.

### Project structure

```text
neon_dash/
├── lib/
│   ├── main.dart                     # Bootstrap, menus and colour picker
│   ├── neon_dash_game.dart           # Main loop, score, speed and strings
│   └── components/
│       ├── player.dart               # Player and jumping
│       ├── obstacle.dart             # Single obstacle
│       ├── obstacle_manager.dart     # Obstacle patterns and frequency
│       ├── background.dart           # Background and dynamic colours
│       └── particle_system.dart      # Jump and collision particles
├── assets/
│   ├── audio/                        # Music and sound effects
│   └── images/logo.png               # App icon
├── android/ · ios/ · web/ · windows/ · macos/ · linux/
├── test/widget_test.dart
├── pubspec.yaml
├── LICENSE
└── README.md
```

### Building

Requirements: **Flutter 3.x** (Dart 3.11+) and an emulator, device or browser.

```bash
git clone https://github.com/alberto2005-coder/neon_dash.git
cd neon_dash
flutter pub get
flutter run                # development
flutter build apk --release    # Android
flutter build appbundle --release  # Google Play / Galaxy Store
flutter build web              # static site in build/web
```

Maintenance commands:

```bash
flutter clean       # if the build breaks
flutter pub get     # after re-downloading the project
```

### License

**MIT** — see [LICENSE](LICENSE).
