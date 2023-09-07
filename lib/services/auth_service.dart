import 'dart:convert';
import 'dart:io';
import 'package:random_string/random_string.dart';
import 'package:wedme1/models/currency_conversion_model.dart';
import 'package:wedme1/models/initiate_payment_model.dart';
import 'package:wedme1/utils/constant_utils.dart';
import 'package:wedme1/utils/response_utils.dart';
import 'package:http/http.dart' as http;

class AuthServics {
  Future<RepoValidator> sendEmail(String email, String otp) async {
    try {
      //TODO:: Chnage crendetial to company details
      final response = await http.post(
          Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
          headers: {
            'origin': 'http://localhost',
            'Content-Type': 'application/json'
          },
          body: json.encode({
            'service_id': 'service_buxfkp8',
            'template_id': 'template_rlii4i9',
            'user_id': emailJsUserId,
            'template_params': {
              // 'user_email': ,
              'to_email': email,
              'user_subject': 'Recovery Email Token',
              'user_message': '$otp is your WedMe recovery email token'
            }
          }));

      final result = await json.decode(json.encode(response.body));

      if (response.statusCode == 200 && response.body == 'OK') {
        print('The result ${response.body}');
        print('The result status ${response.statusCode}');
        return RepoSucess();
      } else {
        return RepoFailure(result['message'] ?? "Error occured try again");
      }
    } on SocketException {
      return RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendFCM(String token, String title, String body) async {
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$wedMeFCMToken'
        },
        body: jsonEncode(<String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '0',
            'status': 'done',
            'body': body,
            'title': title
          },
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
            'android_channel_id': 'wedme'
          },
          'to': token
        }));
  }

  Future<Object> convertCurrency(String amount) async {
    try {
      //TODO:: Chnage crendetial to company details
      final response = await http.get(
        Uri.parse(
            'https://api.apilayer.com/fixer/convert?to=NGN&from=USD&amount=$amount'),
        headers: {'Content-Type': 'application/json', 'apikey': apiLayerApiKey},
      );

      final result = await json.decode(response.body);

      print('The result ${response.body}');
      print('The result body ${result['success']}');
      print('The result status ${response.statusCode}');
      if (response.statusCode == 200 && result['success']) {
        return CurrencyConversionModel.fromJson(result);
      } else {
        return RepoFailure(result['message'] ?? "Error occured try again");
      }
    } on SocketException {
      return RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

//This is effect from flutterwave payment checkout
  Future<Object> initiatePayment(
      {required String amount,
      required String userId,
      required String email,
      required String phone,
      required String name, required String generateTxRef}) async {
    try {
     
      final response = await http.post(Uri.parse(flutterwaveInitPaymentUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':
                'Bearer FLWSECK_TEST-d1a3f444cd56a46221b444c7f39217ec-X',
          },
          body: jsonEncode({
            "tx_ref": generateTxRef,
            "amount": amount,
            "currency": "USD",
            "redirect_url": "https://wedfuse.com",
            "customer": {"email": email, "phonenumber": phone, "name": name},
            "customizations": {
              "title": "Wedfuse Payment",
              "logo": "assets/images/logo.png"
            }
          }));
      print('The result ${response.body}');
      print('The result status ${response.statusCode}');

      final result = await jsonDecode(response.body);
      print('The result $result');

      if (response.statusCode == 200 && result['status'] == 'success') {
        return InitiatePaymentModel.fromJson(result);
      } else {
        return RepoFailure(result["errors"][0] ?? "Error occured try again");
      }
    } on SocketException {
      return RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }
}


