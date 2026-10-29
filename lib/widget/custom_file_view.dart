part of widget;

class CustomFileView extends StatefulWidget {
  final String? url;
  final String? title;

  CustomFileView(this.url, this.title);

  @override
  CustomFileViewState createState() => CustomFileViewState();
}

class CustomFileViewState extends State<CustomFileView> {
  late WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(Platform.isAndroid
          ? "https://docs.google.com/viewer?embedded=true&url=${widget.url}"
          : widget.url!));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppGlass.backgroundColor,
      appBar: CustomGlassAppBar(
        title: Text(widget.title!),
      ),
      body: ["jpeg", "jpg", "png"].contains(widget.url!.split(".").last)
          ? CustomNetworkImage(
              width: double.infinity,
              height: double.infinity,
              url: widget.url,
              fit: BoxFit.contain,
            )
          : WebViewWidget(controller: _controller),
    );
  }
}
