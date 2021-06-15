import 'package:flutter_boost/flutter_boost.dart';

class CustomInterceptor extends BoostInterceptor {
  @override
  void onPush(BoostInterceptorOption option, PushInterceptorHandler handler) {
    Logger.log('CustomInterceptor1~~~, $option');
    // Add extra arguments
    option.arguments['CustomInterceptor1'] = "1";
    super.onPush(option, handler);
  }
}