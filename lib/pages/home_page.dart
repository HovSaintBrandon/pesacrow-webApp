import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/gradient_text.dart';
import '../widgets/primary_button.dart';
import '../sections/hero_section.dart';
import '../sections/why_section.dart';
import '../sections/how_it_works_section.dart';
import '../sections/features_section.dart';
import '../sections/audience_section.dart';
import '../sections/testimonials_section.dart';
import '../sections/pricing_section.dart';
import '../sections/security_section.dart';
import '../sections/final_cta_section.dart';
import '../sections/footer_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(const [
              HeroSection(),
              WhySection(),
              HowItWorksSection(),
              FeaturesSection(),
              AudienceSection(),
              TestimonialsSection(),
              PricingSection(),
              SecuritySection(),
              FinalCTASection(),
              FooterSection(),
            ]),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white.withOpacity(0.9),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          Image.asset(
            'assets/mpesacrowlogo.png',
            height: 32,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 12),
          const GradientText('PesaCrow', fontSize: 20, fontWeight: FontWeight.w800),
        ],
      ),
      actions: isWide
          ? [
              _navBtn('Products'),
              _navBtn('How It Works'),
              _navBtn('Pricing'),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: PrimaryButton(label: 'Join PesaCrow Free', onTap: () {}),
              ),
            ]
          : [
              Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.dark),
                  onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                ),
              ),
            ],
    );
  }

  Widget _navBtn(String label) => TextButton(
        onPressed: () {},
        child: Text(
          label,
          style: const TextStyle(color: AppColors.muted, fontSize: 13, fontWeight: FontWeight.w500),
        ),
      );
}
