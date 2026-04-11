import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/gradient_text.dart';

class APIPage extends StatelessWidget {
  const APIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const GradientText('PesaCrow Developer Hub', fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.engineering, size: 100, color: AppColors.orange.withOpacity(0.8)),
            const SizedBox(height: 32),
            const Text(
              'Coming Soon for Developers',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -0.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'APIs under construction check back later',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 18),
            ),
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.orange.withOpacity(0.1),
                border: Border.all(color: AppColors.orange.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning_amber_rounded, color: AppColors.orange, size: 20),
                  const SizedBox(width: 12),
                  const Text(
                    'Sandboxed environments are preparing...',
                    style: TextStyle(color: AppColors.orange, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
