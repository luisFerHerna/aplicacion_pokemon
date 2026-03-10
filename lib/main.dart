import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gallery_app/services/service_pokemon.dart';
import 'models/pokemon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex App',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Colors.red,
          secondary: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          elevation: 5,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Colors.amber,
          secondary: Colors.amberAccent,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.amber,
          elevation: 5,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
          ),
        ),
      ),
      home: PokemonScreen(toggleTheme: _toggleTheme),
    );
  }
}

class PokemonScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  const PokemonScreen({super.key, required this.toggleTheme});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final TextEditingController _controller = TextEditingController();
  final ServicePokemon _servicePokemon = ServicePokemon();

  Future<Pokemon>? _futurePokemon;

  void _buscarPokemon() {
    if (_controller.text.isEmpty) return;

    setState(() {
      _futurePokemon = _servicePokemon.fetchPokemon(_controller.text.trim());
    });
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.orange;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.yellow.shade700;
      case 'ice':
        return Colors.cyan;
      case 'fighting':
        return Colors.red.shade900;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown.shade400;
      case 'flying':
        return Colors.indigo.shade300;
      case 'psychic':
        return Colors.pinkAccent;
      case 'bug':
        return Colors.lightGreen;
      case 'rock':
        return Colors.brown;
      case 'ghost':
        return Colors.deepPurple;
      case 'dragon':
        return Colors.deepPurpleAccent;
      case 'dark':
        return Colors.grey.shade800;
      case 'steel':
        return Colors.blueGrey;
      case 'fairy':
        return Colors.pink.shade200;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pokédex App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nombre del Pokémon",
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (_) => _buscarPokemon(),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _buscarPokemon,
              child: const Text(
                "Buscar Pokémon",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(height: 20),

            Expanded(
              child: _futurePokemon == null
                  ? const Center(
                      child: Text(
                        "Ingresa un nombre para comenzar la búsqueda.",
                      ),
                    )
                  : FutureBuilder<Pokemon>(
                      future: _futurePokemon,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Pokémon no encontrado.",
                              style: TextStyle(color: colorScheme.error),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          final pokemon = snapshot.data!;

                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  pokemon.name.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(height: 10),

                                Wrap(
                                  spacing: 8.0,
                                  children: pokemon.types.map((type) {
                                    return Chip(
                                      label: Text(
                                        type.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      backgroundColor: _getTypeColor(type),
                                      side: BorderSide.none,
                                    );
                                  }).toList(),
                                ),

                                const SizedBox(height: 20),
                                pokemon.imageURL.isNotEmpty
                                    ? SvgPicture.network(
                                        pokemon.imageURL,
                                        height: 180,
                                      )
                                    : const Icon(
                                        Icons.image_not_supported,
                                        size: 100,
                                      ),

                                const SizedBox(height: 20),
                                const Text(
                                  "Sprites",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 100,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: pokemon.sprites.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        child: Image.network(
                                          pokemon.sprites[index],
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.contain,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),

                                Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            _buildStatBadge(
                                              "Altura",
                                              "${pokemon.height / 10} m",
                                              colorScheme,
                                            ),
                                            _buildStatBadge(
                                              "Peso",
                                              "${pokemon.weight / 10} kg",
                                              colorScheme,
                                            ),
                                            _buildStatBadge(
                                              "Exp. Base",
                                              "${pokemon.baseExperience}",
                                              colorScheme,
                                            ),
                                          ],
                                        ),
                                        const Divider(height: 30),
                                        const Text(
                                          "Habilidades",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Wrap(
                                          spacing: 8.0,
                                          children: pokemon.abilities.map((
                                            ability,
                                          ) {
                                            return Chip(
                                              label: Text(
                                                ability.toUpperCase(),
                                              ),
                                              backgroundColor: colorScheme
                                                  .primary
                                                  .withOpacity(0.2),
                                              labelStyle: TextStyle(
                                                color: colorScheme.primary,
                                              ),
                                              side: BorderSide.none,
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: widget.toggleTheme,
        tooltip: isDarkMode ? 'Cambiar a Claro' : 'Cambiar a Oscuro',
        child: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
      ),
    );
  }

  Widget _buildStatBadge(String label, String value, ColorScheme colorScheme) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
