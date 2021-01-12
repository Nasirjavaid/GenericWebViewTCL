import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:truemedapp/config/appConstants.dart';

import 'package:truemedapp/config/methods.dart';


import 'package:truemedapp/ui/Screen/MapScreen/myNavDrawerItems.dart';
import 'package:truemedapp/ui/Screen/WebViewContainerScreen/webViewContainer.dart';
import 'package:url_launcher/url_launcher.dart';

// class MyNaveDrawerMain extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: BlocProvider(
//         create: (context) {
//           return UserProfileBloc()..add(GetUserDataUserProfileEvent());
//         },
//         child: MyNavDrawer(context),
//       ),
//     );
//   }
// }

class MyNavDrawer extends StatefulWidget {
  final BuildContext context;
  MyNavDrawer(this.context);

  @override
  _MyNavDrawerState createState() => _MyNavDrawerState();
}

class _MyNavDrawerState extends State<MyNavDrawer> {
  

  bool userLoignStatus = false;
  String userImagePlaceHolder =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/768px-Circle-icons-profile.svg.png";

  @override
  void initState() {
    
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(0), topRight: Radius.circular(0)),
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(color: Colors.green, spreadRadius: 3),
        // ],
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.75,
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.

      child: Column(
        // Important: Remove any padding from the ListView
        // padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: 0),
          // rawer header
          DrawerHeader(
            child: userInfoWidget(),

            // BlocBuilder<UserProfileBloc, UserProfileState>(
            //   builder: (BuildContext context, state) {
            //     UserLogin userLoginFailure = UserLogin();
            //     if (state is InProgresssGettingUserProfileState) {
            //       return CommonWidgets.progressIndicator;
            //     }
            //     if (state is UserProfiledetailTakenSuccessfully) {
            //       return userInfoWidget(state.userLogin);
            //     }

            //     if (state is FailedTogetUserProfileData) {
            //       return Center(child: userInfoWidget(userLoginFailure));
            //     }

            //     return Container();
            //   },
            //)
          ),

          SingleChildScrollView(
            // color: Colors.transparent,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.69,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    new MyDrawerItems(context).drawerItem(
                        icon: Icons.label_important_outline,
                        text: 'Book Now',
                        iconColor: Colors.black54,
                        onTap: () => {
                              //clossing the nav drawer after click
                              Navigator.pop(context),
                              Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WebViewContainer(APIConstants.labEndPoint, "Book Now")))
                            }),
                    Divider(),
                    SizedBox(
                      height: 0,
                    ),
                    new MyDrawerItems(context).drawerItem(
                        icon: Icons.input,
                        iconColor: Colors.black54,
                        text: 'Call Now',
                        onTap: () => {
                              //clossing the nav drawer after click
                              Navigator.pop(context),
                             _callMe(APIConstants.phoneNumber),
                            }),
                    Divider(),
                    SizedBox(
                      height: 0,
                    ),
                    Spacer(),
                   

                    Builder(
                      builder: (
                        BuildContext context,
                      ) {
                        if (userLoignStatus==false) {
                         return Container();
                          // return MyDrawerItems(context).drawerItem(
                          //     icon: FontAwesomeIcons.powerOff,
                          //     iconColor: Colors.redAccent,
                          //     text: 'Login',
                          //     onTap: () => {
                          //           //clossing the nav drawer after click
                          //           Navigator.pop(context),

                          //           // BlocProvider.of<UserAuthBloc>(context)
                          //           //     .add(AuthLoggedOut()),
                          //           // Navigator.push(
                          //           //   context,
                          //           //   MaterialPageRoute(
                          //           //     builder: (context) => LoginPage(
                          //           //       userAuthRepository:
                          //           //           userAuthRepository,
                          //           //     ),
                          //           //   ),
                          //           // ),
                          //         });
                        } else {
                          // return MyDrawerItems(context).drawerItem(
                          //     icon: FontAwesomeIcons.powerOff,
                          //     iconColor: Colors.green,
                          //     text: 'Logout',
                          //     onTap: () {
                          //         Navigator.pop(context);
                          //       // BlocProvider.of<UserAuthBloc>(context)
                          //       //     .add(AuthLoggedOut());

                          //       //     Methods.showToast(context, "Logged out");
                          //     });
                        }
                      },
                    ),
                    // new MyDrawerItems(context).drawerItem(
                    //     icon: Icons.settings_power_rounded,
                    //     text: 'Login',
                    //     onTap: () => {
                    //           //clossing the nav drawer after click
                    //           Navigator.pop(context),

                    //           // NetworkConnectivity.check().then((internet) {
                    //           //   if (internet) {
                    //           //     Navigator.push(
                    //           //       context,
                    //           //       MaterialPageRoute(
                    //           //         builder: (context) => WebViewContainer(
                    //           //             "https://unique-itsolutions.co.uk/restaurant-demo/new/contact",
                    //           //             "Contact us"),
                    //           //       ),
                    //           //     );
                    //           //   } else {
                    //           //     //show network erro

                    //           //     Methods.showToast(context, "Check your network");
                    //           //   }
                    //           // }),

                    //           Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                 builder: (context) => LoginPage(
                    //                   userAuthRepository: userAuthRepository,
                    //                 ),
                    //               )),
                    //         }),
                  ]),
            ),
          )
        ],
      ),
    );
  }

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

  Widget userInfoWidget() {
    return Column(
      children: [
        SizedBox(height: 10),
        Stack(children: [
          Align(
            child: Center(
              child: Container(
                  height: 110,
                  width: 120,
                  child: Image.asset('assets/images/honu.png')),
            ),
          ),
          //   Positioned.fill(
          //     child: Align(
          //       alignment: Alignment(0, 1.5),
          //       child: Container(
          //           width: 27,
          //           height: 27,
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             border: Border.all(color: Colors.white),
          //             //borderRadius: BorderRadius.all(Radius.circular(25)),
          //             shape: BoxShape.circle,
          //           ),
          //           child: IconButton(
          //               icon: Icon(
          //                 Icons.edit,
          //                 color: Colors.amber,
          //                 size: 10,
          //               ),
          //               onPressed: () {

          //               })),
          //     ),
          //   )
        ]),
        // SizedBox(height: 15),
        // Text("Honu",
        //     style: Theme.of(context)
        //         .textTheme
        //         .bodyText2
        //         .copyWith(color: Colors.black87, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
