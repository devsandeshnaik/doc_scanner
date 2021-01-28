import 'package:flutter/services.dart';

class NativeBridge {
  final _platform = MethodChannel("com.triviatribe.scanner/native");

  Future<String> initiateDocumentScanning() async {
    try {
      final String result = await _platform.invokeMethod('scanForDocument');
      return result;
    } on PlatformException catch (exception) {
      print(exception);
    }
    return "";
  }
}
