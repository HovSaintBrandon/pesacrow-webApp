import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'gradient_text.dart';

class SectionTitle extends StatelessWidget {
  final String prefix;
  final String gradient;
  final String? subtitle;
  
  const SectionTitle({
    super.key,
    required this.prefix,
    required this.gradient,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              prefix,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.dark,
              ),
            ),
            GradientText(gradient, fontSize: 28),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.muted, fontSize: 14),
          ),
        ],
        const SizedBox(height: 32),
      ],
    );
  }
}
