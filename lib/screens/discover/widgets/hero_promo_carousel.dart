import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class HeroPromoCarousel extends StatelessWidget {
  final VoidCallback onShopNow;

  const HeroPromoCarousel({super.key, required this.onShopNow});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1556906781-9a412961c28c?w=1200&auto=format&fit=crop&q=80',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.black.withAlpha(50),
                Colors.black.withAlpha(220),
              ],
            ),
          ),
          padding: const EdgeInsets.all(22),
          child: _HeroPromoContent(onShopNow: onShopNow),
        ),
      ),
    );
  }
}

class _HeroPromoContent extends StatelessWidget {
  final VoidCallback onShopNow;

  const _HeroPromoContent({required this.onShopNow});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildBadge(),
        const SizedBox(height: 8),
        const Text(
          'FEEL THE UNREAL',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Air Max Dn8 with dynamic dual-chamber tubes.',
          style: TextStyle(color: Colors.white70, fontSize: 13),
        ),
        const SizedBox(height: 12),
        _buildShopButton(),
      ],
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.accentVolt,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        'JUST DROPPED',
        style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.w900),
      ),
    );
  }

  Widget _buildShopButton() {
    return ElevatedButton(
      onPressed: onShopNow,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: const Text('Shop Drop', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
    );
  }
}
