import 'package:Deliciousness/SettingsScreen.dart';
import 'package:Deliciousness/auth0/auth0.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:Deliciousness/utils/constant.dart';
import 'package:Deliciousness/widgets/profile_list_item.dart';
import 'package:Deliciousness/LoginScreen.dart';
import 'package:Deliciousness/utils/globals.dart' as globals;

final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

class ProfileScreen extends StatefulWidget {

  ProfileScreen();
  
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfileScreen> {

  List<String> notifcations = new List();
  Brightness _getBrightness() {
    return globals.isDark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        appBar: AppBar(title: Text('')),
        backgroundColor: globals.isDark ? null : Colors.grey.shade200,
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Image.asset('assets/icons/Deliciousness.png'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Order'),
                leading: Icon(Icons.fastfood, color: Colors.blueAccent),
                onTap: () {

                },
              ),
              ListTile(
                title: Text('Account & Settings'),
                leading: Icon(Icons.account_circle_outlined, color: Colors.blueAccent),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                },
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Divider(),
              ),
              //LogOutPopUp(auth0client: this.widget.auth0client),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Restaurants',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.blueAccent,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                        ),
                    ),
                  ),
                  Container(
                    height: 300,
                      child: this.notifcations.isEmpty ? Center(child: Text('No Restaurants to show', textAlign: TextAlign.center)) : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: notifcations.length,
                        itemBuilder: (context, index) {
                          return Text(notifcations[index]);
                        },
                        padding: new EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 50.0,
                        ),
                      ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Recent Orders',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    height: 300,
                    child: this.notifcations.isEmpty ? Center(child: Text('No Recent Orders', textAlign: TextAlign.center)) : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: notifcations.length,
                      itemBuilder: (context, index) {
                        return Text(notifcations[index]);
                      },
                      padding: new EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 50.0,
                      ),
                    ),
                  ),
                ],
              ),

            ),

          ],

        ),
      ),
    );
  }
}



class AppBarButton extends StatelessWidget {
  final IconData icon;
  const AppBarButton({this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kAppPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: kLightBlack,
              offset: Offset(1, 1),
              blurRadius: 10,
            ),
            BoxShadow(
              color: kWhite,
              offset: Offset(-1, -1),
              blurRadius: 10,
            ),
          ]),
      child: Icon(
        icon,
        color: fCL,
      ),
    );
  }
}




class ProfileListItems extends StatelessWidget {

  final Auth0Client auth0client;
  final String accessToken;
  final String userId;
  final String idToken;
  final String email;
  const ProfileListItems({this.auth0client, this.accessToken, this.userId, this.idToken, this.email});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          InkWell(
            onTap: () {
            },
            child: ProfileListItem(
              icon: LineAwesomeIcons.users,
              text: 'Shared Alarms',
            ),
          ),
          InkWell(
            onTap: () {
            },
            child:  ProfileListItem(
              icon: LineAwesomeIcons.cog,
              text: 'Account & Settings',
            ),
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.question_circle,
            text: 'Help & Support',
          ),
        ],
      ),
    );
  }
}

class LogOutPopUp extends StatelessWidget {

  final Auth0Client auth0client;

  const LogOutPopUp({this.auth0client});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.logout,
        color: Colors.blueAccent,
      ),
      title: Text("Log Out"),
      onTap: () {
        showLogOutDialog(context);
      },
    );
  }

  showLogOutDialog(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: const Text('Log Out'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Are You Sure You Want To Log Out"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          textColor: Theme
              .of(context)
              .primaryColor,
          child: const Text('Cancel'),
        ),
        new FlatButton(
          onPressed: () {
            logoutAction();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) =>
                    LoginScreen()), (Route<dynamic> route) => false);
          },
          textColor: Theme
              .of(context)
              .primaryColor,
          child: const Text('Log Out'),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  void logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
    await secureStorage.delete(key: 'mfa_token');
  }
}
