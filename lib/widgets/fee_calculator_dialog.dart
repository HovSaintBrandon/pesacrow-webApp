import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../services/fee_service.dart';
import 'primary_button.dart';

class FeeCalculatorDialog extends StatefulWidget {
  const FeeCalculatorDialog({super.key});

  @override
  State<FeeCalculatorDialog> createState() => _FeeCalculatorDialogState();
}

class _FeeCalculatorDialogState extends State<FeeCalculatorDialog> {
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
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
        side: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      child: Container(
        padding: const EdgeInsets.all(40),
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Fee Calculator',
                  style: TextStyle(
                    fontSize: 28, 
                    fontWeight: FontWeight.w900, 
                    color: Colors.white,
                    letterSpacing: -1,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: Colors.white.withOpacity(0.3)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Enter the deal amount to see the full breakdown of fees and payouts.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: 'Deal Amount (KSh)',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                hintText: 'e.g. 5000',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.cyan, width: 2),
                ),
                prefixIcon: const Icon(Icons.payments, color: AppColors.cyan),
              ),
              onSubmitted: (_) => _calculate(),
            ),
            if (_error != null) ...[
              const SizedBox(height: 16),
              Text(_error!, style: const TextStyle(color: Colors.redAccent, fontSize: 13, fontWeight: FontWeight.w500)),
            ],
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: _isLoading 
                ? const Center(child: CircularProgressIndicator(color: AppColors.cyan))
                : PrimaryButton(
                    label: 'Calculate Breakdown',
                    onTap: _calculate,
                  ),
            ),
            if (_result != null) ...[
              const SizedBox(height: 40),
              Divider(color: Colors.white.withOpacity(0.1)),
              const SizedBox(height: 32),
              _ResultRow(
                label: 'Buyer Pays Total',
                value: 'KSh ${_result!['buyerTotal']}',
                isBold: true,
                color: AppColors.cyan,
              ),
              const SizedBox(height: 16),
              _ResultRow(
                label: 'Seller Receives',
                value: 'KSh ${_result!['sellerNet']}',
                isBold: true,
                color: AppColors.success,
              ),
              const SizedBox(height: 32),
              const Text(
                'Fee Breakdown', 
                style: TextStyle(
                  fontWeight: FontWeight.w900, 
                  fontSize: 14, 
                  color: Colors.white70,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 20),
              _ResultRow(label: 'Bouquet Charge', value: 'KSh ${_result!['breakdown']['bouquetCharge']}'),
              const SizedBox(height: 12),
              _ResultRow(label: 'Transaction Fee (Buyer)', value: 'KSh ${_result!['breakdown']['transactionFee']}'),
              const SizedBox(height: 12),
              _ResultRow(label: 'Release Fee (Seller)', value: 'KSh ${_result!['breakdown']['releaseFee']}'),
            ],
          ],
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? color;

  const _ResultRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label, 
          style: TextStyle(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value, 
          style: TextStyle(
            fontSize: isBold ? 18 : 14,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
            color: color ?? Colors.white,
          ),
        ),
      ],
    );
  }
}
