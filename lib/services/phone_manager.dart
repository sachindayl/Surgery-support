import 'package:url_launcher/url_launcher.dart';

class PhoneManager {

  PhoneManager._private();

  static final PhoneManager _instance =
  PhoneManager._private();

  static PhoneManager get instance => _instance;

  Future<void> makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}