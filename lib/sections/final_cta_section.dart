import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';

class FinalCTASection extends StatelessWidget {
  const FinalCTASection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: AppColors.teal.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: AppColors.brandGreen.withOpacity(0.05),
              blurRadius: 100,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              'Ready to Make Smarter\nMoney Moves?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w900,
                height: 1.1,
                letterSpacing: -1.5,
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 24),
            const Text(
              'Join thousands of Kenyans securing their future trade today.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary, 
                fontSize: 18,
              ),
            ).animate(delay: 200.ms).fadeIn(),
            const SizedBox(height: 48),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _buildCTAButton(
                  'Transact Online',
                  Icons.language,
                  true,
                  onTap: () => launchUrl(Uri.parse('https://app.pesacrow.top/#/')),
                ),
                _buildCTAButton(
                  'Download the App',
                  Icons.android, 
                  false,
                  onTap: () => launchUrl(Uri.parse('https://github.com/HovSaintBrandon/PesaCrow-Privacy-Policy/releases/download/VERSION1/app-release.apk')),
                ),
                _buildCTAButton(
                  'Join Beta Access',
                  Icons.rocket_launch,
                  false,
                  onTap: () => launchUrl(Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLSeBbWMLBJmOuPQ3tbE14jR9o51EQfYUUAjpfnw6YJubXtwOiA/viewform?usp=dialog')),
                ),
              ],
            ).animate(delay: 400.ms).fadeIn().scale(),
          ],
        ),
      ).animate().shimmer(delay: 2.seconds, duration: 2.seconds, color: AppColors.teal.withOpacity(0.1)),
    );
  }

  Widget _buildCTAButton(String label, IconData icon, bool primary, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          decoration: BoxDecoration(
            color: primary ? AppColors.brandGreen : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: primary ? null : Border.all(color: Colors.white.withOpacity(0.2)),
            boxShadow: primary ? [
              BoxShadow(
                color: AppColors.brandGreen.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ] : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
