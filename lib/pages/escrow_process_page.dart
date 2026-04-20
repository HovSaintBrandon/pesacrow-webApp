import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../widgets/animated_escrow_diagram.dart';
import '../widgets/gradient_text.dart';
import '../widgets/particle_background.dart';
import '../widgets/section_title.dart';

class EscrowProcessPage extends StatelessWidget {
  const EscrowProcessPage({super.key});

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
                children: [
                   const SectionTitle(
                    prefix: 'The PesaCrow ',
                    gradient: 'Escrow Process',
                    subtitle: 'A secure "Trust Bridge" that guarantees safety for both parties.',
                  ).animate().fadeIn().slideY(begin: 0.1, end: 0),
                  
                  const SizedBox(height: 60),
                  
                  // Financial Architecture Summary
                  _buildFinancialArchitectureSection(),
                  
                  const SizedBox(height: 80),
                  
                  // Animated Sequence Diagram
                  const Text(
                    "Visual Sequence Diagram",
                    style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Watch how money and trust flow through the PesaCrow system in real-time.",
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  const AnimatedEscrowDiagram(),
                  
                  const SizedBox(height: 80),
                  
                  // Statuses Table
                  _buildStatusTable(),
                  
                  const SizedBox(height: 80),
                  
                  // Buyer/Seller Journeys
                  _buildJourneysSection(context),
                  
                  const SizedBox(height: 80),
                  
                  // Technical Mechanisms
                  _buildTechnicalMechanisms(context),
                  
                  const SizedBox(height: 100),
                  
                  const SizedBox(height: 20),
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
      backgroundColor: AppColors.background,
      floating: true,
      pinned: true,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/mpesacrowlogo.png', height: 24, color: Colors.white),
          const SizedBox(width: 12),
          const GradientText('PesaCrow Escrow', fontSize: 18, fontWeight: FontWeight.bold),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: Colors.white.withOpacity(0.05), height: 1),
      ),
    );
  }

  Widget _buildFinancialArchitectureSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.cyan.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "1. Financial Architecture",
            style: TextStyle(color: AppColors.cyan, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            "Funds never flow directly from Buyer to Seller. Instead, PesaCrow serves as a secure holding layer using Safaricom's regulated Paybill architecture. Money is locked in our holding account until the 'Multi-Step Handshake' is completed.",
            style: TextStyle(color: Colors.white70, height: 1.6, fontSize: 16),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
               _archCard(Icons.security, "STK Push", "Encrypted payment request direct to user phone."),
               _archCard(Icons.lock_clock, "Status: HELD", "Cryptographic lock prevents early fund release."),
               _archCard(Icons.check_circle, "Verification", "System validates M-Pesa callbacks before proceeding."),
            ],
          ),
        ],
      ),
    );
  }

  Widget _archCard(IconData icon, String title, String desc) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.cyan, size: 28),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text(desc, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildStatusTable() {
    final List<Map<String, String>> statuses = [
      {'status': 'pending_payment', 'meaning': 'Waiting for buyer to pay', 'action': 'Buyer completes STK Push'},
      {'status': 'held', 'meaning': 'Funds locked in escrow', 'action': 'Seller can safely deliver'},
      {'status': 'delivered', 'meaning': 'Seller uploaded proof', 'action': 'Buyer inspects and approves'},
      {'status': 'approved', 'meaning': 'Buyer satisfied', 'action': 'System triggers payout'},
      {'status': 'released', 'meaning': 'Funds sent to seller', 'action': 'Transaction complete'},
      {'status': 'disputed', 'meaning': 'Conflict raised - frozen', 'action': 'Admin reviews evidence'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("2. Deal Lifecycle Statuses", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
            color: AppColors.surface.withOpacity(0.5),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                color: Colors.white.withOpacity(0.05),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: const Row(
                  children: [
                    Expanded(flex: 2, child: Text("Status", style: TextStyle(color: AppColors.cyan, fontWeight: FontWeight.bold))),
                    Expanded(flex: 3, child: Text("Meaning", style: TextStyle(color: AppColors.cyan, fontWeight: FontWeight.bold))),
                    Expanded(flex: 3, child: Text("Responsibility", style: TextStyle(color: AppColors.cyan, fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              ...statuses.map((s) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white.withOpacity(0.03))),
                ),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text(s['status']!, style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 13))),
                    Expanded(flex: 3, child: Text(s['meaning']!, style: const TextStyle(color: Colors.white70, fontSize: 13))),
                    Expanded(flex: 3, child: Text(s['action']!, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13))),
                  ],
                ),
              )).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildJourneysSection(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return Column(
      children: [
        const Text("Platform User Journeys", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        const Text("Detailed steps for every type of deal outcome.", style: TextStyle(color: AppColors.textSecondary)),
        const SizedBox(height: 40),
        
        if (isWide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildJourneyCard("The Buyer Journey", [
                "Initiation via Protected Link",
                "Lockdown (STK Push Callback)",
                "Waiting period during Fulfillment",
                "Final Inspection & Approval",
                "Successful Release / Protection Reversal",
              ], AppColors.cyan)),
              const SizedBox(width: 24),
              Expanded(child: _buildJourneyCard("The Seller Journey", [
                "Deal Creation & Link Sharing",
                "Safe-to-Ship Realtime Signal",
                "Proof of Delivery Upload",
                "24-48h Auto-Release Protection",
                "Direct-to-Mpesa Disbursement",
              ], AppColors.electricBlue)),
            ],
          )
        else
          Column(
            children: [
              _buildJourneyCard("The Buyer Journey", [
                "Initiation via Protected Link",
                "Lockdown (STK Push Callback)",
                "Waiting period during Fulfillment",
                "Final Inspection & Approval",
                "Successful Release / Protection Reversal",
              ], AppColors.cyan),
              const SizedBox(height: 24),
              _buildJourneyCard("The Seller Journey", [
                "Deal Creation & Link Sharing",
                "Safe-to-Ship Realtime Signal",
                "Proof of Delivery Upload",
                "24-48h Auto-Release Protection",
                "Direct-to-Mpesa Disbursement",
              ], AppColors.electricBlue),
            ],
          ),
      ],
    );
  }

  Widget _buildJourneyCard(String title, List<String> steps, Color color) {
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
          Text(title, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ...steps.asMap().entries.map((entry) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: color.withOpacity(0.2),
                  child: Text("${entry.key + 1}", style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(entry.value, style: const TextStyle(color: Colors.white70, fontSize: 14))),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTechnicalMechanisms(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("6. Technical & Safety Key Features", style: TextStyle(color: AppColors.cyan, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 900 ? 3 : 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: [
              _techItem(Icons.payments, "Dual Fee Structure", "Split between security and release fees."),
              _techItem(Icons.timer_outlined, "Auto-Release Window", "Protects sellers from inactive buyers."),
              _techItem(Icons.sync, "Real-time SSE", "Instant deal status updates without refreshing."),
              _techItem(Icons.history, "M-Pesa Reversals", "Full protection for early cancellations."),
              _techItem(Icons.account_tree, "Payout Logic", "B2C, B2Pochi, and B2B flexibility."),
              _techItem(Icons.security_update_good, "Control Lock", "Funds frozen during disputed states."),
            ],
          ),
        ],
      ),
    );
  }

  Widget _techItem(IconData icon, String title, String desc) {
    return Row(
      children: [
        Icon(icon, color: AppColors.cyan, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 4),
              Text(desc, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
