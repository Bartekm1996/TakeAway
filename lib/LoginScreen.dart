import 'package:Deliciousness/RegisterScreen.dart';
import 'package:Deliciousness/utils/constant.dart';
import 'package:Deliciousness/widgets/my_header.dart';
import 'package:Deliciousness/auth0/auth0.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:Deliciousness/ProfileScreen.dart';
import 'package:Deliciousness/widgets/InfoDialogPopUp.dart';
import 'package:Deliciousness/widgets/ForgotPassWordDialog.dart';
import 'package:Deliciousness/utils/urls.dart' as urls;

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController myPwdController;
  TextEditingController myUserNameController;
  final controller = ScrollController();
  double offset = 10;
  bool _isSelected = false;
  bool passwordInvisible = true;
  bool passValidateText = false;
  bool userNameValidateText = false;
  Auth0Client auth0client;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Deliciousness.png",
              offset: offset,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Container(
              width: double.infinity,
                padding: EdgeInsets.only(bottom: 1),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 15.0),
                          blurRadius: 15.0),
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, -10.0),
                          blurRadius: 10.0),
                    ]),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Text("Login",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(45),
                              fontFamily: "Poppins-Bold",
                              letterSpacing: .6)),
                      SizedBox(
                        height: ScreenUtil().setHeight(30),
                      ),
                      Text("Email",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: ScreenUtil().setSp(26))),
                      TextField(
                        controller: myUserNameController,
                        decoration: InputDecoration(
                            hintText: "Enter your email",
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                            errorText: userNameValidateText ? 'Email Can\'t Be Empty' : null,
                            errorStyle: TextStyle(color: Colors.red, fontSize: 12.0),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(30),
                      ),
                      Text("PassWord",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: ScreenUtil().setSp(26))),
                      TextFormField(
                        controller: myPwdController,
                        obscureText: passwordInvisible,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordInvisible = (passwordInvisible ? false : true);
                                });
                              },
                              icon: Icon(
                                passwordInvisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Enter your password",
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                            errorText: passValidateText ? 'Password Can\'t Be Empty' : null,
                            errorStyle: TextStyle(color: Colors.red, fontSize: 12.0),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(35),
                      ),
                    ],
                  ),
                ),
              ),
                  SizedBox(height: ScreenUtil().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          child: Container(
                            width: ScreenUtil().setWidth(330),
                            height: ScreenUtil().setHeight(100),
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: kActiveShadowColor,
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  //loginAction();
                                  if(myUserNameController.text.isEmpty){
                                    setState(() {
                                      userNameValidateText = true;
                                    });
                                  }

                                  if(myPwdController.text.isEmpty){
                                    setState(() {
                                      passValidateText = true;
                                    });
                                  }
                                  if(!(myPwdController.text.isEmpty && myUserNameController.text.isEmpty)) {
                                    loginAction();
                                  }
                                },
                                child: Center(
                                  child: Text("SIGN IN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins-Bold",
                                          fontSize: 18,
                                          letterSpacing: 1.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: new EdgeInsets.only(top: 10.0),
                      child:InkWell(
                        onTap: () {

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ForgotPassWordDialog(auth0client: this.auth0client);
                              }
                          );

                        },
                        child: Text("Forgot Password",
                          style: TextStyle(
                            color: Color(0xFF5d74e3),
                            fontFamily: "Poppins-Bold",
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(120.0),
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil().setWidth(100.0),
                        ),
                        Text("Don't have an account ?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Poppins",
                            fontSize: 14.0,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15.0),
                          child:InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(auth0client: this.auth0client)));
                              },
                            child: Text("Sign Up",
                              style: TextStyle(
                                color: Color(0xFF5d74e3),
                                fontFamily: "Poppins-Bold",
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20.0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    myPwdController.dispose();
    myUserNameController.dispose();
    super.dispose();
  }

  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

  @override
  void initState() {
    initAction();
    auth0client = Auth0Client(clientId: urls.AUTH0_CLIENT_ID, clientSecret: urls.AUTH0_CLIENT_SECRET, domain: urls.AUTH0_DOMAIN,
        connectTimeout: 10000, sendTimeout: 10000, receiveTimeout: 60000, useLoggerInterceptor: true);
    super.initState();
    this.myUserNameController = TextEditingController();
    this.myPwdController = TextEditingController();
    controller.addListener(onScroll);
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  void loginAction() {
    var idToken;
    try {

        var details = new Map<String, String>();
            details['username'] = myUserNameController.text;
            details['password'] = myPwdController.text;
            details['audience'] = urls.AUTH0_CONST_AUDIENCE;
            details['scope'] = 'openid profile email';


        auth0client.passwordGrantMFA(details).then((response) => {
            idToken = this.auth0client.parseIdToken(response.idToken),
            secureStorage.write(key: 'refresh_token', value: response.refreshToken),

            if (idToken != null ) {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (context) =>
                  ProfileScreen(name: idToken['nickname'],
                      email: idToken['email'],
                      picture: idToken['picture'],
                      emailVerified: idToken['email_verified'],
                      accessToken: response.accessToken,
                      idToken: response.idToken,
                      auth0client: auth0client,
                      userId: idToken['sub'])),(Route<dynamic> route) => false),
        }

    }).catchError((err) => {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBoxState(title: "Login Failed",
                    description: 'Incorrect  email or password');
              }
          )
        });

    } catch (e, s) {
      print('login error: $e - stack: $s');
    }

  }

  void writeOtpKeys(String mfaToken) async {
    await secureStorage.write(
        key: 'mfa_token', value: mfaToken);
  }

  void logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
    await secureStorage.delete(key: 'mfa_token');
  }

  void initAction() async {

    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) return;

    try {

        final response = await appAuth.token(TokenRequest(
          urls.AUTH0_CLIENT_ID,
          urls.AUTH0_REDIRECT_URI,
          issuer: urls.AUTH0_ISSUER,
          refreshToken: storedRefreshToken,
        ));

        final idToken = this.auth0client.parseIdToken(response.idToken);

        secureStorage.write(key: 'refresh_token', value: response.refreshToken);

        if (idToken != null ) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (context) =>
                  ProfileScreen(name: idToken['nickname'],
                      email: idToken['email'],
                      picture: idToken['picture'],
                      emailVerified: idToken['email_verified'],
                      accessToken: response.accessToken,
                      idToken: response.idToken,
                      auth0client: auth0client,
                      userId: idToken['sub'])),(Route<dynamic> route) => false);
        }


    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      logoutAction();
    }
  }
}
