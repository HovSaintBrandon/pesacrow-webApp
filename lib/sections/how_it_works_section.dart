import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          const SectionTitle(
            prefix: 'Secure Trading in ',
            gradient: '5 Simple Steps',
            subtitle: 'From creating a deal to getting paid—it takes minutes, not days.',
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 900;
              if (isWide) {
                return _buildHorizontalSteps();
              }
              return _buildVerticalSteps();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalSteps() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(_steps.length, (i) {
        return Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Connecting Line
              if (i < _steps.length - 1)
                Positioned(
                  top: 30,
                  left: 60,
                  right: -60,
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.cyan.withOpacity(0.3), Colors.transparent],
                      ),
                    ),
                  ).animate(delay: (i * 200).ms).shimmer(duration: 2.seconds),
                ),
              
              Column(
                children: [
                   _stepCircle(i)
                      .animate(delay: (i * 200).ms)
                      .fadeIn()
                      .scale(),
                  const SizedBox(height: 24),
                  Text(
                    _steps[i]['title'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800, 
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      _steps[i]['desc'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.textSecondary, 
                        fontSize: 12, 
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildVerticalSteps() {
    return Column(
      children: List.generate(_steps.length, (i) {
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _stepCircle(i),
                  if (i < _steps.length - 1)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: AppColors.cyan.withOpacity(0.2),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _steps[i]['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800, 
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _steps[i]['desc'] as String,
                        style: const TextStyle(
                          color: AppColors.textSecondary, 
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ).animate(delay: (i * 100).ms).fadeIn().slideX(begin: 0.1, end: 0);
      }),
    );
  }

  Widget _stepCircle(int i) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.cyan.withOpacity(0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyan.withOpacity(0.2),
            blurRadius: 12,
          ),
        ],
      ),
      child: Center(
        child: Text(
          '${i + 1}',
          style: const TextStyle(
            color: Colors.white, 
            fontSize: 20, 
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
