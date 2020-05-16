class User {
  // 工厂模式
  factory User() => _getInstance();
  static User get instance => _getInstance();
  static User _instance;
  User._internal() {
    // 初始化
  }
  static User _getInstance() {
    if (_instance == null) {
      _instance = new User._internal();
    }
    return _instance;
  }

  static var userInfo = new Map();
}
