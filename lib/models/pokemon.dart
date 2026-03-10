class Pokemon {
  final String name;
  final List<String> abilities;
  final String imageURL;
  final int height;
  final int weight;
  final int baseExperience;
  final List<String> sprites;
  final List<String> types;

  Pokemon({
    required this.name,
    required this.abilities,
    required this.imageURL,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.sprites,
    required this.types,
  });

  factory Pokemon.fromJSON(Map<String, dynamic> json) {
    final abilitiesList = (json['abilities'] as List)
        .map((item) => item['ability']['name'] as String)
        .toList();

    final typesList = (json['types'] as List)
        .map((item) => item['type']['name'] as String)
        .toList();

    final image =
        json['sprites']['other']['dream_world']['front_default'] ?? '';

    List<String> spritesList = [];
    final spritesData = json['sprites'];

    if (spritesData['other'] != null &&
        spritesData['other']['showdown'] != null) {
      final showdown = spritesData['other']['showdown'];
      if (showdown['front_default'] != null)
        spritesList.add(showdown['front_default']);
      if (showdown['back_default'] != null)
        spritesList.add(showdown['back_default']);
      if (showdown['front_shiny'] != null)
        spritesList.add(showdown['front_shiny']);
      if (showdown['back_shiny'] != null)
        spritesList.add(showdown['back_shiny']);
    }

    if (spritesData['front_default'] != null)
      spritesList.add(spritesData['front_default']);
    if (spritesData['back_default'] != null)
      spritesList.add(spritesData['back_default']);
    if (spritesData['front_shiny'] != null)
      spritesList.add(spritesData['front_shiny']);
    if (spritesData['back_shiny'] != null)
      spritesList.add(spritesData['back_shiny']);

    return Pokemon(
      name: json['name'],
      abilities: abilitiesList,
      imageURL: image,
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      baseExperience: json['base_experience'] ?? 0,
      sprites: spritesList,
      types: typesList,
    );
  }
}
