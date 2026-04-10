import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/feature_card.dart';
import '../widgets/section_title.dart';

class WhySection extends StatelessWidget {
  const WhySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
      child: Column(
        children: [
          const SectionTitle(
            prefix: 'Why ',
            gradient: 'PesaCrow?',
            subtitle: "Built for Kenya's digital economy. Trusted by thousands.",
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossCount = constraints.maxWidth > 800 ? 4 : (constraints.maxWidth > 500 ? 2 : 1);
              return GridView.count(
                crossAxisCount: crossCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: crossCount == 1 ? 2.8 : 0.95,
                children: const [
                  FeatureCard(
                    icon: Icons.verified_user,
                    title: 'Zero-Trust Security',
                    desc: 'We hold the funds until the deal is done. No more "send money first" anxiety.',
                  ),
                  FeatureCard(
                    icon: Icons.bolt,
                    title: 'Instant M-Pesa Payouts',
                    desc: 'Once approved, funds hit your wallet, Pochi, Paybill, or Till in seconds.',
                  ),
                  FeatureCard(
                    icon: Icons.balance,
                    title: 'Neutral Mediation',
                    desc: 'Our automated dispute resolution protects both buyers and sellers fairly.',
                  ),
                  FeatureCard(
                    icon: Icons.visibility,
                    title: 'Transparent Fees',
                    desc: 'No hidden charges. See exactly what you pay before you start.',
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 24,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _trustBadge('SOC Compliant'),
              _trustBadge('Licensed & Regulated'),
              _trustBadge('256-bit Encryption'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _trustBadge(String label) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.verified_user, size: 14, color: AppColors.teal),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 12)),
        ],
      );
}
