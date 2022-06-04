import 'package:kakaomap_webview/src/kakao_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

extension KakaoControllerExtension on WebViewController {
  void addMarker({
    required String markerImageUrl,
    required double lat,
    required double lng,
    double markerWidth = 64,
    double markerHeight = 69,
  }) {
    final marker = KakaoHtml().addMarker(
      markerImageUrl: markerImageUrl,
      lat: lat,
      lng: lng,
      markerWidth: markerWidth,
      markerHeight: markerHeight,
    );

    this.runJavascript(
      marker,
    );
  }

  void removeMarker({
    required double lat,
    required double lng,
  }) {
    final removeMarker = KakaoHtml().removeMarker(
      lat: lat,
      lng: lng,
    );

    this.runJavascript(
      removeMarker,
    );
  }

  void moveTo({
    required double lat,
    required double lng,
  }) {
    final moveTo = KakaoHtml().moveTo(
      lat: lat,
      lng: lng,
    );

    this.runJavascript(
      moveTo,
    );
  }

  void zoomIn() {
    this.runJavascript(
      'map.setLevel(map.getLevel() - 1, {animate: true})',
    );
  }

  void zoomOut() {
    this.runJavascript(
      'map.setLevel(map.getLevel() + 1, {animate: true})',
    );
  }
}
