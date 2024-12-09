import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

/// URL preview
class TokeruUrlPreview {
  const TokeruUrlPreview({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.siteName,
    required this.iconUrl,
  });

  final String? title;
  final String? description;
  final String? imageUrl;
  final String? siteName;
  final String? iconUrl;
}

final _dio = Dio();

/// URL先のOGPデータを取得する。
Future<TokeruUrlPreview> fetchUrlPreview(Uri url) async {
  print('fetchUrlPreview: $url');
  final response = await _dio.get(
    url.toString(),
    options: Options(
      headers: {
        // X(Twitter)でこのヘッダーがないとOGPが取得できない。
        "User-Agent": "bot",
      },
    ),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to load URL');
  }
  final document = html_parser.parse(response.data);

  // OGPメタタグを抽出
  String title = '';
  String description = '';
  String? imageUrl;
  String? iconUrl;
  String? siteName;

  // metaタグから取得する。
  document.getElementsByTagName('meta').forEach((dom.Element element) {
    // title
    if (element.attributes['property'] == 'og:title') {
      title = element.attributes['content'] ?? '';
    }
    if (element.attributes['property'] == 'title') {
      title = element.attributes['content'] ?? '';
    }

    // description
    if (element.attributes['property'] == 'og:description') {
      description = element.attributes['content'] ?? '';
    }
    if (element.attributes['name'] == 'description') {
      description = element.attributes['content'] ?? '';
    }

    // siteName
    if (element.attributes['property'] == 'og:site_name') {
      siteName = element.attributes['content'];
    }

    // image
    if (element.attributes['property'] == 'og:image') {
      imageUrl = element.attributes['content'];
    }
  });

  // icon
  document.getElementsByTagName('link').forEach((dom.Element element) {
    if (element.attributes['rel'] == 'icon' ||
        element.attributes['rel'] == 'shortcut icon') {
      iconUrl = element.attributes['href'];
      // iconUrlが絶対パスでない場合は、urlを絶対パスに変換する。
      if (iconUrl != null &&
          !iconUrl!.startsWith('http') &&
          !iconUrl!.startsWith('https')) {
        iconUrl = '$url/${iconUrl!}';
      }
    }
  });

  // metaタグからの取得ができなかった場合は、titleタグから取得する。
  if (title.isEmpty) {
    final titleTag = document.getElementsByTagName('title');
    if (titleTag.isNotEmpty) {
      title = titleTag.first.text;
    }
  }

  // metaタグからの取得ができなかった場合は、descriptionタグから取得する。
  if (description.isEmpty) {
    final descriptionTag = document.getElementsByTagName('description');
    if (descriptionTag.isNotEmpty) {
      description = descriptionTag.first.text;
    }
  }

  return TokeruUrlPreview(
    title: title,
    description: description,
    imageUrl: imageUrl,
    iconUrl: iconUrl,
    siteName: siteName,
  );
}
