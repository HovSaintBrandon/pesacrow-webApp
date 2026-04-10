import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../widgets/feature_card.dart';
import '../widgets/section_title.dart';

class AudienceSection extends StatelessWidget {
  const AudienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.storefront, 'title': 'The Social Seller', 'desc': 'Sell on WhatsApp, Instagram, or TikTok with trust.', 'color': AppColors.electricBlue},
      {'icon': Icons.monitor, 'title': 'The High-Value Buyer', 'desc': 'Ensure you get exactly what you paid for.', 'color': AppColors.cyan},
      {'icon': Icons.palette, 'title': 'The Gig Worker', 'desc': 'Secure payment before you start the work.', 'color': AppColors.accentGold},
      {'icon': Icons.apartment, 'title': 'The Small Business', 'desc': 'Manage cash flow safely and professionally.', 'color': AppColors.success},
    ];

    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          const SectionTitle(
            prefix: 'Who is PesaCrow ', 
            gradient: 'for?',
            subtitle: 'Different solutions for different needs, all secured by M-Pesa.',
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (ctx, c) {
              final crossCount = c.maxWidth > 900 ? 4 : (c.maxWidth > 600 ? 2 : 1);
              return GridView.count(
                crossAxisCount: crossCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: crossCount == 1 ? 1.6 : 0.85,
                children: items.map((a) {
                  return FeatureCard(
                    icon: a['icon'] as IconData,
                    title: a['title'] as String,
                    desc: a['desc'] as String,
                    iconColor: a['color'] as Color,
                  );
                }).toList()
                .animate(interval: 100.ms)
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.1, end: 0),
              );
            },
          ),
        ],
      ),
    );
  }
}
