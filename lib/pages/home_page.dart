import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    double offset = _scrollController.offset;
    double opacity = (offset / 100).clamp(0.0, 1.0);
    if (opacity != _appBarOpacity) {
      setState(() {
        _appBarOpacity = opacity;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
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
            _buildStickyAppBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStickyAppBar(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(_appBarOpacity * 0.9),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(_appBarOpacity * 0.1),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Image.asset(
            'assets/mpesacrowlogo.png',
            height: 32,
            color: Colors.white,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 12),
          const GradientText('PesaCrow', fontSize: 20, fontWeight: FontWeight.w800),
          const Spacer(),
          if (isWide) ...[
            _navBtn('Products'),
            _navBtn('How It Works'),
            _navBtn('Pricing'),
            const SizedBox(width: 16),
            Animate(
              onPlay: (controller) => controller.repeat(reverse: true),
              effects: [
                ScaleEffect(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 2.seconds, curve: Curves.easeInOut),
              ],
              child: PrimaryButton(
                label: 'Join PesaCrow Free', 
                onTap: () {},
              ),
            ),
          ] else ...[
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {}, // Drawer or mobile menu
            ),
          ],
        ],
      ),
    );
  }

  Widget _navBtn(String label) => TextButton(
        onPressed: () {},
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white70, 
            fontSize: 14, 
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
