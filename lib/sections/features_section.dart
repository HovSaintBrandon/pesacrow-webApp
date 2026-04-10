import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          const SectionTitle(
            prefix: 'Built for ',
            gradient: 'Everyone',
            subtitle: "Whether you're a buyer, seller, business, or developer—PesaCrow has you covered.",
          ),
          
          // Custom Tab Bar
          _buildTabBar(),
          
          const SizedBox(height: 48),
          
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 900;
              final crossCount = isWide ? 3 : 1;
              
              return GridView.count(
                key: ValueKey(_tab), // Key triggers animation on tab switch
                crossAxisCount: crossCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: crossCount == 1 ? 1.4 : 1.1,
                children: _data[_tab].map((f) {
                  return FeatureCard(
                    icon: f['icon'] as IconData,
                    title: f['title'] as String,
                    desc: f['desc'] as String,
                  );
                }).toList()
                .animate(interval: 100.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.1, end: 0),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          final selected = _tab == i;
          return GestureDetector(
            onTap: () => setState(() => _tab = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: selected ? AppColors.cyan : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
                boxShadow: selected ? [
                  BoxShadow(
                    color: AppColors.cyan.withOpacity(0.3),
                    blurRadius: 10,
                  )
                ] : null,
              ),
              child: Text(
                _tabs[i],
                style: TextStyle(
                  color: selected ? Colors.white : AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
