import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/section_title.dart';
import '../widgets/fee_calculator_dialog.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  static const _rows = [
    ['Joining a Deal', 'Free'],
    ['Creating a Deal', 'From KSh 20'],
    ['Escrow Fee', '1.5% - 2.0% (Tiered)'],
    ['Refunds', 'Fully Refunded (minus M-Pesa costs)'],
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
      child: Column(
        children: [
          const SectionTitle(
            prefix: 'Simple, ',
            gradient: 'Transparent Pricing',
            subtitle: 'No hidden charges. What you see is what you pay.',
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: const BoxDecoration(
                    color: AppColors.bg,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: const Row(
                    children: [
                      Expanded(child: Text('Service', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13))),
                      Expanded(child: Text('Fee', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13))),
                    ],
                  ),
                ),
                ..._rows.asMap().entries.map((e) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    color: e.key.isOdd ? AppColors.bg.withOpacity(0.5) : null,
                    child: Row(
                      children: [
                        Expanded(child: Text(e.value[0], style: const TextStyle(fontSize: 13))),
                        Expanded(child: Text(e.value[1], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.buyerGreen))),
                      ],
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const FeeCalculatorDialog(),
                      );
                    },
                    icon: const Icon(Icons.calculate, size: 18),
                    label: const Text('Use Fee Calculator'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.buyerGreen,
                      side: const BorderSide(color: AppColors.buyerGreen),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
