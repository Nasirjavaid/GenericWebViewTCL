// import 'package:flutter/material.dart';
// import 'package:location_permissions/location_permissions.dart';

// class PermissionWidget extends StatefulWidget {
  
//   const PermissionWidget(this._permissionLevel);

//   final LocationPermissionLevel _permissionLevel;

//   @override
//   _PermissionState createState() => _PermissionState(_permissionLevel);
// }

// class _PermissionState extends State<PermissionWidget> {
//   _PermissionState(this._permissionLevel);

//   final LocationPermissionLevel _permissionLevel;
//   PermissionStatus _permissionStatus = PermissionStatus.unknown;

//   @override
//   void initState() {
//     super.initState();

//     _listenForPermissionStatus();
//   }

//   void _listenForPermissionStatus() {
//     final Future<PermissionStatus> statusFuture =
//         LocationPermissions().checkPermissionStatus();

//     statusFuture.then((PermissionStatus status) {
//       setState(() {
//         _permissionStatus = status;
//       });
//     });
//   }

//   Color getPermissionColor() {
//     switch (_permissionStatus) {
//       case PermissionStatus.denied:
//         return Colors.red;
//       case PermissionStatus.granted:
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(_permissionLevel.toString()),
//       subtitle: Text(
//         _permissionStatus.toString(),
//         style: TextStyle(color: getPermissionColor()),
//       ),
//       trailing: IconButton(
//           icon: const Icon(Icons.info),
//           onPressed: () {
//             checkServiceStatus(context, _permissionLevel);
//           }),
//       onTap: () {
//         requestPermission(_permissionLevel);
//       },
//     );
//   }

//   void checkServiceStatus(
//       BuildContext context, LocationPermissionLevel permissionLevel) {
//     LocationPermissions()
//         .checkServiceStatus()
//         .then((ServiceStatus serviceStatus) {
//       final SnackBar snackBar =
//           SnackBar(content: Text(serviceStatus.toString()));

//       Scaffold.of(context).showSnackBar(snackBar);
//     });
//   }

//   Future<void> requestPermission(
//       LocationPermissionLevel permissionLevel) async {
//     final PermissionStatus permissionRequestResult = await LocationPermissions()
//         .requestPermissions(permissionLevel: permissionLevel);

//     setState(() {
//       print(permissionRequestResult);
//       _permissionStatus = permissionRequestResult;
//       print(_permissionStatus);
//     });
//   }
// }