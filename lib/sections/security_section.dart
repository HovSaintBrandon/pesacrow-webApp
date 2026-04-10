import 'package:flutter/material.dart';
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
      color: AppColors.bg,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
      child: Column(
        children: [
          const SectionTitle(prefix: 'Security ', gradient: 'First'),
          LayoutBuilder(
            builder: (ctx, c) {
              final crossCount = c.maxWidth > 700 ? 3 : 1;
              return GridView.count(
                crossAxisCount: crossCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: crossCount == 1 ? 3.2 : 1.0,
                children: items.map((b) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 52,
                          width: 52,
                          decoration: AppColors.gradientBox(radius: 26),
                          child: Icon(b['icon'] as IconData, color: Colors.white, size: 26),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          b['title'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          b['desc'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.muted, fontSize: 12, height: 1.4),
                        ),
                      ],
                    ),
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
