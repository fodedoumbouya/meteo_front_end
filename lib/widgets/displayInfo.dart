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

  String html = """ 
<html>
    <head>
        <style>
            html, body{
                height: 100%;
                 font-size: 50px;
            }
            .parent > * {
                margin: 0 auto;
                 font-size: 50px;

            }
            .parent {
                width: 100%; 
                height: 100%;
                font-size: 60px;
            }
            .child {
                width: 800px; 
                height:1000px; 
                 font-size: 60px;
                color: blue;

                
            }
        </style>
    </head>
    <body>
        <div class="parent">
            <div class="child">
                <div  class="allmeteo-widget" data-ws="2108SW031"></div>
            </div>
        </div>
    </body>
    <script type="text/javascript" src="https://weather.allmeteo.com/widget/allmeteo.widget.js">  </script>
</html>

  """;

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
      // ..loadHtmlString(html);
      ..loadRequest(Uri.parse('http://localhost:8085/widget?id=${widget.id}'));
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
              child: WebViewWidget(controller: controller),
            ),
          )),
    );
  }
}
