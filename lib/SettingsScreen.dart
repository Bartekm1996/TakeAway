import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Deliciousness/utils/globals.dart' as globals;
import 'package:image_picker/image_picker.dart';
import 'package:Deliciousness/widgets/PassWordPopUP.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:async';
import 'dart:io';
import 'LoginScreen.dart';
import 'auth0/auth0.dart';

final FlutterSecureStorage secureStorage = const FlutterSecureStorage();


class SettingsScreen extends StatefulWidget{

  final String accessToken;
  final String idToken;
  final Auth0Client auth0client;
  final String email;

  SettingsScreen({this.accessToken, this.idToken, this.auth0client, this.email});

  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen>{

  String nickName = "Name";
  String email = "Email";
  String pic = "Picture";
  String sub = "Sub";
  bool isEmailVerified = false;
  bool showEditButton = false;
  String watchConnected = 'Disconnected';
  File _image;
  Timer timer;
  static const channel = const MethodChannel('flutterChannel');

  @override
  void initState() {
    setDetails();
  //  watchConnectivityCall();
   // timer = Timer.periodic(Duration(seconds: 10), (Timer t) => watchConnectivityCall());
    super.initState();
  }

  Future<void> watchConnectivityCall() async {
    channel.invokeMethod("checkWatchState");
    channel.setMethodCallHandler((methodCall) async {
      if (methodCall.method == "flutterSettingsChannel") {
        print('Watch response ' + methodCall.arguments);
        if (methodCall.arguments != null) {
          setState(() {
            watchConnected = (methodCall.arguments == 'Disconnected' ? 'Disconnected' : 'Connected');
          });
        }
      }
    });
  }


  Brightness _getBrightness() {
    return globals.isDark ? Brightness.dark : Brightness.light;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        backgroundColor: globals.isDark ? null : Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          brightness: _getBrightness(),
          iconTheme: IconThemeData(color: globals.isDark ? Colors.white : Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(color: globals.isDark ? Colors.white : Colors.black),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10.0),
                    Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Stack(
                          children: <Widget>[
                            InkWell(
                              onTap: ()=>setState(()=> showEditButton = !showEditButton),
                              child: AvatarImage(pic: (this.pic.isEmpty ? "sense/assets/images/kermit.jpg" : this.pic)),
                            ),
                            if(showEditButton)
                              Positioned(
                                bottom: -120,
                                left: 138,
                                  child: MyArc(diameter: 127.0),
                              ),
                            if(showEditButton)
                              Positioned(
                                bottom: 20,
                                left: 30,
                                child:
                                  FlatButton(
                                    onPressed: () {
                                      _showPicker(context);
                                    },
                                    child: Text('Edit', style: TextStyle(fontSize: 15.0, fontFamily: 'Poppins')),
                                    color: Colors.transparent,
                                  ),
                              ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          this.nickName,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins"),
                        ),
                        Text(
                          this.email,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Poppins"),
                        ),
                        Text(
                          'Email Verified: ' + (this.isEmailVerified ? "True" : "False"),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        SizedBox(height: 10.0),
                        ListTile(
                          leading: Icon(
                            Icons.lock_outline,
                            color: Colors.blueAccent,
                          ),
                          title: Text("Password Settings"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PassWordDialogPopUp(accessToken: this.widget.accessToken, auth0client: this.widget.auth0client, email: this.widget.email, sub: this.sub);
                              },
                            );
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(
                            Icons.close,
                            color: Colors.blueAccent,
                          ),
                          title: Text("Close Account"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {

                          },
                        ),
                        Divider(),
                        LogOutPopUp(auth0client: this.widget.auth0client),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Notification Settings",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  SwitchListTile(
                    activeColor:  Colors.blueAccent,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text("Received notification"),
                    onChanged: (val) {},
                  ),
                  SwitchListTile(
                    activeColor: Colors.blueAccent,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text("Received App Updates"),
                    onChanged: (val){

                    },
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    "Background Theme",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  SwitchListTile(
                    activeColor: Colors.blueAccent,
                    contentPadding: const EdgeInsets.all(0),
                    value: globals.isDark,
                    title: Text("Dark"),
                    onChanged: (val) {
                      setState(() {
                        globals.isDark = !globals.isDark;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setDetails() {
    final idToken = JwtDecoder.decode(this.widget.idToken);
    if(idToken != null){
      setState(() {
        this.nickName = idToken['nickname'];
        this.email =  idToken['email'];
        this.pic =  idToken['picture'];
        this.isEmailVerified = idToken['email_verified'];
        this.sub = idToken['sub'];
      });
    }
  }


  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

}


class AvatarImage extends StatelessWidget {

  final String pic;
  const AvatarImage({Key key, this.pic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: (this.pic.contains('URL_TO_YOUR_DEFAULT_PICTURE_HERE') ? Image.network(this.pic.split('?')[0]).image : Image.network(this.pic).image),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({Key key, this.diameter = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          CustomPaint(
            painter: MyPainter(),
            size: Size(diameter, diameter),
          ),

        ],
    );
  }
}

class MyPainter extends CustomPainter {

  double pi = 3.1415926535897932;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;

    final degrees = 180;
    final radians = degrees * pi / 180;
    canvas.rotate(radians);


    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      pi,
      pi,
      false,
      paint,
    );



  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class LogOutPopUp extends StatelessWidget {

  final Auth0Client auth0client;
  final bool trailing;
  const LogOutPopUp({this.auth0client, this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.logout,
        color: Colors.blueAccent,
      ),
      title: Text("Log Out"),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        showLogOutDialog(context);

      },
    );
  }

  showLogOutDialog(BuildContext context){

    AlertDialog alertDialog =  AlertDialog(
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
          textColor: Theme.of(context).primaryColor,
          child: const Text('Cancel'),
        ),
        new FlatButton(
          onPressed: () {
            logoutAction();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                LoginScreen()), (Route<dynamic> route) => false);
          },
          textColor: Theme.of(context).primaryColor,
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