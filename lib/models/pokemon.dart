class Pokemon {
  final String name;
  final String type;
  final String imagePath; // Gunakan aset lokal dari link Drive
  final String description;
  final String role;
  final String stats;
  final String weakness;
  final String partners;

  Pokemon({
    required this.name,
    required this.type,
    required this.imagePath,
    required this.description,
    required this.role,
    required this.stats,
    required this.weakness,
    required this.partners,
  });
}