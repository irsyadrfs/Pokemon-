import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/pokemon.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Pokemon> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = pokemonList;
    _searchController.addListener(_onSearch);
  }

  void _onSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filtered = pokemonList
          .where((p) =>
              p.name.toLowerCase().contains(query) ||
              p.type.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Color _typeColor(String type) {
    if (type.contains('Fire')) return const Color(0xFFE8603C);
    if (type.contains('Water')) return const Color(0xFF3A84C9);
    if (type.contains('Grass')) return const Color(0xFF3DAD72);
    if (type.contains('Electric')) return const Color(0xFFD4A017);
    if (type.contains('Ghost')) return const Color(0xFF6A5ACD);
    if (type.contains('Dragon')) return const Color(0xFF5B3FDE);
    if (type.contains('Fighting')) return const Color(0xFFC0392B);
    if (type.contains('Psychic')) return const Color(0xFFD63384);
    if (type.contains('Rock')) return const Color(0xFF8B7355);
    if (type.contains('Dark')) return const Color(0xFF3D3B5C);
    if (type.contains('Steel')) return const Color(0xFF6C7A8F);
    if (type.contains('Normal')) return const Color(0xFF7A7A5A);
    if (type.contains('Poison')) return const Color(0xFF8B5CF6);
    return const Color(0xFF6B7280);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Pokedex',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1C1C1E),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Bagus gini masa ngga di kasih nilai gede pak hehe😁',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 13, color: Color(0xFF8E8E93)),
                  ),
                  const SizedBox(height: 16),
                  // ── Search Bar ──
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(
                          fontSize: 15, color: Color(0xFF1C1C1E)),
                      decoration: InputDecoration(
                        hintText: 'Cari nama atau tipe Pokémon...',
                        hintStyle: const TextStyle(
                            color: Color(0xFFAEAEB2), fontSize: 15),
                        prefixIcon: const Icon(Icons.search_rounded,
                            color: Color(0xFFAEAEB2), size: 22),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.cancel_rounded,
                                    color: Color(0xFFAEAEB2), size: 20),
                                onPressed: () => _searchController.clear(),
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),

            // ── Grid ──
            Expanded(
              child: _filtered.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('😢', style: TextStyle(fontSize: 48)),
                          SizedBox(height: 12),
                          Text('Pokémon tidak ditemukan',
                              style: TextStyle(
                                  color: Color(0xFF8E8E93),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                      // Responsive: auto-calculate columns based on screen width
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 220,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.58, // 1.5x taller than before
                      ),
                      itemCount: _filtered.length,
                      itemBuilder: (context, index) {
                        final pokemon = _filtered[index];
                        final color = _typeColor(pokemon.type);
                        return _PokemonGridCard(
                          pokemon: pokemon,
                          color: color,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(pokemon: pokemon),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Hover card widget ──
class _PokemonGridCard extends StatefulWidget {
  final Pokemon pokemon;
  final Color color;
  final VoidCallback onTap;

  const _PokemonGridCard({
    required this.pokemon,
    required this.color,
    required this.onTap,
  });

  @override
  State<_PokemonGridCard> createState() => _PokemonGridCardState();
}

class _PokemonGridCardState extends State<_PokemonGridCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.color;
    final pokemon = widget.pokemon;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: Duration.zero,
            decoration: BoxDecoration(
              color: _hovered ? color.withOpacity(0.08) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: _hovered
                      ? color.withOpacity(0.25)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: _hovered ? 24 : 10,
                  spreadRadius: _hovered ? 1 : 0,
                  offset: _hovered ? const Offset(0, 8) : const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image area — fill card top
                Expanded(
                  flex: 5,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Container(
                      width: double.infinity,
                      color: _hovered
                          ? color.withOpacity(0.18)
                          : color.withOpacity(0.1),
                      child: Image.asset(
                        pokemon.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Center(
                            child: Text('❓', style: TextStyle(fontSize: 52))),
                      ),
                    ),
                  ),
                ),
                // Info area
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          pokemon.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF1C1C1E),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pokemon.type,
                            style: TextStyle(
                                color: color,
                                fontSize: 11,
                                fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}