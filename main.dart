import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter WebView',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double progress = 0;
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView"),
        leading: IconButton(
          onPressed: () {
            controller.clearCache();
            CookieManager().clearCookies();
          },
          icon: const Icon(Icons.cached),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                if (await controller.canGoBack()) {
                  controller.goBack();
                }
              },
              icon: const Icon(Icons.arrow_back_ios)),
          IconButton(
              onPressed: () async {
                if (await controller.canGoForward()) {
                  controller.goForward();
                }
              },
              icon: const Icon(Icons.arrow_forward_ios)),
          IconButton(
              onPressed: () {
                controller.reload();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            color: Colors.red,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: WebView(
                initialUrl: 'https://amazon.com',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  this.controller = controller;
                },
                onProgress: (progress) => setState(() {
                  this.progress = progress / 100;
                }),
                onPageFinished: (string) {
                  setState(() {
                    progress = 0;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
