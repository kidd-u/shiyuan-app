import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({
    Key key,
    this.url,
  }) : super(key: key);
  final String url;
  @override
  State<StatefulWidget> createState() {
    return new WebViewState();
  }
}

class WebViewState extends State<WebViewPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, ''),
      body: WebView(
        initialUrl: widget.url,
        //JS执行模式 是否允许JS执行
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
