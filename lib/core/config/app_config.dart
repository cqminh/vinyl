enum Flavor { dev, prod }

class AppConfig {
  const AppConfig({
    required this.flavor,
    required this.audiusBaseUrl,
    required this.appName,
    required this.enableLogging,
  });

  final Flavor flavor;
  final String audiusBaseUrl;
  final String appName;
  final bool   enableLogging;

  static const dev = AppConfig(
    flavor:        Flavor.dev, 
    audiusBaseUrl: 'https://api.audius.co/v1', 
    appName:       'vinyl-dev', 
    enableLogging: true,
  );

  static const prod = AppConfig(
    flavor:        Flavor.prod, 
    audiusBaseUrl: 'https://api.audius.co/v1', 
    appName:       'vinyl', 
    enableLogging: false,
  );
}