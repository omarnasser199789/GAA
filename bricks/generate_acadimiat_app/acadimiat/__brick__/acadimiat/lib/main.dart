import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'Theme/theme_notifier.dart';
import 'Theme/theme_values.dart';
import 'core/globals.dart';
import 'features/consultancies_feature/presentation/browser_pages/models/browser_model.dart';
import 'features/consultancies_feature/presentation/browser_pages/models/webview_model.dart';
import 'injection_container.dart' as di;
import 'launch_page.dart';

/// Initialize the Purchases configuration
final _configuration = PurchasesConfiguration('appl_LiGSQHdcvBowLFNanuAfhcBGihJ');

/// Directory for web archive
late final String WEB_ARCHIVE_DIR;

/// Main function
void main(List<String> arguments) async {
  /// Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  /// Load environment variables based on build mode
  await dotenv.load(fileName: kDebugMode ? ".dev_env" : ".env");
  baseUrl= dotenv.env['baseUrl']!;
  baseSignalRUrl=dotenv.env['baseSignalRUrl']!;

  /// Configure Purchases
  await Purchases.configure(_configuration);

  /// Get application support directory for web archive
  WEB_ARCHIVE_DIR = (await getApplicationSupportDirectory()).path;

  /// Initialize dependency injection
  await di.init();

  /// Run the app
  runApp(const MyApp());
}

/// MyApp widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WebViewModel(),
        ),
        ChangeNotifierProxyProvider<WebViewModel, BrowserModel>(
          update: (context, webViewModel, browserModel) {
            browserModel!.setCurrentWebViewModel(webViewModel);
            return browserModel;
          },
          create: (BuildContext context) => BrowserModel(),
        ),
      ],
      child: ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(appTheme),
        child: LaunchPage(),
      ),
    );
  }
}
