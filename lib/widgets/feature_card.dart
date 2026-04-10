import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final Color? iconColor;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.desc,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final activeIconColor = iconColor ?? AppColors.cyan;
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppColors.cyberCard(radius: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cyber Icon Container
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: activeIconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: activeIconColor.withOpacity(0.2)),
            ),
            child: Icon(icon, color: activeIconColor, size: 24),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800, 
              fontSize: 18,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            desc,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
