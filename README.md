# Pokédex- Gallery App 🔴⚡

Una aplicación móvil desarrollada en Flutter que consume la [PokéAPI](https://pokeapi.co/) para buscar y visualizar información detallada de cualquier Pokémon.

## Características Principales

* **Búsqueda Dinámica:** Encuentra cualquier Pokémon introduciendo su nombre exacto en el buscador.
* **Sistema de Temas Personalizado (Dark/Light Mode):**
  * **Modo Claro:** Interfaz inspirada en los colores clásicos de una Pokébola (Rojo y Blanco).
  * **Modo Oscuro:** Diseño elegante con acentos en color Oro y fondo Negro.
* **Estadísticas Detalladas:** Muestra los puntos de experiencia base, altura, peso y un listado de habilidades del Pokémon.
* **Tipos Elementales Visuales:** Etiquetas con colores personalizados que identifican el tipo del Pokémon (Fuego, Agua, Planta, Eléctrico, etc.).
* **Galería Visual Interactiva:**
  * Imagen principal en formato SVG de alta calidad extraída de la categoría `dream_world`.
  * Carrusel de *sprites* horizontal que incluye soporte nativo para reproducir GIFs animados de los modelos de combate (estilo Showdown).

## Tecnologías Utilizadas

* **Framework:** Flutter
* **Lenguaje:** Dart
* **Dependencias:**
  * `http` (^1.2.1) - Para el consumo de la API REST.
  * `flutter_svg` (^2.2.3) - Para el renderizado nativo de gráficos vectoriales.
  * `cupertino_icons` - Iconografía estándar del sistema.

## Estructura del Proyecto

El código fuente principal está organizado de la siguiente manera dentro de la carpeta `lib/`:
* **`models/pokemon.dart`**: Define la estructura de datos y el mapeo del archivo JSON recibido de la API.
* **`services/service_pokemon.dart`**: Maneja la lógica de red y las peticiones HTTP asíncronas para obtener la información.
* **`main.dart`**: Contiene la interfaz de usuario (UI), la gestión de estado para el cambio de temas y la integración del buscador.

## Instalación y Uso Local

Si deseas correr este proyecto en tu entorno local, sigue estos pasos:

1. Clona este repositorio en tu máquina:
   ```bash
   git clone [https://github.com/luisFerHerna/aplicacion_pokemon.git](https://github.com/luisFerHerna/aplicacion_pokemon.git)
   ```
2. Accede al directorio del proyecto:

```bash
cd aplicacion_pokemon
```
3. Descarga las dependencias necesarias de Dart y Flutter:

```bash
flutter pub get
```

4. Ejecuta la aplicación en tu emulador o dispositivo físico conectado:

```bash
flutter run
```
