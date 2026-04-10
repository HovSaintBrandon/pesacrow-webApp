import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/feature_card.dart';
import '../widgets/section_title.dart';

class FeaturesSection extends StatefulWidget {
  const FeaturesSection({super.key});

  @override
  State<FeaturesSection> createState() => _FeaturesSectionState();
}

class _FeaturesSectionState extends State<FeaturesSection> {
  int _tab = 0;

  static const _tabs = ['Personal', 'Business', 'Developers'];
  static const _data = [
    [
      {'icon': Icons.send, 'title': 'Secure Send/Receive', 'desc': 'Pay for goods from Facebook, Instagram, or Jiji without risk.'},
      {'icon': Icons.credit_card, 'title': 'Custom Payouts', 'desc': 'Choose where your money goes—wallet, Pochi, or Paybill.'},
      {'icon': Icons.people, 'title': 'Multi-Role Flexibility', 'desc': 'Switch between Buyer and Seller for different deals.'},
    ],
    [
      {'icon': Icons.receipt_long, 'title': 'Professional Invoicing', 'desc': 'Create branded deal links for your clients.'},
      {'icon': Icons.fact_check, 'title': 'Proof of Delivery', 'desc': 'Upload delivery notes and photos to get paid faster.'},
      {'icon': Icons.business_center, 'title': 'B2B Payouts', 'desc': 'Send earnings to your Business Paybill or Till Number.'},
    ],
    [
      {'icon': Icons.code, 'title': 'PesaCrow API', 'desc': 'Integrate escrow into your platform with our REST API.'},
      {'icon': Icons.webhook, 'title': 'Webhooks', 'desc': 'Get real-time notifications for every deal state change.'},
      {'icon': Icons.store, 'title': 'Marketplace Ready', 'desc': 'Build escrow-powered marketplaces with our SDKs.'},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
      child: Column(
        children: [
          const SectionTitle(
            prefix: 'Built for ',
            gradient: 'Everyone',
            subtitle: "Whether you're a buyer, seller, business, or developer—PesaCrow has you covered.",
          ),
          // Tab bar
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                final selected = _tab == i;
                return GestureDetector(
                  onTap: () => setState(() => _tab = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: selected ? AppColors.gradientBox(radius: 20) : null,
                    child: Text(
                      _tabs[i],
                      style: TextStyle(
                        color: selected ? Colors.white : AppColors.muted,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossCount = constraints.maxWidth > 700 ? 3 : 1;
              return GridView.count(
                crossAxisCount: crossCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: crossCount == 1 ? 3.0 : 1.1,
                children: _data[_tab].map((f) {
                  return FeatureCard(
                    icon: f['icon'] as IconData,
                    title: f['title'] as String,
                    desc: f['desc'] as String,
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
