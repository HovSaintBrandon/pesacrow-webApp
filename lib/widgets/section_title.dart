import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'gradient_text.dart';

class SectionTitle extends StatelessWidget {
  final String prefix;
  final String gradient;
  final String? subtitle;
  final CrossAxisAlignment align;
  
  const SectionTitle({
    super.key,
    required this.prefix,
    required this.gradient,
    this.subtitle,
    this.align = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final textAlign = align == CrossAxisAlignment.center ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      children: [
        Wrap(
          alignment: align == CrossAxisAlignment.center ? WrapAlignment.center : WrapAlignment.start,
          children: [
            Text(
              prefix,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
                letterSpacing: -1,
              ),
            ),
            GradientText(gradient, fontSize: 36, fontWeight: FontWeight.w900),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          SizedBox(
            width: 600,
            child: Text(
              subtitle!,
              textAlign: textAlign,
              style: const TextStyle(
                color: AppColors.textSecondary, 
                fontSize: 16,
                height: 1.6,
              ),
            ),
          ),
        ],
        const SizedBox(height: 48),
      ],
    );
  }
}
