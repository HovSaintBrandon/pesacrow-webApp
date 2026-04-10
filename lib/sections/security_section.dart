import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../widgets/section_title.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.lock, 'title': '256-bit Encryption', 'desc': 'System-wide bank-grade encryption for all transactions.'},
      {'icon': Icons.key, 'title': 'Multi-Factor Auth', 'desc': 'OTP-based authentication for every critical action.'},
      {'icon': Icons.handshake, 'title': 'Safaricom Daraja Partner', 'desc': "Official integration with Safaricom's M-Pesa platform."},
    ];

    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          const SectionTitle(
            prefix: 'Security ', 
            gradient: 'First',
            subtitle: 'We use industry-leading security protocols to keep your funds and data safe.',
          ),
          LayoutBuilder(
            builder: (ctx, c) {
              final isWide = c.maxWidth > 900;
              final crossCount = isWide ? 3 : 1;
              return GridView.count(
                crossAxisCount: crossCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: crossCount == 1 ? 1.4 : 1.0,
                children: items.map((b) {
                  return Container(
                    padding: const EdgeInsets.all(32),
                    decoration: AppColors.cyberCard(radius: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 64,
                          width: 64,
                          decoration: BoxDecoration(
                            color: AppColors.cyan.withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.cyan.withOpacity(0.3)),
                          ),
                          child: Icon(b['icon'] as IconData, color: AppColors.cyan, size: 28),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          b['title'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          b['desc'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.5),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.9, 0.9));
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
