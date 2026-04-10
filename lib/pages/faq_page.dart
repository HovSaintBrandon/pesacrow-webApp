import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../widgets/section_title.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        'q': 'What is PesaCrow?',
        'a': 'PesaCrow is a digital escrow platform that secures your payments when buying or selling with strangers. We hold the buyer\'s money until they confirm they\'ve received the item, then we release it to the seller.\n\nTrusting them so you don\'t have to.'
      },
      {
        'q': 'How do I pay for a deal?',
        'a': 'Once a deal is created, the Buyer will receive an sms from M-Pesa STK Push on their phone. Simply enter your M-Pesa PIN, and the funds will be securely moved to the PesaCrow escrow account.'
      },
      {
        'q': 'When does the Seller get paid?',
        'a': 'The Seller is paid immediately after the Buyer approves the deal on the PesaCrow platform. If the Buyer is happy with the product, they click "Approve," and the funds are sent to the Seller\'s M-Pesa wallet.'
      },
      {
        'q': 'What happens if I don\'t receive my item?',
        'a': 'If the Seller fails to deliver, the Buyer can raise a dispute. Our team will investigate, and if the Seller cannot provide proof of delivery, the funds will be returned to the Buyer.'
      },
      {
        'q': 'What are the fees?',
        'a': 'PesaCrow charges a small service fee to cover the security and infrastructure costs. You can use our "Fee Calculator" within the app to see the exact breakdown before starting a deal.'
      },
      {
        'q': 'Can I cancel a deal?',
        'a': 'Yes, a deal can be cancelled by the Seller if they haven\'t started delivery, or by mutual agreement.\n\nIf a deal is cancelled before delivery or disbursement, the escrowed funds are refunded to the Buyer fully (minus any applicable transaction fees).\n\nOnce funds are in escrow, they can only be released through Buyer Approval, valid Proof of Delivery, or the official Dispute Resolution process.'
      },
      {
        'q': 'Is PesaCrow safe?',
        'a': 'Yes. PesaCrow uses industry-standard encryption and adheres to Kenyan financial regulations. Funds are held securely, and disbursement is automated based on your authorization.'
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('FAQ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  prefix: 'Frequently Asked ',
                  gradient: 'Questions',
                  subtitle: 'Everything you need to know about PesaCrow.',
                  align: CrossAxisAlignment.start,
                ),
                const SizedBox(height: 40),
                ...faqs.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _FAQItem(
                      question: entry.value['q']!,
                      answer: entry.value['a']!,
                    ).animate(delay: (entry.key * 100).ms).fadeIn().slideX(begin: 0.05, end: 0),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FAQItem({required this.question, required this.answer});

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppColors.cyberCard(radius: 16),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (val) => setState(() => _isExpanded = val),
          title: Text(
            widget.question,
            style: TextStyle(
              color: _isExpanded ? AppColors.cyan : Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          iconColor: AppColors.cyan,
          collapsedIconColor: Colors.white54,
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            Text(
              widget.answer,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
