import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailService {
  // Replace these with YOUR actual IDs from EmailJS
  static const String serviceId = 'service_6eowu1g';
  static const String templateId = 'template_ssyyfew';
  static const String publicKey =  'JKQ8srUHAnzgDVL0j';

  static Future<bool> sendQuoteRequest({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String message,
  }) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': publicKey,
        'template_params': {
          'from_name': name,
          'from_email': email,
          'phone': phone,
          'address': address,
          'message': message,
        },
      }),
    );

    return response.statusCode == 200;
  }
}