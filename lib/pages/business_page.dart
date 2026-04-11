import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/gradient_text.dart';

class BusinessPage extends StatelessWidget {
  const BusinessPage({super.key});

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
        title: const GradientText('PesaCrow Business', fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.business_center, size: 80, color: AppColors.cyan.withOpacity(0.5)),
            const SizedBox(height: 24),
            const Text(
              'Business Solutions',
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Coming Soon',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 18),
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.cyan.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                'Powering Kenyan Enterprises',
                style: TextStyle(color: AppColors.cyan, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
