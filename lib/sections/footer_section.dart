import 'package:flutter/material.dart';
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
      color: AppColors.dark,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (ctx, c) {
              if (c.maxWidth > 600) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(
                                image: AssetImage('assets/mpesacrowlogo.png'),
                                height: 28,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'PesaCrow',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'The most secure digital escrow for M-Pesa.',
                            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'support@pesacrow.top\n+254 7XX XXX XXX',
                            style: TextStyle(color: Colors.white.withOpacity(0.35), fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    ...columns.entries.map((col) {
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              col.key,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...col.value.map((link) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    link,
                                    style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
                                  ),
                                )),
                          ],
                        ),
                      );
                    }),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: AssetImage('assets/mpesacrowlogo.png'),
                        height: 28,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'PesaCrow',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 32,
                    runSpacing: 24,
                    children: columns.entries.map((col) {
                      return SizedBox(
                        width: 140,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              col.key,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ...col.value.map((link) => Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Text(
                                    link,
                                    style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
                                  ),
                                )),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 32),
          Divider(color: Colors.white.withOpacity(0.08)),
          const SizedBox(height: 16),
          Text(
            '© 2026 PesaCrow by A3s. Licensed & Regulated digital escrow agent.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 11),
          ),
        ],
      ),
    );
  }
}
