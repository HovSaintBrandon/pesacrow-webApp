import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/feature_card.dart';
import '../widgets/section_title.dart';

class AudienceSection extends StatelessWidget {
  const AudienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.storefront, 'title': 'The Social Seller', 'desc': 'Sell on WhatsApp, Instagram, or TikTok with trust.', 'color': AppColors.sellerBlue},
      {'icon': Icons.monitor, 'title': 'The High-Value Buyer', 'desc': 'Ensure you get exactly what you paid for.', 'color': AppColors.buyerGreen},
      {'icon': Icons.palette, 'title': 'The Gig Worker', 'desc': 'Secure payment before you start the work.', 'color': AppColors.warning},
      {'icon': Icons.apartment, 'title': 'The Small Business', 'desc': 'Manage cash flow safely and professionally.', 'color': AppColors.success},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
      child: Column(
        children: [
          const SectionTitle(prefix: 'Who is PesaCrow ', gradient: 'for?'),
          LayoutBuilder(
            builder: (ctx, c) {
              final crossCount = c.maxWidth > 800 ? 4 : (c.maxWidth > 500 ? 2 : 1);
              return GridView.count(
                crossAxisCount: crossCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: crossCount == 1 ? 3.0 : 1.0,
                children: items.map((a) {
                  final c = a['color'] as Color;
                  return FeatureCard(
                    icon: a['icon'] as IconData,
                    title: a['title'] as String,
                    desc: a['desc'] as String,
                    iconBg: c.withOpacity(0.12),
                    iconColor: c,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
