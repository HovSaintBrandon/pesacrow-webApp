import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          const SectionTitle(
            prefix: 'Simple, ',
            gradient: 'Transparent Pricing',
            subtitle: 'No hidden charges. What you see is what you pay.',
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 700),
            decoration: AppColors.cyberCard(radius: 24),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: const Row(
                    children: [
                      Expanded(child: Text('SERVICE', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1, color: Colors.white70))),
                      Expanded(child: Text('FEE', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1, color: Colors.white70))),
                    ],
                  ),
                ),
                ..._rows.asMap().entries.map((e) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05), width: 1)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            e.value[0], 
                            style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            e.value[1], 
                            style: const TextStyle(
                              fontSize: 14, 
                              fontWeight: FontWeight.w800, 
                              color: AppColors.cyan,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate(delay: (e.key * 100).ms).fadeIn().slideX(begin: 0.05, end: 0);
                }),
                Padding(
                  padding: const EdgeInsets.all(24),
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
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white.withOpacity(0.2)),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.95, 0.95)),
        ],
      ),
    );
  }
}
