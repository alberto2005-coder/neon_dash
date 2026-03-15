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

### 1. Cambiar la Velocidad
En `lib/neon_dash_game.dart`, busca la función `update`. 
- `currentSpeed += 20;` -> Cambia el **20** para que acelere más o menos cada 5 segundos.

### 2. Editar Traducciones
En `lib/neon_dash_game.dart`, busca el mapa `_translations`. Puedes añadir o cambiar palabras ahí tanto para `es` (Español) como para `en` (Inglés).

### 3. Personalización del Jugador
Si quieres añadir un color nuevo al menú, ve a `lib/main.dart` y busca `_colorButton`. Solo tienes que añadir un botón más con el color que quieras.

---

## 📦 Entrega Final
*   **Versión actual**: 1.0.0
*   **Ubicación APK**: `build/app/outputs/flutter-apk/app-release.apk`
*   **Ubicación AAB**: `build/app/outputs/bundle/release/app-release.aab`

---

*Nota: Todas las dependencias (Flame, Shared Preferences) están configuradas en `pubspec.yaml`. No las borres a menos que sepas qué estás haciendo.*
