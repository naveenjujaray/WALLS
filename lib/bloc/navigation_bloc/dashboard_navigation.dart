import 'package:Walls/blog/adminonly.dart';
import 'package:Walls/blog/allusers.dart';
import 'package:Walls/blog/blogpage.dart';
import 'package:Walls/blog/loginpage.dart';
import 'package:Walls/blog/services/usermanagement.dart';
import 'package:bloc/bloc.dart';
import 'package:Walls/pages/aboutpage.dart';
import 'package:Walls/pages/homepage.dart';
import 'package:Walls/pages/settingspage.dart';
enum DashboardEvents {
  HomePageClickedEvent,
  // SettingsPageClickedEvent,
  AboutPageClickedEvent,
  BlogPageClickedEvent,
  AdminPageClickedEvent,
  // LoginPageClickedEvent,
  UserPageClickedEvent,
  SignoutClickedEvent,
}

abstract class DashboardStates{}


class DashboardNavigation extends Bloc<DashboardEvents, DashboardStates> {
  @override
  DashboardStates get initialState => AdminPage();

  @override
  Stream<DashboardStates> mapEventToState(DashboardEvents event) async*{
    switch (event){
      case DashboardEvents.HomePageClickedEvent:
        yield HomePage();
        break;
    // case NavigationEvents.SettingsPageClickedEvent:
    // yield SettingsPage();
    // break;
      case DashboardEvents.AboutPageClickedEvent:
        yield AboutPage();
        break;
      case DashboardEvents.BlogPageClickedEvent:
        yield BlogPage();
        break;
      case DashboardEvents.AdminPageClickedEvent:
        yield AdminPage();
        break;
     // case DashboardEvents.LoginPageClickedEvent:
       // yield LoginPage();
        // break;
      case DashboardEvents.UserPageClickedEvent:
        yield UserPage();
        break;
     // case DashboardEvents.SignoutClickedEvent:
       // yield UserManagement().signOut();
        //break;
      case DashboardEvents.SignoutClickedEvent:
        // TODO: Handle this case.
        break;
    }
  }



}