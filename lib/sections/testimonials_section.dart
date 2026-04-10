import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../widgets/section_title.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  static const _items = [
    {
      'quote': 'I used to be terrified of buying phones on Jiji. PesaCrow changed that. Now I only pay when the item is in my hand.',
      'name': 'Kevin O.',
      'loc': 'Nairobi'
    },
    {
      'quote': 'As a freelance designer, I no longer have to chase clients for payment. The money is there before I even open Photoshop.',
      'name': 'Sarah M.',
      'loc': 'Kisumu'
    },
    {
      'quote': 'PesaCrow has transformed how we handle transactions with our suppliers. Professional and seamless.',
      'name': 'James K.',
      'loc': 'Mombasa'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          const SectionTitle(
            prefix: 'What Our ', 
            gradient: 'Users Say',
            subtitle: 'Real stories from real users securing their trade in Kenya.',
          ),
          LayoutBuilder(
            builder: (ctx, c) {
              final crossCount = c.maxWidth > 900 ? 3 : 1;
              return GridView.count(
                crossAxisCount: crossCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: crossCount == 1 ? 1.4 : 0.85,
                children: _items.map((t) {
                  return Container(
                    padding: const EdgeInsets.all(32),
                    decoration: AppColors.cyberCard(radius: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.format_quote, color: AppColors.cyan.withOpacity(0.3), size: 40),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Text(
                            '"${t['quote']}"',
                            style: const TextStyle(
                              color: AppColors.textSecondary, 
                              fontSize: 15, 
                              height: 1.6,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.surfaceLight,
                              radius: 20,
                              child: Text(t['name']![0], style: const TextStyle(color: AppColors.cyan, fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t['name']!, 
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.white),
                                ),
                                Text(
                                  t['loc']!, 
                                  style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList()
                .animate(interval: 150.ms)
                .fadeIn(duration: 600.ms)
                .slideX(begin: 0.1, end: 0),
              );
            },
          ),
        ],
      ),
    );
  }
}
