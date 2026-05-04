import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../data/mock_data.dart';

class DetailScreen extends StatelessWidget {
  final Pokemon pokemon;
  const DetailScreen({Key? key, required this.pokemon}) : super(key: key);

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

  Map<String, int> _parseStats(String stats) {
    final map = <String, int>{};
    for (final part in stats.split(' | ')) {
      final kv = part.split(': ');
      if (kv.length == 2) {
        final val = int.tryParse(kv[1].trim());
        if (val != null) map[kv[0].trim()] = val;
      }
    }
    return map;
  }

  // Parse "- Name → reason\n- Name → reason" format
  List<Map<String, String>> _parsePartners(String partners) {
    return partners
        .split('\n')
        .where((l) => l.trim().startsWith('-'))
        .map((l) {
          final clean = l.trim().replaceFirst(RegExp(r'^-\s*'), '');
          final idx = clean.indexOf('→');
          if (idx == -1) return {'name': clean.trim(), 'reason': ''};
          return {
            'name': clean.substring(0, idx).trim(),
            'reason': clean.substring(idx + 1).trim(),
          };
        })
        .toList();
  }

  Pokemon? _findPokemon(String partnerName) {
    try {
      return pokemonList.firstWhere(
        (p) => p.name.toLowerCase().contains(partnerName.toLowerCase()),
      );
    } catch (_) {
      return null;
    }
  }

  Widget _sectionCard({
    required String emoji,
    required String title,
    required Color color,
    required Widget child,
    bool gradient = false,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: gradient ? null : Colors.white,
        gradient: gradient
            ? LinearGradient(
                colors: [color.withOpacity(0.18), color.withOpacity(0.04)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradient
                ? color.withOpacity(0.12)
                : Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Center(
                    child: Text(emoji, style: const TextStyle(fontSize: 15))),
              ),
              const SizedBox(width: 10),
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: color)),
            ]),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }

  Widget _statsSection(String stats, Color color) {
    final parsed = _parseStats(stats);
    const maxStat = 160.0;
    const emojis = {
      'HP': '❤️',
      'Atk': '⚔️',
      'Def': '🛡️',
      'Sp. Atk': '✨',
      'Sp. Def': '💎',
      'Speed': '⚡',
    };
    return Column(
      children: parsed.entries.map((e) {
        final ratio = (e.value / maxStat).clamp(0.0, 1.0);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Text(emojis[e.key] ?? '•',
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 6),
                    Text(e.key,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6B7280))),
                  ]),
                  Text('${e.value}',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: color)),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: ratio),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOut,
                  builder: (_, val, __) => LinearProgressIndicator(
                    value: val,
                    backgroundColor: color.withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 10,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _partnerCards(BuildContext context, String partners) {
    final list = _parsePartners(partners);
    return Column(
      children: list.map((p) {
        final found = _findPokemon(p['name']!);
        final pColor = found != null
            ? _typeColor(found.type)
            : const Color(0xFF6B7280);

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _PartnerCard(
            partnerName: p['name']!,
            reason: p['reason']!,
            color: pColor,
            foundPokemon: found,
            onTap: found != null
                ? () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DetailScreen(pokemon: found)),
                    )
                : null,
          ),
        );
      }).toList(),
    );
  }

  Widget _descriptionCard(String description, String role, Color color) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [color.withOpacity(0.18), color.withOpacity(0.04)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 4)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(children: [
          Positioned(
            right: -10,
            bottom: -16,
            child: Text('"',
                style: TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.w900,
                    color: color.withOpacity(0.08),
                    height: 1)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(9)),
                    child: const Center(
                        child: Text('🧠', style: TextStyle(fontSize: 15))),
                  ),
                  const SizedBox(width: 10),
                  Text('Deskripsi',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: color)),
                ]),
                const SizedBox(height: 12),
                Text(description,
                    style: TextStyle(
                        fontSize: 14,
                        color: color.withOpacity(0.85),
                        height: 1.65,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: color.withOpacity(0.25), width: 1),
                  ),
                  child: Text('⚔️  $role',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: color),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = _typeColor(pokemon.type);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 700;

            return Column(
              children: [
                // ── Top Bar ──
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Row(children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 8,
                                offset: const Offset(0, 2))
                          ],
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 16, color: Color(0xFF1C1C1E)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(pokemon.name,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1C1C1E),
                              letterSpacing: -0.3),
                          overflow: TextOverflow.ellipsis),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(pokemon.type,
                          style: TextStyle(
                              color: color,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    ),
                  ]),
                ),

                const SizedBox(height: 12),

                // ── Hero Image ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: isWide ? 400 : 220,
                      width: double.infinity,
                      color: color.withOpacity(0.1),
                      child: Image.asset(
                        pokemon.imagePath,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => const Center(
                            child:
                                Text('❓', style: TextStyle(fontSize: 64))),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ── Scrollable Content ──
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    children: isWide
                        ? _buildWideLayout(context, color)
                        : _buildNarrowLayout(context, color),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Mobile: single column
  List<Widget> _buildNarrowLayout(BuildContext context, Color color) => [
        _descriptionCard(pokemon.description, pokemon.role, color),
        const SizedBox(height: 12),
        _sectionCard(
          emoji: '📊',
          title: 'Base Stats',
          color: const Color(0xFF3DAD72),
          child: _statsSection(pokemon.stats, const Color(0xFF3DAD72)),
        ),
        const SizedBox(height: 12),
        _sectionCard(
          emoji: '⚠️',
          title: 'Weakness',
          color: const Color(0xFFC0392B),
          child: Text(pokemon.weakness,
              style: const TextStyle(
                  fontSize: 14, color: Color(0xFF3C3C43), height: 1.5)),
        ),
        const SizedBox(height: 12),
        _sectionCard(
          emoji: '🤝',
          title: 'Partner Terbaik',
          color: const Color(0xFFE8603C),
          child: _partnerCards(context, pokemon.partners),
        ),
      ];

  // Wide (web/tablet): 2-column layout
  List<Widget> _buildWideLayout(BuildContext context, Color color) => [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _descriptionCard(pokemon.description, pokemon.role, color)),
              const SizedBox(width: 12),
              Expanded(
                child: _sectionCard(
                  emoji: '📊',
                  title: 'Base Stats',
                  color: const Color(0xFF3DAD72),
                  child: _statsSection(pokemon.stats, const Color(0xFF3DAD72)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _sectionCard(
                  emoji: '⚠️',
                  title: 'Weakness',
                  color: const Color(0xFFC0392B),
                  child: Text(pokemon.weakness,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF3C3C43),
                          height: 1.5)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _sectionCard(
                  emoji: '🤝',
                  title: 'Partner Terbaik',
                  color: const Color(0xFFE8603C),
                  child: _partnerCards(context, pokemon.partners),
                ),
              ),
            ],
          ),
        ),
      ];
}

