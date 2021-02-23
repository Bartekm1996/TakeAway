class User {

  static final User _user = User._internal();
  String _email;
  String _userName;
  final bool _verified = true;

  factory User({String email, String userName})
  {
    _user._email = email;
    _user._userName = userName;
    return _user;
  }

  User._internal();


  String getEmail() => this._email;

  String getUserName() => this._userName;

  bool isVerified() => this._verified;


}