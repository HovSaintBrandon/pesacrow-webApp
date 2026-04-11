import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';

class AnimatedEscrowDiagram extends StatefulWidget {
  const AnimatedEscrowDiagram({super.key});

  @override
  State<AnimatedEscrowDiagram> createState() => _AnimatedEscrowDiagramState();
}

class _AnimatedEscrowDiagramState extends State<AnimatedEscrowDiagram> {
  int _currentStep = 0;
  late final Stream<int> _stepStream;

  @override
  void initState() {
    super.initState();
    _stepStream = Stream.periodic(const Duration(seconds: 3), (i) => (i + 1) % 8);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _stepStream,
      initialData: 0,
      builder: (context, snapshot) {
        _currentStep = snapshot.data ?? 0;
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface.withOpacity(0.3),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            children: [
              _buildActorsRow(),
              const SizedBox(height: 60),
              _buildInteractionArea(),
              const SizedBox(height: 40),
              _buildStepIndicator(),
            ],
          ),
        );
      }
    );
  }

  Widget _buildActorsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _actorIcon(Icons.person, 'Buyer', AppColors.cyan),
        _actorIcon(Icons.security, 'PesaCrow', Colors.white),
        _actorIcon(Icons.store, 'Seller', AppColors.electricBlue),
        _actorIcon(Icons.account_balance, 'Safaricom', AppColors.success),
      ],
    );
  }

  Widget _actorIcon(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.5), width: 2),
            boxShadow: [
              BoxShadow(color: color.withOpacity(0.2), blurRadius: 15, spreadRadius: 2),
            ],
          ),
          child: Icon(icon, color: color, size: 32),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(
            color: color.withOpacity(0.9),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildInteractionArea() {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Step descriptions
          Positioned(
            top: 0,
            child: AnimatedSwitcher(
              duration: 400.ms,
              child: _getStepContent(_currentStep),
            ),
          ),
          
          // Flow arrows (conceptual)
          _buildFlowLine(0, 1, _currentStep == 0), // B -> PC
          _buildFlowLine(1, 3, _currentStep == 1), // PC -> M
          _buildFlowLine(3, 0, _currentStep == 2), // M -> B (STK Push)
          _buildFlowLine(0, 3, _currentStep == 3), // B -> M (PIN)
          _buildFlowLine(3, 1, _currentStep == 4), // M -> PC (Callback)
          _buildFlowLine(2, 1, _currentStep == 5), // S -> PC (Delivered)
          _buildFlowLine(0, 1, _currentStep == 6), // B -> PC (Approved)
          _buildFlowLine(1, 2, _currentStep == 7), // PC -> S (Payout)
        ],
      ),
    );
  }

  Widget _getStepContent(int step) {
    String title = "";
    String desc = "";
    IconData icon = Icons.info;
    Color color = Colors.white;

    switch (step) {
      case 0:
        title = "Initiation";
        desc = "Buyer initiates payment through Protected Link";
        icon = Icons.payment;
        color = AppColors.cyan;
        break;
      case 1:
        title = "Safaricom Request";
        desc = "PesaCrow requests STK Push via M-Pesa API";
        icon = Icons.api;
        color = AppColors.success;
        break;
      case 2:
        title = "PIN Prompt";
        desc = "Buyer receives M-Pesa PIN prompt on phone";
        icon = Icons.touch_app;
        color = AppColors.cyan;
        break;
      case 3:
        title = "Authentication";
        desc = "Buyer enters PIN to authorize escrow lock";
        icon = Icons.lock_outline;
        color = AppColors.cyan;
        break;
      case 4:
        title = "Funds Locked";
        desc = "M-Pesa confirms payment. Status moved to HELD";
        icon = Icons.lock;
        color = AppColors.success;
        break;
      case 5:
        title = "Fulfillment";
        desc = "Seller delivers and uploads proof of delivery";
        icon = Icons.local_shipping;
        color = AppColors.electricBlue;
        break;
      case 6:
        title = "Buyer Approval";
        desc = "Buyer inspects and clicks 'Approve Funds'";
        icon = Icons.verified;
        color = AppColors.cyan;
        break;
      case 7:
        title = "Disbursement";
        desc = "PesaCrow releases funds to Seller's M-Pesa";
        icon = Icons.account_balance_wallet;
        color = AppColors.electricBlue;
        break;
    }

    return Container(
      key: ValueKey(step),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildFlowLine(int from, int to, bool active) {
    if (!active) return const SizedBox.shrink();
    
    // Simple conceptual lines between simulated positions
    // Actors are index 0, 1, 2, 3 in Row
    return Animate(
      effects: [FadeEffect(), ScaleEffect(begin: const Offset(0.8, 0.8))],
      child: CustomPaint(
        size: const Size(double.infinity, 200),
        painter: FlowPainter(from, to, AppColors.cyan),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(8, (index) {
        bool active = index <= _currentStep;
        return Container(
          width: 30,
          height: 4,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: active ? AppColors.cyan : Colors.white10,
            borderRadius: BorderRadius.circular(2),
            boxShadow: active ? [BoxShadow(color: AppColors.cyan.withOpacity(0.5), blurRadius: 4)] : [],
          ),
        );
      }),
    );
  }
}

class FlowPainter extends CustomPainter {
  final int from;
  final int to;
  final Color color;

  FlowPainter(this.from, this.to, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Conceptual points based on 4 actors spaceAround
    double getX(int index) {
      double segment = size.width / 4;
      return segment * index + segment / 2;
    }

    final startX = getX(from);
    final endX = getX(to);
    
    final path = Path();
    path.moveTo(startX, 0);
    path.quadraticBezierTo((startX + endX) / 2, 50, endX, 0);
    
    canvas.drawPath(path, paint);

    // Animating dot (Conceptual, usually we'd use AnimationController but simple pulse here)
    final dotPaint = Paint()..color = color..maskFilter = const MaskFilter.blur(BlurStyle.solid, 4);
    canvas.drawCircle(Offset(endX, 0), 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