// ── Partner Card (hoverable) ──
class _PartnerCard extends StatefulWidget {
  final String partnerName;
  final String reason;
  final Color color;
  final Pokemon? foundPokemon;
  final VoidCallback? onTap;

  const _PartnerCard({
    required this.partnerName,
    required this.reason,
    required this.color,
    required this.foundPokemon,
    required this.onTap,
  });

  @override
  State<_PartnerCard> createState() => _PartnerCardState();
}

class _PartnerCardState extends State<_PartnerCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.color;
    final found = widget.foundPokemon;

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration.zero,
          decoration: BoxDecoration(
            color: _hovered ? color.withOpacity(0.08) : color.withOpacity(0.04),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hovered ? color.withOpacity(0.4) : color.withOpacity(0.15),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Mini image
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(13)),
                child: Container(
                  width: 58,
                  height: 58,
                  color: color.withOpacity(0.12),
                  padding: const EdgeInsets.all(6),
                  child: found != null
                      ? Image.asset(found.imagePath,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Text('❓'))
                      : const Center(
                          child: Text('❓', style: TextStyle(fontSize: 22))),
                ),
              ),
              const SizedBox(width: 10),
              // Text info
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.partnerName,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: color),
                      ),
                      if (widget.reason.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          widget.reason,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B7280),
                              height: 1.4),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              // Arrow indicator if clickable
              if (widget.onTap != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.arrow_forward_ios_rounded,
                      size: 13, color: color.withOpacity(0.5)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}