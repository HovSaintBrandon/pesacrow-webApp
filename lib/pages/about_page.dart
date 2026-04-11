import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/gradient_text.dart';
import '../widgets/particle_background.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const ParticleBackground(particleCount: 400),
          CustomScrollView(
            slivers: [
              _buildAppBar(context),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: GradientText(
                          'About PesaCrow',
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text(
                          'Secure. Simple. Trusted.',
                          style: TextStyle(
                            color: AppColors.cyan,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      _buildSection(
                        "Our Story",
                        "PesaCrow is Kenya’s smart escrow platform designed to eliminate trust issues in peer-to-peer transactions. Whether you’re buying or selling goods and services online, PesaCrow acts as a neutral, secure middleman that holds funds safely until both parties are fully satisfied.\n\nIn a market where “send money and pray” has become too risky, PesaCrow brings peace of mind by ensuring your money only moves when the deal is done right.",
                      ),
                      const SizedBox(height: 48),
                      _buildSection(
                        "The PesaCrow Promise",
                        "We don’t just process payments — we protect them.",
                      ),
                      const SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildSmallCard(
                              Icons.shopping_bag_outlined,
                              "For Buyers",
                              "Your money is securely held in escrow. You only release it once you’ve received and approved the goods or service. No more paying strangers and hoping they deliver.",
                              AppColors.cyan,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _buildSmallCard(
                              Icons.sell_outlined,
                              "For Sellers",
                              "Once the buyer pays, you get a clear “safe-to-ship” signal. When the buyer confirms satisfaction, funds are released directly to your M-Pesa, Till, or Paybill — quickly and reliably.",
                              AppColors.electricBlue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                      const Text(
                        "Why Kenyans Choose PesaCrow",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildFeatureItem(Icons.security, "Bank-level Security", "Funds are held in a dedicated M-Pesa Paybill and released only after clear approval or admin mediation."),
                      _buildFeatureItem(Icons.phone_android, "Built for Kenya", "Fully integrated with M-Pesa STK Push, reversals, B2C payouts, Pochi, and Paybill — no complicated bank transfers."),
                      _buildFeatureItem(Icons.gavel, "Dispute Protection", "If something goes wrong, our admin team reviews evidence and ensures a fair outcome for both sides."),
                      _buildFeatureItem(Icons.verified_user, "Zero Risk Trading", "Buyers pay only when happy. Sellers get paid only when delivery is confirmed."),
                      _buildFeatureItem(Icons.bolt, "Fast & Transparent", "Real-time notifications via Server-Sent Events so both parties always know exactly where their deal stands."),
                      const SizedBox(height: 80),
                      Container(
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.cyan.withOpacity(0.1)),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Our Mission",
                              style: TextStyle(
                                color: AppColors.cyan,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              "To make every peer-to-peer transaction in Kenya safe, fair, and stress-free. We believe Kenyans should be able to trade confidently — whether it’s phones, electronics, services, vehicles, or even high-value deals — without fear of being scammed or ghosted.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              "PesaCrow turns “I hope they deliver” into “The system guarantees it.”",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      floating: true,
      pinned: true,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: const GradientText('About Us', fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          content,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildSmallCard(IconData icon, String title, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            desc,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.cyan.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.check, color: AppColors.cyan, size: 20),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
