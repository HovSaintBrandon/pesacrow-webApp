import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../widgets/gradient_text.dart';
import '../widgets/primary_button.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;
    final heroHeight = size.height * 0.9;

    return Container(
      width: double.infinity,
      height: heroHeight,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.8, -0.6),
          radius: 1.2,
          colors: [
            AppColors.cyan.withOpacity(0.08),
            AppColors.background,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background Abstract Elements
          _buildBackgroundDecor(),
          
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(horizontal: isWide ? 60 : 24),
              child: isWide 
                ? Row(
                    children: [
                      Expanded(flex: 3, child: _heroContent(context)),
                      Expanded(flex: 2, child: _heroVisual()),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _heroContent(context, isCenter: true),
                      const SizedBox(height: 48),
                      _heroVisual(),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroContent(BuildContext context, {bool isCenter = false}) {
    final align = isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = isCenter ? TextAlign.center : TextAlign.start;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: align,
      children: [
        // Trusting them... headline follows directly below
        Column(
          crossAxisAlignment: align,
          children: [
            Text(
              "Trusting them so",
              textAlign: textAlign,
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -1.5,
                height: 1.0,
              ),
            ),
            const GradientText(
              "you don't have to.", 
              fontSize: 64, 
              fontWeight: FontWeight.w900,
            ),
          ],
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 800.ms)
        .slideY(begin: 0.1, end: 0),

        const SizedBox(height: 24),
        
        // Subheadline
        SizedBox(
          width: 500,
          child: Text(
            "The most secure digital escrow for M-Pesa. Protect your payments, secure your sales, and trade with confidence—anywhere in Kenya.",
            textAlign: textAlign,
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        )
        .animate()
        .fadeIn(delay: 500.ms, duration: 800.ms)
        .slideY(begin: 0.1, end: 0),

        const SizedBox(height: 40),
        
        // CTAs
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: isCenter ? WrapAlignment.center : WrapAlignment.start,
          children: [
            PrimaryButton(
              label: 'Join Beta Access', 
              icon: Icons.arrow_forward,
              onTap: () => launchUrl(Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLSeBbWMLBJmOuPQ3tbE14jR9o51EQfYUUAjpfnw6YJubXtwOiA/viewform?usp=dialog')),
            ),
            _secondaryButton('Watch Demo', Icons.play_circle_outline),
          ],
        )
        .animate()
        .fadeIn(delay: 800.ms, duration: 800.ms)
        .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),

        const SizedBox(height: 48),
        
        // Trust Signals
        _buildTrustSignals(isCenter)
            .animate()
            .fadeIn(delay: 1100.ms),
      ],
    );
  }

  

  Widget _secondaryButton(String label, IconData icon) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.white.withOpacity(0.2)),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _heroVisual() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Cyber Glow Background
          Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.cyan.withOpacity(0.2),
                  blurRadius: 100,
                  spreadRadius: 20,
                ),
              ],
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(duration: 4.seconds, begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2)),
          
          // Floating Placeholder Card
          Container(
            width: 320,
            height: 450,
            decoration: AppColors.cyberCard(radius: 40),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.surfaceLight, AppColors.surface],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                      child: Icon(Icons.shield_outlined, size: 80, color: AppColors.cyan)
                          .animate(onPlay: (c) => c.repeat())
                          .shimmer(duration: 2.seconds, color: Colors.white24),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 12, width: 100, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(6))),
                          const SizedBox(height: 12),
                          Container(height: 12, width: 220, decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(6))),
                          const SizedBox(height: 8),
                          Container(height: 12, width: 180, decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(6))),
                          const Spacer(),
                          Container(
                            height: 40,
                            width: double.infinity,
                            decoration: AppColors.gradientBox(radius: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .moveY(begin: -10, end: 10, duration: 3.seconds, curve: Curves.easeInOut),
        ],
      ),
    );
  }

  Widget _buildTrustSignals(bool isCenter) {
    return Column(
      crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "TRUSTED BY 10,000+ USERS ACROSS KENYA",
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _trustLogo("Absolute"),
            _trustLogo("Advanced"),
            _trustLogo("Anonymous"),
            _trustLogo("Service"),
            
          ],
        ),
      ],
    );
  }

  Widget _trustLogo(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 32),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.2),
          fontSize: 18,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _buildBackgroundDecor() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.cyan.withOpacity(0.05),
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: 50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.electricBlue.withOpacity(0.05),
            ),
          ),
        ),
      ],
    );
  }
}

extension on Widget {
  // Simple helper to avoid repeated code for now
  Widget get maxW => this;
}
