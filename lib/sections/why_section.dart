import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../widgets/feature_card.dart';
import '../widgets/section_title.dart';

class WhySection extends StatelessWidget {
  const WhySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          const SectionTitle(
            prefix: 'Why ',
            gradient: 'PesaCrow?',
            subtitle: "Built for Kenya's digital economy. The most secure way to buy and sell using M-Pesa.",
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossCount = constraints.maxWidth > 900 ? 4 : (constraints.maxWidth > 600 ? 2 : 1);
              return GridView.count(
                crossAxisCount: crossCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: crossCount == 1 ? 1.5 : 0.85,
                children: [
                  const FeatureCard(
                    icon: Icons.verified_user,
                    title: 'Zero-Trust Security',
                    desc: 'We hold the funds until the deal is done. No more "send money first" anxiety.',
                  ),
                  const FeatureCard(
                    icon: Icons.bolt,
                    title: 'Instant M-Pesa Payouts',
                    desc: 'Once approved, funds hit your wallet, Pochi, Paybill, or Till in seconds.',
                  ),
                  const FeatureCard(
                    icon: Icons.balance,
                    iconColor: AppColors.orange,
                    title: 'Neutral Mediation',
                    desc: 'Our automated dispute resolution protects both buyers and sellers fairly.',
                  ),
                  const FeatureCard(
                    icon: Icons.visibility,
                    iconColor: AppColors.success,
                    title: 'Transparent Fees',
                    desc: 'No hidden charges. See exactly what you pay before you start.',
                  ),
                ]
                .animate(interval: 100.ms)
                .fadeIn(duration: 600.ms, curve: Curves.easeOutQuad)
                .slideY(begin: 0.2, end: 0),
              );
            },
          ),
          const SizedBox(height: 64),
          _trustBar(),
        ],
      ),
    );
  }

  Widget _trustBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Wrap(
        spacing: 40,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: [
          _trustBadge(Icons.security, 'SOC2 Compliant'),
          _trustBadge(Icons.gavel, 'Licensed & Regulated'),
          _trustBadge(Icons.lock, '256-bit Encryption'),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms);
  }

  Widget _trustBadge(IconData icon, String label) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white24),
          const SizedBox(width: 10),
          Text(
            label, 
            style: TextStyle(
              color: Colors.white.withOpacity(0.4), 
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
}
