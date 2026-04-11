import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../services/fee_service.dart';
import '../widgets/primary_button.dart';
import '../widgets/section_title.dart';

class FeeCalculatorSection extends StatefulWidget {
  const FeeCalculatorSection({super.key});

  @override
  State<FeeCalculatorSection> createState() => _FeeCalculatorSectionState();
}

class _FeeCalculatorSectionState extends State<FeeCalculatorSection> {
  final _amountController = TextEditingController();
  final _feeService = FeeService();
  bool _isLoading = false;
  Map<String, dynamic>? _result;
  String? _error;

  void _calculate() async {
    final amountText = _amountController.text;
    final amount = double.tryParse(amountText);

    if (amount == null || amount <= 0) {
      setState(() => _error = 'Please enter a valid amount');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _result = null;
    });

    try {
      final res = await _feeService.calculateFees(amount);
      setState(() {
        _result = res;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              const SectionTitle(
                prefix: 'Interactive ',
                gradient: 'Fee Calculator',
                subtitle: 'Know exactly how much you pay and receive before initiating a deal.',
              ),
              const SizedBox(height: 60),
              
              isWide 
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: _buildInputCard()),
                      const SizedBox(width: 40),
                      Expanded(flex: 2, child: _buildResultPanel()),
                    ],
                  )
                : Column(
                    children: [
                      _buildInputCard(),
                      const SizedBox(height: 40),
                      _buildResultPanel(),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Transaction Amount",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            "Enter the value of your goods or services (KSh)",
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: "e.g. 5,000",
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.1)),
              prefixIcon: const Icon(Icons.payments_outlined, color: AppColors.cyan, size: 28),
              filled: true,
              fillColor: Colors.black.withOpacity(0.2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.cyan, width: 2),
              ),
              contentPadding: const EdgeInsets.all(24),
            ),
            onSubmitted: (_) => _calculate(),
          ),
          if (_error != null) ...[
            const SizedBox(height: 16),
            Text(_error!, style: const TextStyle(color: AppColors.error, fontSize: 13)),
          ],
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: _isLoading 
              ? const Center(child: CircularProgressIndicator(color: AppColors.cyan))
              : PrimaryButton(
                  label: "Calculate Fees",
                  onTap: _calculate,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultPanel() {
    if (_result == null && !_isLoading) {
      return Container(
        height: 350,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.02),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.05), style: BorderStyle.solid),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.query_stats, color: Colors.white.withOpacity(0.1), size: 64),
              const SizedBox(height: 20),
              Text(
                "Breakdown will appear here",
                style: TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    if (_isLoading) {
      return Container(
        height: 350,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(32),
        ),
        child: const Center(child: CircularProgressIndicator(color: AppColors.cyan)),
      );
    }

    return Column(
      children: [
        _resultCard(
          "Total Buyer Pays", 
          "KSh ${_result!['buyerTotal']}", 
          AppColors.cyan, 
          icon: Icons.upload_outlined
        ).animate().fadeIn().slideX(begin: 0.1, end: 0),
        const SizedBox(height: 16),
        _resultCard(
          "Seller Net Payout", 
          "KSh ${_result!['sellerNet']}", 
          AppColors.success, 
          icon: Icons.download_outlined
        ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.1, end: 0),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _detailRow("Escrow Charge", "${_result!['breakdown']['bouquetCharge']} KSh"),
              const SizedBox(height: 12),
              _detailRow("Buyer Service Fee", "${_result!['breakdown']['transactionFee']} KSh"),
              const SizedBox(height: 12),
              _detailRow("Seller Release Fee", "${_result!['breakdown']['releaseFee']} KSh"),
            ],
          ),
        ).animate().fadeIn(delay: 400.ms),
      ],
    );
  }

  Widget _resultCard(String label, String value, Color color, {required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: color.withOpacity(0.8), fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        Text(value, style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
