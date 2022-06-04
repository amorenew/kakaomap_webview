class KakaoHtml {
  String getOverlayStyle({
    String? overlayText,
    String? customOverlayStyle,
  }) {
    String overlayStyle = '';
    if (overlayText != null) {
      if (customOverlayStyle == null) {
        overlayStyle = '''
<style>
  .label {margin-bottom: 96px;}
  .label * {display: inline-block;vertical-align: top;}
  .label .left {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_l.png") no-repeat;display: inline-block;height: 24px;overflow: hidden;vertical-align: top;width: 7px;}
  .label .center {background: url(https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_bg.png) repeat-x;display: inline-block;height: 24px;font-size: 12px;line-height: 24px;}
  .label .right {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_r.png") -1px 0  no-repeat;display: inline-block;height: 24px;overflow: hidden;width: 6px;}
</style>
      ''';
      } else {
        overlayStyle = customOverlayStyle;
      }
    } else {
      overlayStyle = customOverlayStyle ?? '';
    }

    return overlayStyle;
  }

  String addMarker({
    required String markerImageUrl,
    required double lat,
    required double lng,
    double markerWidth = 64,
    double markerHeight = 69,
  }) {
    String marker = '''		
    var markerImage
		if(${markerImageUrl.isNotEmpty}){
		  let imageSrc = '$markerImageUrl'
		  let imageSize = new kakao.maps.Size($markerWidth, $markerHeight)
		  let imageOption = {offset: new kakao.maps.Point(27, $markerHeight)}
		  markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
		}
		var markerPosition  = new kakao.maps.LatLng($lat, $lng);
		
		var marker = new kakao.maps.Marker({
      map:map,
      position: markerPosition,
     image: markerImage
    });

    markers.push(marker);

    ''';

    return marker;
  }

  String removeMarker({
    required double lat,
    required double lng,
  }) {
    String removeMarkerScript = '''

     for (var i = 0; i < markers.length; i++) {
       console.log(markers[i].getPosition().getLat());
       console.log($lat );
       console.log(markers[i].getPosition().getLng());
       console.log( $lng);
      if(markers[i].getPosition().getLat() == $lat && markers[i].getPosition().getLng() == $lng){
        markers[i].setMap(null);
      }
     }            

    ''';
    return removeMarkerScript;
  }

  String moveTo({
    required double lat,
    required double lng,
  }) {
    String moveToScript = '''
    var moveLatLon = new kakao.maps.LatLng($lat, $lng);
  
    map.panTo(moveLatLon);            
    ''';
    return moveToScript;
  }
}
