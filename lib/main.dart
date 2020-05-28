import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:Walls/pages/aboutpage.dart';
import 'package:Walls/pages/homepage.dart';
import 'package:Walls/pages/nav.dart';
import 'package:Walls/pages/search.dart';
import 'package:Walls/sidebar/sidebar_layout.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:Walls/pages/splash_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wiredash/wiredash.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomePage(),
};

void main() {
  InAppPurchaseConnection.enablePendingPurchases();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));

  runApp(MyMain());
}
class Translation extends WiredashTranslationData{

}

class MyMain extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MyMainState();
}

class MyMainState extends State<MyMain> {
  final QuickActions _quickActions = QuickActions();
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  final _navigatorKey = GlobalKey<NavigatorState>();
  final String projectId = "walls-d5jrdmo";
  final String secretKey = "1jsxsfpdu0hp33hsebubnisgj9kxsixl";
  int _counter = 0;

  void _incrementCounter(){
    setState(() {
      _counter++;
    });
  }
  @override
  void initState() {
    super.initState();

    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);

    firebaseMessaging.configure(
      // ignore: missing_return
      onLaunch: (Map<String, dynamic> msg) {
        print(" onLaunch called ${(msg)}");
      },
      // ignore: missing_return
      onResume: (Map<String, dynamic> msg) {
        print(" onResume called ${(msg)}");
      },
      // ignore: missing_return
      onMessage: (Map<String, dynamic> msg) {
        showNotification(msg);
        print(" onMessage called ${(msg)}");
      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('IOS Setting Registed');
    });
    firebaseMessaging.getToken().then((token) {
      update(token);
    });

    _quickActions.initialize((String shortcut) {
      print(shortcut);
      if (shortcut != null) {
        if (shortcut == 'Home') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => HomePage(),
            ),
          );
        } else if (shortcut == 'Search') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => Search(),
            ),
          );
        } //else if (shortcut == 'Feedback') {
        //Navigator.push(
        //context,
        //MaterialPageRoute(
        //builder: (ctx) => BlogPage(),
        //),
        //);
        //}
        else {
          debugPrint('No quick action selected!');
        }
      }
    });
    _quickActions.setShortcutItems(
      <ShortcutItem>[
        //const ShortcutItem(type: 'Home', localizedTitle: 'Home', icon: 'home'),
        const ShortcutItem(
            type: 'Home', localizedTitle: 'New Wallpapers', icon: 'walls'),

        //const ShortcutItem(
        // type: 'Feedback', localizedTitle: 'Feedback',  icon: 'book')
      ],
    );
  }

  showNotification(Map<String, dynamic> msg) async {
    var android = new AndroidNotificationDetails(
      'sdffds dsffds',
      "CHANNLE NAME",
      "channelDescription",
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, "This is title", "this is demo", platform);
  }

  update(String token) {
    print(token);
    DatabaseReference databaseReference = new FirebaseDatabase().reference();
    databaseReference.child('fcm-token/$token').set({"token": token});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      theme: WiredashThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent,
        secondaryColor: Colors.blueAccent,
        dividerColor: Colors.white,
      ),
      secret: secretKey,
      projectId: projectId,
      navigatorKey: _navigatorKey,
      options: WiredashOptionsData(
        showDebugFloatingEntryPoint: false,
      ),
      child: new MaterialApp(
        navigatorKey: _navigatorKey,
        theme: ThemeData(primaryColor: Colors.black, accentColor: Colors.cyan),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{

          '/homepage': (BuildContext context) => SideBarLayout(),

          '/aboutpage': (BuildContext context) => AboutPage(),

        },
      ),
    );
  }
}
