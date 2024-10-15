export 'network_checker_stub.dart'
    if (dart.library.html) 'network_checker_web.dart'
    if (dart.library.io) 'network_checker_non_web.dart';
