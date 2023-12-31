
import 'package:acadmiat/features/consultancies_feature/presentation/test_page/webview_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/back_button.dart';
import 'app_bar/webview_tab_app_bar.dart';
import 'models/browser_model.dart';
import 'models/webview_model.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Browser extends StatefulWidget {
  const Browser({Key? key,required this.url}) : super(key: key);
  final String url;

  @override
  State<Browser> createState() => _BrowserState();
}

class _BrowserState extends State<Browser> with SingleTickerProviderStateMixin {

bool firstOne=true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          _buildBrowser(widget.url),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: BackButtonWidget(),
            ),
          ),
        ],
      )
    );
    return Stack(
      children: [
        _buildBrowser(widget.url),
       const BackButton(),
      ],
    );
  }

  Widget _buildBrowser(String url) {
    var currentWebViewModel = Provider.of<WebViewModel>(context, listen: true);
    var browserModel = Provider.of<BrowserModel>(context, listen: true);

    browserModel.addListener(() {
      browserModel.save();
    });
    currentWebViewModel.addListener(() {
      browserModel.save();
    });

    var canShowTabScroller =
        browserModel.showTabScroller && browserModel.webViewTabs.isNotEmpty;

    return IndexedStack(
      index: canShowTabScroller ? 1 : 0,
      children: [
        _buildWebViewTabs(url),
        // canShowTabScroller ? _buildWebViewTabsViewer() : Container()
      ],
    );
  }

  Widget _buildWebViewTabs(String url) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
            builder: (context) {
              if(firstOne){
                firstOne=false;
                Future.delayed(const Duration(milliseconds: 1000), () {
                  addNewTab(url: WebUri(
                    url

                  ));
                });

              }

              return _buildWebViewTabsContent();
            }
        ),
      ),
    );

  }
  void addNewTab({WebUri? url}) {
    var browserModel = Provider.of<BrowserModel>(context, listen: false);
    browserModel.addTab(WebViewTab(
      key: GlobalKey(),
      webViewModel: WebViewModel(url: url),
    ));
  }
  Widget _buildWebViewTabsContent() {
    var browserModel = Provider.of<BrowserModel>(context, listen: true);

    if (browserModel.webViewTabs.isEmpty) {
      return Container();
    }

    var stackChildren = <Widget>[
      IndexedStack(
        index: browserModel.getCurrentTabIndex(),
        children: browserModel.webViewTabs.map((webViewTab) {
          var isCurrentTab = webViewTab.webViewModel.tabIndex ==
              browserModel.getCurrentTabIndex();

          // if (isCurrentTab) {
          //   Future.delayed(const Duration(milliseconds: 100), () {
          //     webViewTabStateKey.currentState?.onShowTab();
          //   });
          // } else {
          //   webViewTabStateKey.currentState?.onHideTab();
          // }

          return webViewTab;
        }).toList(),
      ),
      _createProgressIndicator()
    ];

    return Stack(
      children: stackChildren,
    );
  }

  Widget _createProgressIndicator() {
    return Selector<WebViewModel, double>(
        selector: (context, webViewModel) => webViewModel.progress,
        builder: (context, progress, child) {
          if (progress >= 1.0) {
            return Container();
          }
          return PreferredSize(
              preferredSize: const Size(double.infinity, 4.0),
              child: SizedBox(
                  height: 4.0,
                  child: LinearProgressIndicator(
                    value: progress,
                  )));
        });
  }


}
