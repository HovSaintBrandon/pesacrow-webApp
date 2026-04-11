import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../widgets/gradient_text.dart';
import '../widgets/primary_button.dart';
import 'escrow_process_page.dart';
import 'home_page.dart'; // Self-reference might be needed if moved but here it's fine
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

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _howItWorksKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();

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
                  delegate: SliverChildListDelegate([
                    HeroSection(key: _heroKey),
                    const WhySection(),
                    HowItWorksSection(key: _howItWorksKey),
                    FeaturesSection(key: _featuresKey),
                    const AudienceSection(),
                    const TestimonialsSection(),
                    const SecuritySection(),
                    const FinalCTASection(),
                    FooterSection(onLogoTap: () => _scrollToSection(_heroKey)),
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
          GestureDetector(
            onTap: () => _scrollToSection(_heroKey),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
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
                ],
              ),
            ),
          ),
          if (isWide) ...[
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _navBtn('Features', _featuresKey),
                _navBtn('How It Works', _howItWorksKey),
                _pageNavBtn('The Escrow Process', const EscrowProcessPage()),
              ],
            ),
            const Spacer(),
            Animate(
              onPlay: (controller) => controller.repeat(reverse: true),
              effects: [
                ScaleEffect(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 2.seconds, curve: Curves.easeInOut),
              ],
              child: PrimaryButton(
                label: 'Join Beta Access', 
                onTap: () => launchUrl(Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLSeBbWMLBJmOuPQ3tbE14jR9o51EQfYUUAjpfnw6YJubXtwOiA/viewform?usp=dialog')),
              ),
            ),
          ] else ...[
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {}, // Drawer or mobile menu
            ),
          ],
        ],
      ),
    );
  }

  Widget _navBtn(String label, GlobalKey key) => TextButton(
        onPressed: () => _scrollToSection(key),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white70, 
            fontSize: 14, 
            fontWeight: FontWeight.w500,
          ),
        ),
      );
  
  Widget _pageNavBtn(String label, Widget page) => TextButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white70, 
            fontSize: 14, 
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }
}
