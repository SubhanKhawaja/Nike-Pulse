import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../state/app_state.dart';

class PromoCodeInput extends StatefulWidget {
  const PromoCodeInput({super.key});

  @override
  State<PromoCodeInput> createState() => _PromoCodeInputState();
}

class _PromoCodeInputState extends State<PromoCodeInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _apply(AppState state) {
    final code = _controller.text.trim();
    if (code.isEmpty) return;

    final success = state.cartController.applyPromoCode(code);
    if (!mounted) return;

    if (success) {
      _controller.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Promo code $code applied successfully! 20% OFF'),
          backgroundColor: AppColors.success,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid code. Try NIKE20 or JUSTDOIT'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final appliedCode = appState.cartController.appliedPromoCode;

    if (appliedCode != null) {
      return _AppliedPromoBadge(
        code: appliedCode,
        onRemove: () => appState.cartController.removePromoCode(),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                hintText: 'Enter Promo Code (e.g. NIKE20)',
                prefixIcon: Icon(Icons.confirmation_number_outlined, size: 20),
                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => _apply(appState),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}

class _AppliedPromoBadge extends StatelessWidget {
  final String code;
  final VoidCallback onRemove;

  const _AppliedPromoBadge({required this.code, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.success.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.success.withAlpha(80)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20),
              const SizedBox(width: 8),
              Text(
                'Code $code Applied (20% Off)',
                style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Tooltip(
            message: 'Remove promo code',
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onRemove,
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.close_rounded, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
