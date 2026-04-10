import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../pages/faq_page.dart';
import '../pages/terms_page.dart';
import '../pages/privacy_page.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback? onLogoTap;
  const FooterSection({super.key, this.onLogoTap});

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
                        child: _buildFooterColumn(context, col.key, col.value),
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
                        child: _buildFooterColumn(context, col.key, col.value),
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
        GestureDetector(
          onTap: onLogoTap,
          child: MouseRegion(
            cursor: onLogoTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
            child: Row(
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
          ),
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

  Widget _buildFooterColumn(BuildContext context, String title, List<String> links) {
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
              child: InkWell(
                onTap: () => _handleLinkClick(context, link),
                borderRadius: BorderRadius.circular(4),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    link,
                    style: const TextStyle(
                      color: AppColors.textSecondary, 
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  void _handleLinkClick(BuildContext context, String link) {
    if (link == 'FAQ') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FAQPage()),
      );
    } else if (link == 'Terms of Service') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TermsPage()),
      );
    } else if (link == 'Privacy Policy') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PrivacyPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"$link" page coming soon!'),
          duration: const Duration(seconds: 2),
          backgroundColor: AppColors.surface,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
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
