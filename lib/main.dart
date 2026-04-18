import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'theme/app_theme.dart';
import 'pages/splash_page.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/api_page.dart';
import 'pages/business_page.dart';
import 'pages/escrow_process_page.dart';
import 'pages/faq_page.dart';
import 'pages/privacy_page.dart';
import 'pages/terms_page.dart';
import 'services/seo_service.dart';
import 'utils/nav_observer.dart';

void main() {
  // Enable Path URL strategy (removes # from URLs)
  usePathUrlStrategy();
  
  // Initialize SEO Service
  SeoService.init();
  
  runApp(const PesaCrowApp());
}

class PesaCrowApp extends StatelessWidget {
  const PesaCrowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PesaCrow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // We use initialRoute and routes for professional SEO and Path URL support
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/api': (context) => const APIPage(),
        '/business': (context) => const BusinessPage(),
        '/escrow-process': (context) => const EscrowProcessPage(),
        '/faq': (context) => const FAQPage(),
        '/privacy': (context) => const PrivacyPage(),
        '/terms': (context) => const TermsPage(),
      },
      navigatorObservers: [
        SeoNavObserver(),
      ],
    );
  }
}
