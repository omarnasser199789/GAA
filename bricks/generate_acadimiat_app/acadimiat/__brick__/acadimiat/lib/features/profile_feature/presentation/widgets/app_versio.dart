import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/style.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({Key? key}) : super(key: key);
  Future<String> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Center(
        child: FutureBuilder<String>(
          future: _getAppVersion(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}', style: blackBoldTextStyle(context: context, fontSize: 12, color: hintTextColor));
            } else {
              return Text(' إصدار نسخة رقم: ${snapshot.data}',style: blackBoldTextStyle(context: context, fontSize: 12, color: hintTextColor));
            }
          },
        ),
      ),
    );
  }
}
