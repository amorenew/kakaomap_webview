import 'package:example/kakaomap_screen.dart';
import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String kakaoMapKey = 'yourKey';

class BasicExample extends StatefulWidget {
  @override
  State<BasicExample> createState() => _BasicExampleState();
}

class _BasicExampleState extends State<BasicExample> {
  late WebViewController _mapController;
  final double _lat = 33.450701;
  final double _lng = 126.570667;
  final markerImageUrl =
      'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png';
  final markerImageUrl2 =
      'https://toppng.com/uploads/preview/spongebob-11546804723npjrxsris5.png';
  final markerImageUrl3 = 'https://c.neh.tw/thumb/f/720/m2i8G6i8Z5d3K9i8.jpg';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Kakao map webview test')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          KakaoMapView(
            width: size.width,
            height: 400,
            kakaoMapKey: kakaoMapKey,
            lat: _lat,
            lng: _lng,
            markerImageURL: markerImageUrl,
            markerImageWidth: 64,
            markerImageHeight: 69,
            showMapTypeControl: true,
            showZoomControl: true,
            draggableMarker: true,
            mapController: (controller) {
              _mapController = controller;
            },
            zoomLevel: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Text('Add marker'),
                onPressed: () {
                  _mapController.addMarker(
                    markerImageUrl: markerImageUrl,
                    lat: _lat,
                    lng: _lng,
                    markerWidth: 64,
                    markerHeight: 69,
                  );

                  _mapController.addMarker(
                    markerImageUrl: markerImageUrl2,
                    lat: _lat + 0.0003,
                    lng: _lng + 0.0003,
                    markerWidth: 64,
                    markerHeight: 69,
                  );

                  _mapController.addMarker(
                    markerImageUrl: markerImageUrl3,
                    lat: _lat + 0.0003,
                    lng: _lng + 0.0035,
                    markerWidth: 64,
                    markerHeight: 69,
                  );
                },
              ),
              ElevatedButton(
                child: Text('Remove marker'),
                onPressed: () {
                  _mapController.removeMarker(
                    lat: _lat + 0.0003,
                    lng: _lng + 0.0003,
                  );
                },
              ),
              ElevatedButton(
                child: Text('move to marker'),
                onPressed: () {
                  _mapController.moveTo(
                    lat: _lat + 0.0003,
                    lng: _lng + 0.0035,
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  _mapController.zoomOut();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _mapController.zoomIn();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await _mapController.reload();
                  debugPrint('[refresh] done');
                },
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          ElevatedButton(
              child: Text('Kakao map screen'),
              onPressed: () async {
                await _openKakaoMapScreen(context);
              })
        ],
      ),
    );
  }

  Future<void> _openKakaoMapScreen(BuildContext context) async {
    KakaoMapUtil util = KakaoMapUtil();
    String url =
        await util.getMapScreenURL(37.402056, 127.108212, name: 'Kakao 본사');

    debugPrint('url : $url');

    Navigator.push(
        context, MaterialPageRoute(builder: (_) => KakaoMapScreen(url: url)));
  }
}
