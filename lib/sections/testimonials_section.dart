import 'package:flutter/material.dart';
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
      color: AppColors.bg,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
      child: Column(
        children: [
          const SectionTitle(prefix: 'What Our ', gradient: 'Users Say'),
          LayoutBuilder(
            builder: (ctx, c) {
              final crossCount = c.maxWidth > 700 ? 3 : 1;
              return GridView.count(
                crossAxisCount: crossCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: crossCount == 1 ? 2.8 : 0.85,
                children: _items.map((t) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.format_quote, color: AppColors.teal.withOpacity(0.3), size: 32),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Text(
                            '"${t['quote']}"',
                            style: const TextStyle(color: AppColors.muted, fontSize: 13, height: 1.6),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(t['name']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                        Text(t['loc']!, style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
