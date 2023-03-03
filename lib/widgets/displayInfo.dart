import 'package:flutter/material.dart';
import 'package:meteo_front_end/base/base_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DisplayInfo extends BaseWidget {
  const DisplayInfo({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _DisplayInfoState();
  }
}

class _DisplayInfoState extends BaseWidgetState<DisplayInfo> {
  late WebViewController controller;

  initWebController() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..enableZoom(true)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
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
      ..loadRequest(Uri.parse('https://flutter.dev'));
  }

  @override
  void initState() {
    initWebController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: c(
        h: sh(),
        w: sw(),
        child: Stack(
          children: [
            Positioned(
                top: yy(100),
                right: xx(50),
                child: Listener(
                  onPointerDown: (event) => pop(),
                  child: c(
                      color: Colors.red,
                      boxShape: BoxShape.circle,
                      w: xx(80),
                      h: yy(80),
                      child: Icon(
                        Icons.close,
                        size: xx(80),
                      )),
                )),
            Positioned(
              top: yy(200),
              child: c(
                h: sh(),
                w: sw(),
                child: WebViewWidget(controller: controller),
                // Column(
                //   children: const [
                //     LineChartWeather(),
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
