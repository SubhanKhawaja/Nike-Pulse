import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class BannerDealCard extends StatelessWidget {
  final VoidCallback onClaimDeal;

  const BannerDealCard({super.key, required this.onClaimDeal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.accentOrange,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Expanded(child: _DealTextContent()),
          ElevatedButton(
            onPressed: onClaimDeal,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.accentOrange,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Use Code', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}

class _DealTextContent extends StatelessWidget {
  const _DealTextContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'MEMBER SPECIAL',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w800,
            fontSize: 11,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '20% OFF EXTRA',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 22,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Use code NIKE20 at checkout',
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
      ],
    );
  }
}
