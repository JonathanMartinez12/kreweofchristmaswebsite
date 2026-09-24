import 'package:url_launcher/url_launcher.dart';

/// External links used across the site.
class Links {
  static const String quoteForm = 'https://app.flyra.io/f/4a9qk0nk';
  static const String googleReviews = 'https://share.google/4v4grR0ncVDvM9N5Z';
  static const String instagram = 'https://www.instagram.com/kreweofchristmas/';

  static Future<void> open(String url) async {
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }

  static Future<void> openQuoteForm() => open(quoteForm);
}
