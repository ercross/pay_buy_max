import 'dart:io';

class InternetConnectivity {
  /// [check] checks that the current device has an active internet connection
  /// by pinging some addresses
  static Future<bool> check() async {
    bool hasConnection = false;
    Socket sock;
    const int defaultPort = 53;
    const Duration timeout = Duration(seconds: 10);
    List<InternetAddress> hosts = List.unmodifiable([
      InternetAddress("1.1.1.1"), //Cloudflare
      InternetAddress("1.0.0.1"), //Cloudflare
      InternetAddress("8.8.8.8"), //Google Public DNS
      InternetAddress("8.8.4.4"), //Google Public DNS
    ]);

    // ping each address. On first successful access of an internet address,
    // it's confirmed there's an internet connection, then exit the loop.
    for (InternetAddress addr in hosts) {
      try {
        sock = await Socket.connect(
          addr,
          defaultPort,
          timeout: timeout,
        );
        sock.destroy();
        hasConnection = true;
        break;
      } catch (e) {
        continue;
      }
    }

    return hasConnection;
  }
}
