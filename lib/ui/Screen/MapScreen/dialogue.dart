import 'package:flutter/material.dart';
import 'package:truemedapp/config/appConstants.dart';
import 'package:truemedapp/config/appTheme.dart';

import 'package:truemedapp/ui/Screen/WebViewContainerScreen/webViewContainer.dart';
import 'package:url_launcher/url_launcher.dart';

class AlertDalogue extends StatefulWidget {
  final BuildContext ctx;
  final String phoneNumber;
  final String webUrl;


  AlertDalogue({this.ctx,this.phoneNumber,this.webUrl});

  @override
  _AlertDalogueState createState() => _AlertDalogueState();
}

class _AlertDalogueState extends State<AlertDalogue> {
  @override
  Widget build(BuildContext context) {
    return showFancyCustomDialog(context);
  }

// need to pass latitude and longitude
  _openMap(String lat, String long) async {
    // Android
    var url = 'geo:$lat,$long';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // iOS
      var url = 'http://maps.apple.com/?ll=$lat,$long';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

// Nedd to pass phone number to make it dynamic and it only works on physical device not on Simulator
  _callMe(String phioneNumber) async {
    // Android
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
  }

  Widget directionsButton() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          "Directions",
          style: TextStyle(
              color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ),
      onTap: () {
        // _openMap(widget.labInformationModel.address.latitude,
        //     widget.labInformationModel.address.longitude);
      },
    );
  }

  Widget bookNowButton() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          "Book Now",
          style: TextStyle(
              color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WebViewContainer(APIConstants.labEndPoint, "Book Now")));
      },
    );
  }

  Widget callButton() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          "Call Now",
          style: TextStyle(
              color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ),
      onTap: () {
        _callMe(APIConstants.phoneNumber);
      },
    );
  }

  Widget showFancyCustomDialog(BuildContext context) {
    return Dialog(
      elevation: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.background2,
          borderRadius: BorderRadius.circular(15.0),
        ),
        height: 190.0,
        width: 350.0,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(),
                  child: Stack(children: <Widget>[
                    //calling common widget

                    // RoundedCornerImageCard(
                    //   imageUrl:
                    //       "https://www.dfives.com/wp-content/uploads/2018/12/1-9.jpg",
                    //   imageHeight: 170,
                    //   imageWidth: 300,
                    //   imageRadius: 10,
                    // ),

                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Test",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.call,
                                      color: Colors.green,
                                      size: 14,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Test",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_pin,
                              color: Colors.indigoAccent,
                              size: 14,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Test",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                       Icons.my_location,
                              color: Colors.cyan,
                              size: 14,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Test",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ]),
                        ))
                  ])),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppTheme.appDefaultColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Align(
                      alignment: Alignment.center,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                           
                            callButton(),
                            bookNowButton(),
                          ])),
                ),
              ),
            ),
            Align(
              // These values are based on trial & error method
              alignment: Alignment(1.05, -1.05),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.close,
                      color: Colors.black54,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // showDialog(
    //     context: context, builder: (BuildContext context) => fancyDialog);
  }
}
