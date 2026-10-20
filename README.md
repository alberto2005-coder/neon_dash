# 🛠️ Manual de Desarrollador - Neon Dash

Este archivo es una guía personal para que sepas dónde está cada cosa y cómo editar el juego sin complicaciones. **Este documento es privado y para uso interno.**

---

## 📌 Guía Rápida de Archivos

| Si quieres cambiar... | Ve a este archivo: |
| :--- | :--- |
| **Puntuación y Velocidad** | `lib/neon_dash_game.dart` |
| **Colores y Formas del Jugador** | `lib/components/player.dart` |
| **Obstáculos (Tipos y Frecuencia)** | `lib/components/obstacle_manager.dart` |
| **Textos y Traducciones** | `lib/neon_dash_game.dart` (Mapa `_translations`) |
| **Menús (Diseño, Botones)** | `lib/main.dart` |
| **Fondo y Colores Dinámicos** | `lib/components/background.dart` |
| **Logo de la App** | `assets/images/logo.png` |

---

## 🚀 Comandos de Terminal Útiles

Úsalos en la carpeta raíz del proyecto:

*   **Instalar todo**: `flutter pub get` (Hazlo si descargas el proyecto de nuevo).
*   **Limpiar proyecto**: `flutter clean` (Si algo no compila bien).
*   **Generar Icono**: `flutter pub run flutter_launcher_icons` (Hazlo si cambias el `logo.png`).
*   **Crear APK (Instalación)**: `flutter build apk --release`
*   **Crear AAB (Galaxy Store)**: `flutter build appbundle --release`

---

## ⚙️ Ajustes Frecuentes

### 1. Cambiar la Velocidad y Controles
En `lib/neon_dash_game.dart`:
- **Velocidad**: Busca `update`. `currentSpeed += 20;` -> Cambia el **20** para ajustar la aceleración.
- **Controles**: Soporta **Espacio** y **Flecha Arriba** para saltar en Windows/Web. Se gestiona en `onKeyEvent`.
- **Botón Salir**: Aparece automáticamente solo en Windows/Mac/Linux. Se gestiona en `main.dart`.

### 2. Editar Traducciones
En `lib/neon_dash_game.dart`, busca el mapa `_translations`. Puedes añadir o cambiar palabras ahí tanto para `es` (Español) como para `en` (Inglés).

### 3. Personalización del Jugador
Si quieres añadir un color nuevo al menú, ve a `lib/main.dart` y busca `_colorButton`. Solo tienes que añadir un botón más con el color que quieras.

---

## 📦 Entrega Final
*   **Versión actual**: 1.0.0
*   **Probar y descargar** En este repo y en [itch.io](https://alberto-coder2005.itch.io/neon-dash)

---

*Nota: Todas las dependencias (Flame, Shared Preferences) están configuradas en `pubspec.yaml`. No las borres a menos que sepas qué estás haciendo.*



---

# English Version

🛠️ **Developer Manual — Neon Dash**

This file is a personal guide so you know where everything is and how to edit the game without hassle. **This document is private and for internal use.**

---

## 📌 Quick File Guide

| If you want to change... | Go to this file: |
| :--- | :--- |
| **Score and Speed** | `lib/neon_dash_game.dart` |
| **Player Colors and Shapes** | `lib/components/player.dart` |
| **Obstacles (Types and Frequency)** | `lib/components/obstacle_manager.dart` |
| **Texts and Translations** | `lib/neon_dash_game.dart` (`_translations` map) |
| **Menus (Layout, Buttons)** | `lib/main.dart` |
| **Background and Dynamic Colors** | `lib/components/background.dart` |
| **App Logo** | `assets/images/logo.png` |

---

## 🚀 Useful Terminal Commands

Run them from the project root folder:

*   **Install everything**: `flutter pub get` (Run it if you download the project again.)
*   **Clean project**: `flutter clean` (If something does not build properly.)
*   **Generate icon**: `flutter pub run flutter_launcher_icons` (Run it if you change `logo.png`.)
*   **Build APK (installation)**: `flutter build apk --release`
*   **Build AAB (Galaxy Store)**: `flutter build appbundle --release`

---

## ⚙️ Common Adjustments

### 1. Changing Speed and Controls
In `lib/neon_dash_game.dart`:
- **Speed**: Search for `update`. `currentSpeed += 20;` -> Change **20** to adjust the acceleration.
- **Controls**: Supports **Space** and **Up Arrow** to jump on Windows/Web. Handled in `onKeyEvent`.
- **Quit Button**: Appears automatically only on Windows/Mac/Linux. Handled in `main.dart`.

### 2. Editing Translations
In `lib/neon_dash_game.dart`, find the `_translations` map. You can add or change words there for both `es` (Spanish) and `en` (English).

### 3. Player Customization
If you want to add a new color to the menu, go to `lib/main.dart` and find `_colorButton`. You only need to add one more button with the color you want.

---

## 📦 Final Release
*   **Current version**: 1.0.0
*   **Try and download**: In this repo and on [itch.io](https://alberto-coder2005.itch.io/neon-dash)

---

*Note: All dependencies (Flame, Shared Preferences) are configured in `pubspec.yaml`. Do not delete them unless you know what you are doing.*

