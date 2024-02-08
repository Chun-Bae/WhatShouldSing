import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

class NaverMapPage extends StatefulWidget {
  const NaverMapPage({super.key});

  @override
  State<NaverMapPage> createState() => _NaverMapPageState();
}

class _NaverMapPageState extends State<NaverMapPage> {
  late NaverMapController _controller;
  final List<NMarker> _markers = [];

  @override
  void initState() {
    super.initState();
    _loadNearbyKaraoke();
  }

  Future<void> _loadNearbyKaraoke() async {
    Position currentPosition = await _determinePosition();

    // 예시: 주변 노래방 정보를 검색하고 결과를 처리하는 코드
    // 여기서는 더미 데이터를 사용합니다.
    List<Map<String, dynamic>> dummyKaraokeList = [
      {
        "name": "노래방 A",
        "latitude": currentPosition.latitude + 0.01,
        "longitude": currentPosition.longitude + 0.01,
      },
      {
        "name": "노래방 B",
        "latitude": currentPosition.latitude + 0.02,
        "longitude": currentPosition.longitude + 0.02,
      },
      // 추가 노래방 정보...
    ];

    for (var karaoke in dummyKaraokeList) {
      double distance = Geolocator.distanceBetween(
        currentPosition.latitude,
        currentPosition.longitude,
        karaoke["latitude"],
        karaoke["longitude"],
      );

      // 500미터 이내의 노래방에만 마커를 생성
      if (distance <= 500) {
        _markers.add(
          NMarker(
            id: karaoke["name"],
            position: NLatLng(karaoke["latitude"], karaoke["longitude"]),
          ),
        );
      }
    }

    setState(() {});
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 위치 서비스가 활성화되어 있는지 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('위치 서비스가 비활성화되어 있습니다.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('위치 권한이 거부되었습니다.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('위치 권한이 영구적으로 거부되었습니다. 설정에서 변경해주세요.');
    }

    // 현재 위치 얻기
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Position>(
        future: _determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 데이터를 기다리는 동안 로딩 인디케이터를 표시
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // 에러가 발생한 경우 처리
            return Center(child: Text("위치 정보를 가져오는데 실패했습니다."));
          } else if (snapshot.hasData) {
            // 데이터를 성공적으로 받아온 경우, NaverMap 위젯을 반환
            Position position = snapshot.data!;
            return NaverMap(
              options: NaverMapViewOptions(
                initialCameraPosition: NCameraPosition(
                  target: NLatLng(position.latitude, position.longitude),
                  zoom: 14,
                ),
              ),
            );
          } else {
            // 데이터가 없는 경우 처리
            return Center(child: Text("위치 정보가 없습니다."));
          }
        },
      ),
    );
  }
}
