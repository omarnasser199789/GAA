import 'package:acadmiat/Theme/theme_notifier.dart';
import 'package:acadmiat/Theme/theme_values.dart';
import 'package:acadmiat/remote_config.dart';
import 'package:flutter/material.dart';
import 'features/consultancies_feature/presentation/test_page/models/browser_model.dart';
import 'features/consultancies_feature/presentation/test_page/models/webview_model.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'launch_page.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider;
import 'package:purchases_flutter/purchases_flutter.dart';


late final String WEB_ARCHIVE_DIR;

final _configuration = PurchasesConfiguration('appl_LiGSQHdcvBowLFNanuAfhcBGihJ');

void main(List<String> arguments) async {

  WidgetsFlutterBinding.ensureInitialized();
  await Purchases.configure(_configuration);

  WEB_ARCHIVE_DIR = (await getApplicationSupportDirectory()).path;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  await FirebaseRemoteConfigClass().initializeConfig();
  runApp(
      MultiProvider(
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
        // child: FlutterBrowserApp(),
        child: ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => ThemeNotifier(appTheme), child: LaunchPage()),
      ),




  );
}

