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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(32),
        constraints: const BoxConstraints(maxWidth: 450),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Fee Calculator',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.dark),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppColors.muted),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter the deal amount to see the full breakdown of fees and payouts.',
              style: TextStyle(color: AppColors.muted, fontSize: 14),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Deal Amount (KSh)',
                hintText: 'e.g. 5000',
                filled: true,
                fillColor: AppColors.bg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.buyerGreen, width: 2),
                ),
                prefixIcon: const Icon(Icons.payments, color: AppColors.buyerGreen),
              ),
              onSubmitted: (_) => _calculate(),
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: AppColors.error, fontSize: 12)),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: _isLoading 
                ? const Center(child: CircularProgressIndicator())
                : PrimaryButton(
                    label: 'Calculate Fees',
                    onTap: _calculate,
                  ),
            ),
            if (_result != null) ...[
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 24),
              _ResultRow(
                label: 'Buyer Pays Total',
                value: 'KSh ${_result!['buyerTotal']}',
                isBold: true,
                color: AppColors.buyerGreen,
              ),
              const SizedBox(height: 12),
              _ResultRow(
                label: 'Seller Receives',
                value: 'KSh ${_result!['sellerNet']}',
                isBold: true,
                color: AppColors.sellerBlue,
              ),
              const SizedBox(height: 24),
              const Text('Breakdown', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
              const SizedBox(height: 12),
              _ResultRow(label: 'Bouquet Charge', value: 'KSh ${_result!['breakdown']['bouquetCharge']}'),
              const SizedBox(height: 8),
              _ResultRow(label: 'Transaction Fee (Buyer)', value: 'KSh ${_result!['breakdown']['transactionFee']}'),
              const SizedBox(height: 8),
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
    final style = TextStyle(
      fontSize: isBold ? 16 : 13,
      fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
      color: color ?? AppColors.dark,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style.copyWith(color: AppColors.muted, fontWeight: FontWeight.w500)),
        Text(value, style: style),
      ],
    );
  }
}
