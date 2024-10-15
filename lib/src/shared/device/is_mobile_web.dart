import 'package:web/web.dart' as web;

bool isMobileBrowser() {
  final userAgent = web.window.navigator.userAgent.toLowerCase();
  return (userAgent.contains('android') && userAgent.contains('mobile')) ||
      (userAgent.contains('iphone') && !userAgent.contains('ipad'));
}
