import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  static Future<bool> isConnected() async {
    // returns a List
    final List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }
    return true;
  }
}
