import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../widgets/gradient_text.dart';
import '../widgets/primary_button.dart';
import 'escrow_process_page.dart';
import 'business_page.dart';
import 'api_page.dart';
import 'about_page.dart';
import '../sections/hero_section.dart';
import '../sections/why_section.dart';
import '../sections/how_it_works_section.dart';
import '../sections/features_section.dart';
import '../sections/fee_calculator_section.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
        key: _scaffoldKey,
        backgroundColor: AppColors.background,
        drawer: _buildDrawer(context),
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
                    const FeeCalculatorSection(),
                    const AudienceSection(),
                    const TestimonialsSection(),
                    const SecuritySection(),
                    const FinalCTASection(),
                    FooterSection(onLogoTap: () => _scrollToSection(_heroKey)),
                  ]),
                ),
              ],
            ),
            Builder(
              builder: (ctx) => _buildStickyAppBar(ctx),
            ),
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
                _pageNavBtn('About', const AboutPage()),
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
                label: 'Transact Online', 
                onTap: () => launchUrl(Uri.parse('https://app.pesacrow.top/#/')),
              ),
            ),
          ] else ...[
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.white.withOpacity(0.05))),
        ),
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/mpesacrowlogo.png', height: 32, color: Colors.white),
                    const SizedBox(width: 12),
                    const GradientText('PesaCrow', fontSize: 24, fontWeight: FontWeight.w900),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [

                  _drawerItem(context, Icons.help_outline, 'How It Works', () {
                    Navigator.pop(context);
                    _scrollToSection(_howItWorksKey);
                  }),
                  _drawerItem(context, Icons.account_tree_outlined, 'The Escrow Process', () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EscrowProcessPage()));
                  }),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Divider(color: Colors.white10),
                  ),
                  _drawerItem(context, Icons.business_center_outlined, 'Business', () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BusinessPage()));
                  }),
                  _drawerItem(context, Icons.code, 'API', () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const APIPage()));
                  }),
                  _drawerItem(context, Icons.info_outline, 'About Us', () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: PrimaryButton(
                label: 'Transact Online',
                onTap: () {
                  Navigator.pop(context);
                  launchUrl(Uri.parse('https://app.pesacrow.top/#/'));
                },
              ),
            ),
          ],
        ),
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

  Widget _drawerItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.cyan, size: 22),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        alignment: 0.0,
      );
    }
  }
}
