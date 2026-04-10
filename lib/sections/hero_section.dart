import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/gradient_text.dart';
import '../widgets/primary_button.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 700;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 48 : 20, vertical: 40),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _heroText()),
                const SizedBox(width: 40),
                _phoneMockup(),
              ],
            )
          : Column(children: [_heroText(), const SizedBox(height: 32), _phoneMockup()]),
    );
  }

  Widget _heroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.buyerTint,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, size: 16, color: AppColors.buyerGreen),
              SizedBox(width: 6),
              Text(
                'Licensed & Regulated Digital Escrow',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.buyerGreen),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Trusting them so',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: AppColors.dark, height: 1.15),
        ),
        const GradientText("you don't have to.", fontSize: 36),
        const SizedBox(height: 16),
        const Text(
          'The most secure digital escrow for M-Pesa. Protect your payments, secure your sales, and trade with confidence—anywhere in Kenya.',
          style: TextStyle(fontSize: 15, color: AppColors.muted, height: 1.6),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            PrimaryButton(label: 'Join PesaCrow Free', icon: Icons.arrow_forward, onTap: () {}),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Download App'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                side: const BorderSide(color: AppColors.cardBorder),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        // Stats
        Row(
          children: [
            _stat(Icons.trending_up, 'KSh 10M+', 'Secured'),
            const SizedBox(width: 24),
            _stat(Icons.people, '5,000+', 'Deals'),
            const SizedBox(width: 24),
            _stat(Icons.shield, '99%', 'Success'),
          ],
        ),
      ],
    );
  }

  Widget _stat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.buyerGreen, size: 20),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
        Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 11)),
      ],
    );
  }

  Widget _phoneMockup() {
    return Container(
      width: 260,
      height: 500,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(36),
        border: Border.all(color: AppColors.cardBorder, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 40,
            offset: const Offset(0, 16),
          )
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: AppColors.gradientBox(),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PesaCrow', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  SizedBox(height: 4),
                  Text('Deal Secured ✓', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 17)),
                  SizedBox(height: 2),
                  Text('KSh 45,000', style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _mockupRow('Status', 'Funds in Escrow', AppColors.buyerGreen),
                    const SizedBox(height: 10),
                    _mockupRow('Buyer', 'Kevin O.', AppColors.dark),
                    const SizedBox(height: 10),
                    _mockupRow('Seller', 'Sarah M.', AppColors.dark),
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: AppColors.gradientBox(radius: 20),
                      child: const Text(
                        'Release Funds',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mockupRow(String label, String value, Color valueColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDFA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 10)),
          const SizedBox(height: 2),
          Text(value, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: valueColor)),
        ],
      ),
    );
  }
}
