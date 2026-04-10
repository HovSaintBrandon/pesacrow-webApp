import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../widgets/section_title.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

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
        title: const Text('Privacy Policy', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  prefix: 'Privacy ',
                  gradient: 'Policy',
                  subtitle: 'How we collect, use, and safeguard your personal data at PesaCrow.',
                  align: CrossAxisAlignment.start,
                ),
                const SizedBox(height: 40),
                _buildContentCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: AppColors.cyberCard(radius: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Effective Date: April 2026',
            style: TextStyle(color: AppColors.cyan, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 32),
          _section('1. Introduction', [
            'Welcome to PesaCrow ("we", "our", or "us"), operated by A3s (Absolute Advanced Anonymity Services). We respect your privacy and are committed to protecting your personal data. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit our platform or use our digital escrow services.',
          ]),
          _section('2. Information We Collect', [
            'Personal Identification Information: Phone number (M-Pesa registered number).',
            'Transaction Information: Details regarding the deals you create or participate in, including Deal IDs, amounts, item descriptions, and M-Pesa transaction references.',
            'Communication Data: Dispute evidence, or other communications made through the platform between Buyers, Sellers, and PesaCrow Admins.',
          ]),
          _section('3. How We Use Your Information', [
            'Service Delivery: To facilitate and manage escrow transactions, process M-Pesa deposits and disbursements, and update transaction statuses.',
            'Dispute Resolution: To provide evidence to our Admins in the event of a dispute, allowing for fair and accurate resolutions.',
            'Security and Compliance: To verify your identity, prevent fraud, monitor for unauthorized activities, and comply with Anti-Money Laundering (AML) and Know Your Customer (KYC) regulations in Kenya.',
            'Communication: To send you transactional notifications (e.g., SMS alerts regarding M-Pesa STK pushes, deal approvals, and cancellations) and respond to your customer service inquiries.',
          ]),
          _section('4. Information Sharing and Disclosure', [
            'We do not sell your personal data. We may share your information only in the following circumstances:',
            'With the Other Party in a Deal: We share necessary information (e.g., phone number, transaction details) with the Buyer or Seller you are transacting with to facilitate the deal.',
            'Service Providers: We share data with trusted third-party service providers, primarily Safaricom (M-Pesa), specifically for processing payments and disbursements.',
            'Legal Obligations: We may disclose your information to law enforcement or regulatory authorities if required by Kenyan law, or to protect the rights, property, and safety of PesaCrow and our users.',
          ]),
          _section('5. Data Security', [
            'We implement industry-standard administrative, technical, and physical security measures to protect your personal information. Our platform uses encryption and secure protocols to safeguard sensitive data, especially regarding payment rails and personal identifiers. However, no electronic transmission over the internet or information storage technology can be guaranteed to be 100% secure.',
          ]),
          _section('6. Data Retention', [
            'We retain your personal information only for as long as is necessary to fulfill the purposes outlined in this Privacy Policy, unless a longer retention period is required or permitted by law (such as for tax, legal, or accounting purposes).',
          ]),
          _section('7. Your Privacy Rights', [
            'Depending on the applicable data protection laws in Kenya, you may have the right to:',
            'Request access to the personal data we hold about you.',
            'Request correction of inaccurate or incomplete data.',
            'Request deletion of your personal data (subject to legal and regulatory restrictions regarding financial transactions).',
            'Object to or restrict our processing of your data.',
            'To exercise any of these rights, please contact our support team.',
          ]),
          _section('8. Changes to This Privacy Policy', [
            'We may update this Privacy Policy from time to time to reflect changes in our practices or relevant laws. We encourage you to review this page periodically for the latest information on our privacy practices.',
          ]),
          _section('9. Contact Us', [
            'If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:',
            'Email: support@pesacrow.top',
            'Address: [Nairobi, Kenya]',
          ]),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.05, end: 0);
  }

  Widget _section(String title, List<String> paragraphs) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 20,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          ...paragraphs.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (paragraphs.length > 1)
                      const Padding(
                        padding: EdgeInsets.only(top: 6, right: 12),
                        child: Icon(Icons.circle, size: 6, color: AppColors.cyan),
                      ),
                    Expanded(
                      child: Text(
                        p,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
