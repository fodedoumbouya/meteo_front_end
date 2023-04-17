import 'package:flutter/material.dart';
import 'package:meteo_front_end/base/base_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DisplayInfo extends BaseWidget {
  String id;
  DisplayInfo({required this.id, super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _DisplayInfoState();
  }
}

class _DisplayInfoState extends BaseWidgetState<DisplayInfo> {
  late WebViewController controller;
  ValueNotifier<bool> pageLoad = ValueNotifier(false);

  initWebController() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..enableZoom(true)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print(progress);
            if (progress == 100) {
              pageLoad.value = true;
            } else {
              pageLoad.value = false;
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            // return NavigationDecision.navigate;
            return NavigationDecision.navigate;
          },
        ),
      )
      // ..loadHtmlString(html);
      ..loadRequest(
          Uri.parse('http://localhost:8085/api/widget?id=${widget.id}'));
  }

  @override
  void initState() {
    initWebController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: c(
                h: yy(sh() + 600),
                w: sw(),
                child: ValueListenableBuilder(
                  valueListenable: pageLoad,
                  builder: (context, value, child) {
                    return value
                        ? WebViewWidget(controller: controller)
                        : const Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          ));
                  },
                )),
          )),
    );
  }
}
