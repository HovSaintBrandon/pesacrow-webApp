import 'package:flutter/material.dart';
import '../services/seo_service.dart';

class SeoNavObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _updateSeo(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _updateSeo(previousRoute);
    }
  }

  void _updateSeo(Route<dynamic> route) {
    final String? routeName = route.settings.name;
    
    switch (routeName) {
      case '/':
        SeoService.updateMetadata(
          title: 'PesaCrow | Secure M-Pesa Escrow',
          description: 'Secure digital escrow for M-Pesa. Trust them so you don\'t have to.',
          keywords: ['escrow', 'm-pesa', 'secure payment', 'kenya'],
        );
        break;
      case '/about':
        SeoService.updateMetadata(
          title: 'About Us | PesaCrow',
          description: 'Learn about PesaCrow\'s mission to bring trust and security to M-Pesa transactions.',
          keywords: ['about pesacrow', 'escrow mission', 'kenya tech'],
        );
        break;
      case '/escrow-process':
        SeoService.updateMetadata(
          title: 'How It Works | The Escrow Process',
          description: 'A step-by-step guide to how PesaCrow secures your M-Pesa payments.',
          keywords: ['escrow process', 'how it works', 'payment security'],
        );
        break;
      case '/business':
        SeoService.updateMetadata(
          title: 'PesaCrow for Business',
          description: 'Scale your business with secure, automated M-Pesa escrow solutions.',
          keywords: ['business escrow', 'b2b payment', 'm-pesa for business'],
        );
        break;
      case '/api':
        SeoService.updateMetadata(
          title: 'Developer API | PesaCrow',
          description: 'Integrate PesaCrow escrow directly into your applications with our robust API.',
          keywords: ['escrow api', 'developer documentation', 'm-pesa integration'],
        );
        break;
      case '/faq':
        SeoService.updateMetadata(
          title: 'Frequently Asked Questions | PesaCrow',
          description: 'Everything you need to know about using PesaCrow for your M-Pesa transactions.',
        );
        break;
      case '/privacy':
        SeoService.updateMetadata(
          title: 'Privacy Policy | PesaCrow',
          description: 'How we handle and protect your data at PesaCrow.',
        );
        break;
      case '/terms':
        SeoService.updateMetadata(
          title: 'Terms of Service | PesaCrow',
          description: 'The legal agreement for using PesaCrow services.',
        );
        break;
    }
  }
}
