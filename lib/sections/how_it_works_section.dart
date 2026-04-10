import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/section_title.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  static const _steps = [
    {'icon': Icons.description, 'title': 'Create a Deal', 'desc': 'Enter the amount and a short description.'},
    {'icon': Icons.phone_android, 'title': 'Buyer Pays', 'desc': 'Buyer receives an M-Pesa STK push and confirms.'},
    {'icon': Icons.lock, 'title': 'Funds Held', 'desc': 'PesaCrow holds the money securely in escrow.'},
    {'icon': Icons.local_shipping, 'title': 'Delivery', 'desc': 'Seller delivers the product or service.'},
    {'icon': Icons.check_circle, 'title': 'Release & Payout', 'desc': 'Buyer approves, funds are instantly released.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
      child: Column(
        children: [
          const SectionTitle(
            prefix: 'Secure Trading in ',
            gradient: '5 Simple Steps',
            subtitle: 'From creating a deal to getting paid—it takes minutes, not days.',
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 700) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(_steps.length, (i) {
                    return Expanded(
                      child: Column(
                        children: [
                          _stepCircle(i),
                          const SizedBox(height: 12),
                          Text(
                            _steps[i]['title'] as String,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _steps[i]['desc'] as String,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: AppColors.muted, fontSize: 11, height: 1.4),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              }
              return Column(
                children: List.generate(_steps.length, (i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        _stepCircle(i),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _steps[i]['title'] as String,
                                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _steps[i]['desc'] as String,
                                style: const TextStyle(color: AppColors.muted, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _stepCircle(int i) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: AppColors.gradientBox(radius: 28),
          child: Icon(_steps[i]['icon'] as IconData, color: Colors.white, size: 26),
        ),
        Positioned(
          top: -6,
          right: -6,
          child: Container(
            height: 22,
            width: 22,
            decoration: const BoxDecoration(color: AppColors.purple, shape: BoxShape.circle),
            child: Center(
              child: Text(
                '${i + 1}',
                style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
