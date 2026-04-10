import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = {
      'Products': ['Personal', 'Business', 'API'],
      'How It Works': ['The Escrow Process', 'FAQ'],
      'Company': ['About Us', 'Careers', 'Contact'],
      'Legal': ['Terms of Service', 'Privacy Policy'],
    };

    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (ctx, c) {
              final isWide = c.maxWidth > 900;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand
                    Expanded(
                      flex: 2,
                      child: _buildBrandInfo(),
                    ),
                    ...columns.entries.map((col) {
                      return Expanded(
                        child: _buildFooterColumn(col.key, col.value),
                      );
                    }),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBrandInfo(),
                  const SizedBox(height: 48),
                  Wrap(
                    spacing: 48,
                    runSpacing: 32,
                    children: columns.entries.map((col) {
                      return SizedBox(
                        width: 140,
                        child: _buildFooterColumn(col.key, col.value),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 64),
          Divider(color: Colors.white.withOpacity(0.05)),
          const SizedBox(height: 32),
          _buildBottomBar(),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms);
  }

  Widget _buildBrandInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/mpesacrowlogo.png',
              height: 32,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            const Text(
              'PesaCrow',
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.w900, 
                fontSize: 22,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'The most secure digital escrow for M-Pesa.',
          style: TextStyle(
            color: AppColors.textSecondary, 
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'support@pesacrow.top\n+254 7XX XXX XXX',
          style: TextStyle(
            color: AppColors.textMuted, 
            fontSize: 13,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterColumn(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 20),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  link,
                  style: TextStyle(
                    color: AppColors.textSecondary, 
                    fontSize: 14,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialIcon(Icons.facebook),
            const SizedBox(width: 20),
            _socialIcon(Icons.camera_alt),
            const SizedBox(width: 20),
            _socialIcon(Icons.chat),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          '© 2026 PesaCrow by A3s. Licensed & Regulated digital escrow agent.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textMuted, 
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white70, size: 20),
    );
  }
}
