import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:truemedapp/config/appConstants.dart';
import 'package:truemedapp/config/appTheme.dart';

import 'package:truemedapp/config/methods.dart';
import 'package:truemedapp/config/networkConectivity.dart';
import 'package:truemedapp/model/latLong.dart';
import 'package:truemedapp/ui/Screen/MapScreen/myNavDrawer.dart';
import 'package:truemedapp/ui/Screen/WebViewContainerScreen/webViewContainer.dart';
import 'package:url_launcher/url_launcher.dart';

// class MapScreendMain extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: BlocProvider(
//         create: (context) {
//           return LabInformationBloc()..add(LoadMapLabInfomationEvent());
//         },
//         child: MapScreen(),
//       ),
//     );
//   }
// }

class MapScreen extends StatefulWidget {
  BuildContext ctx;
  MapScreen(this.ctx);
  @override
  State<MapScreen> createState() => _MapScreenStateState();
}

class _MapScreenStateState extends State<MapScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  //Position currentPosition;
  CameraPosition userLocationIniotialCameraPosition;

  List<LatLong> latLongList = [
    LatLong(lat: "42.012776", long: "-74.105974"),
    LatLong(lat: "41.012776", long: " -74.005974"),
    LatLong(lat: "40.912776", long: " -74.005974"),
  ];

  //PermissionStatus _permissionStatus = PermissionStatus.unknown;

  // static final CameraPosition initialCameraPosition = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  // static final CameraPosition cameraPosition = CameraPosition(
  //   // bearing: 12.8334901395799,
  //   target: LatLng(37.43296265331129, -122.08832357078792),
  //   tilt: 9.440717697143555,
  //   // zoom: 1.151926040649414
  // );

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  // }

  @override
  void initState() {
    super.initState();
    //  _listenForPermissionStatus();
  }

  // void checkServiceStatus(
  //     BuildContext context, LocationPermissionLevel permissionLevel) {
  //   LocationPermissions()
  //       .checkServiceStatus()
  //       .then((ServiceStatus serviceStatus) {
  //     final SnackBar snackBar =
  //         SnackBar(content: Text(serviceStatus.toString()));

  //     Scaffold.of(context).showSnackBar(snackBar);
  //   });
  // }

  // void _listenForPermissionStatus() {
  //   final Future<PermissionStatus> statusFuture =
  //       LocationPermissions().checkPermissionStatus();

  //   LocationPermissionLevel _permissionLevel =
  //       LocationPermissionLevel.locationAlways;

  //   statusFuture.then((PermissionStatus status) {
  //     _permissionStatus = status;
  //     if (_permissionStatus == PermissionStatus.unknown) {
  //       requestPermission(_permissionLevel);
  //     } else if (_permissionStatus == PermissionStatus.denied) {
  //       // showMessageError("Need Location permission ");
  //       //requestPermission(_permissionLevel);
  //     }
  //   });
  // }

  // Future<void> requestPermission(
  //     LocationPermissionLevel permissionLevel) async {
  //   final PermissionStatus permissionRequestResult = await LocationPermissions()
  //       .requestPermissions(permissionLevel: permissionLevel);

  //   setState(() {
  //     print(permissionRequestResult);
  //     _permissionStatus = permissionRequestResult;
  //     print(_permissionStatus);
  //   });
  // }

  void showMessageError(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      duration: const Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    context = context;
    return new Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black45),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),

      // body: Text("Data"),
      // body: AlertDalogue(),

      body: _buildBody(context),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('Lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
      drawer: MyNavDrawer(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        _googleMapWidget(context, 43.712776, -74.105974),
        Positioned(
            bottom: 1,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom:50.0),
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                callButton(context, APIConstants.phoneNumber),
                 bookNowButton(context, ),
              ]),
            )),
      ],
    );
  }

  Widget callButton(BuildContext context, String phioneNumber) {
    return SizedBox(
      height: 45,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Container(
          // margin: EdgeInsets.only(top: 0.0),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            gradient: new LinearGradient(
                colors: [
                  AppTheme.appDefaultColor,
                  AppTheme.appDefaultColor,
                ],
                begin: const FractionalOffset(0.0, 1.0),
                end: const FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: MaterialButton(
              highlightColor: AppTheme.appBackgroundColorforCard4,
              splashColor: AppTheme.appBackgroundColorforCard1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 42.0),
                child: Text("Call Now",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              onPressed: () async {
                print("Login Button clicked");

                NetworkConnectivity.check().then((internet) async {
                  if (internet) {
                    var uri = 'tel:$phioneNumber';
                    if (await canLaunch(uri)) {
                      await launch(uri);
                    } else {
                      // iOS
                      var uri = 'tel:$phioneNumber';
                      if (await canLaunch(uri)) {
                        await launch(uri);
                      } else {
                        throw 'Could not launch $uri';
                      }
                    }
                  } else {
                    //show network erro
                    showMessageError("Check Network Conection");
                  }
                });

                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => DashboardScreen()));
              }

              // showInSnackBar("Login button pressed")

              ),
        ),
      ),
    );
  }

  Widget bookNowButton(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Container(
          // margin: EdgeInsets.only(top: 0.0),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            gradient: new LinearGradient(
                colors: [
                  AppTheme.appDefaultColor,
                  AppTheme.appDefaultColor,
                ],
                begin: const FractionalOffset(0.0, 1.0),
                end: const FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: MaterialButton(
              highlightColor: AppTheme.appBackgroundColorforCard4,
              splashColor: AppTheme.appBackgroundColorforCard1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 42.0),
                child: Text("Book Now",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              onPressed: () async {
                print("Login Button clicked");

                NetworkConnectivity.check().then((internet) {
                  if (internet) {
                    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WebViewContainer(APIConstants.labEndPoint, "Book Now")));
                   
                  } else {
                    //show network erro
                    showMessageError("Check Network Conection");
                  }
                });

                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => DashboardScreen()));
              }

              // showInSnackBar("Login button pressed")

              ),
        ),
      ),
    );
  }


  Set<Marker> getLabsMarkers(List<LatLong> latlongList) {
    Set<Marker> markers = new Set<Marker>();

//Run the loop and add locations to marker

    for (int i = 0; i < latlongList.length; i++) {
      markers.add(Marker(
          markerId: MarkerId("1"),
          position: LatLng(double.parse(latlongList[i].lat),
              double.parse(latlongList[i].long)),
          onTap: () {
            return Methods.showDialogueForFacilityDetail(context, "", "");
          }));
    }

    return markers;
  }

  Widget _googleMapWidget(BuildContext context, double lat, double long) {
    return GoogleMap(
      //myLocationEnabled: true,
      // myLocationButtonEnabled: true,
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      zoomControlsEnabled: false,
      rotateGesturesEnabled: true,
      compassEnabled: true,
      buildingsEnabled: true,
      //mapToolbarEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(target: LatLng(lat, long)),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: getLabsMarkers(latLongList),
    );
  }

  // test marker to check bootom sheet
  // Marker addMarker() {
  //   return Marker(
  //       onTap: () async {
  //         //bootmSheetCall();
  //       },
  //       markerId: MarkerId("New MARKER"),
  //       position: LatLng(currentPosition.latitude, currentPosition.longitude),
  //       infoWindow: InfoWindow(title: "Marker Function"),
  //       icon:
  //           BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange));
  // }
//   Marker newYork_2 = Marker(
//       onTap: () async {},
//       markerId: MarkerId("mark2"),
//       position: LatLng(42.012776, -74.105974),
//       infoWindow: InfoWindow(title: "New York 2"),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange));

//   Marker newYork_3 = Marker(
//       onTap: () {
//         var widget2 = widget.ctx;
//         return Methods.showDialogueForFacilityDetail(
//             widget2, "Test Number", "test url");
//       },
//       markerId: MarkerId("mark2"),
//       position: LatLng(41.012776, -74.005974),
//       infoWindow: InfoWindow(title: "New York 3"),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange));

//   Marker newYork_4 = Marker(
//       onTap: () {},
//       markerId: MarkerId("mark2"),
//       position: LatLng(40.912776, -74.005974),
//       infoWindow: InfoWindow(title: "New York 3"),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange));
// }
}
