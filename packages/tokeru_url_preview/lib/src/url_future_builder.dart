import 'package:flutter/material.dart';
import 'package:tokeru_url_preview/src/url_preview.dart';

/// URL先のデータを取得して表示するWidget。
class UrlFutureBuilder extends StatefulWidget {
  /// URL。
  final Uri url;

  /// 取得したOGPデータを表示する。
  final Widget Function(UrlPreview) data;

  /// ローディング中のWidget
  final Widget Function() loading;

  /// エラーが発生した場合のWidget
  final Widget Function(Object, StackTrace) error;

  const UrlFutureBuilder({
    super.key,
    required this.url,
    required this.data,
    required this.loading,
    required this.error,
  });

  @override
  State<UrlFutureBuilder> createState() => _UrlFutureBuilderState();
}

class _UrlFutureBuilderState extends State<UrlFutureBuilder> {
  final Future<UrlPreview> Function(Uri) _fetchUrlPreview = fetchUrlPreview;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UrlPreview>(
      future: _fetchUrlPreview(widget.url),
      builder: (context, snapshot) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: snapshot.connectionState == ConnectionState.waiting
              ? widget.loading()
              : snapshot.hasError
                  ? widget.error(snapshot.error!, snapshot.stackTrace!)
                  : widget.data(snapshot.data!),
        );
      },
    );
  }
}
