import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService._(this._remoteConfig);

  static Future<RemoteConfigService> init() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await remoteConfig.fetchAndActivate();
    return RemoteConfigService._(remoteConfig);
  }

  bool get showDiscountedPrice => _remoteConfig.getBool('showDiscountedPrice');
}
