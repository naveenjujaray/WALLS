import 'package:Walls/blog/adminonly.dart';
import 'package:Walls/blog/allusers.dart';
import 'package:Walls/blog/blogpage.dart';
import 'package:Walls/blog/loginpage.dart';
import 'package:Walls/blog/services/usermanagement.dart';
import 'package:bloc/bloc.dart';
import 'package:Walls/pages/aboutpage.dart';
import 'package:Walls/pages/homepage.dart';
import 'package:Walls/pages/settingspage.dart';
enum NavigationEvents {
  HomePageClickedEvent,
  // SettingsPageClickedEvent,
    AboutPageClickedEvent,
    BlogPageClickedEvent,
    AdminPageClickedEvent,
    LoginPageClickedEvent,
    UserPageClickedEvent,
    SignoutClickedEvent,
    DonateClickedEvent,
    }

    abstract class NavigationStates{}


class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
   NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async*{
    switch (event){
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
      break;
      // case NavigationEvents.SettingsPageClickedEvent:
        // yield SettingsPage();
        // break;
      case NavigationEvents.AboutPageClickedEvent:
        yield AboutPage();
        break;
      case NavigationEvents.BlogPageClickedEvent:
        yield BlogPage();
        break;
      case NavigationEvents.AdminPageClickedEvent:
        yield AdminPage();
        break;
      case NavigationEvents.LoginPageClickedEvent:
        yield LoginPage();
        break;
      case NavigationEvents.UserPageClickedEvent:
        yield UserPage();
        break;
      case NavigationEvents.SignoutClickedEvent:
        yield UserManagement().signOut();
        break;
    }
  }


}