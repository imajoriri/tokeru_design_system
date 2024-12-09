import 'package:flutter/material.dart';
import 'package:tokeru_url_preview/src/url_preview.dart';

/// URL先のデータを取得して表示するWidget。
class TokeruUrlFutureBuilder extends StatefulWidget {
  /// URL。
  final Uri url;

  /// 取得したOGPデータを表示する。
  final Widget Function(TokeruUrlPreview) data;

  /// ローディング中のWidget
  final Widget Function() loading;

  /// エラーが発生した場合のWidget
  final Widget Function(Object, StackTrace) error;

  const TokeruUrlFutureBuilder({
    super.key,
    required this.url,
    required this.data,
    required this.loading,
    required this.error,
  });

  @override
  State<TokeruUrlFutureBuilder> createState() => _TokeruUrlFutureBuilderState();
}

class _TokeruUrlFutureBuilderState extends State<TokeruUrlFutureBuilder> {
  _State state = _State.loading;
  TokeruUrlPreview? data;
  Object? error;
  StackTrace? stackTrace;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUrlPreview(widget.url).then((value) {
        setState(() {
          state = _State.data;
          data = value;
        });
      }).catchError((error) {
        setState(() {
          state = _State.error;
          error = error;
          stackTrace = stackTrace;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: switch (state) {
        _State.loading => widget.loading(),
        _State.error => widget.error(error!, stackTrace!),
        _State.data => widget.data(data!),
      },
    );
  }
}

enum _State {
  loading,
  error,
  data,
}
