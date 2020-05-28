import 'package:bloc/bloc.dart';
import 'package:Walls/pages/aboutpage.dart';
import 'package:Walls/pages/homepage.dart';
import 'package:Walls/pages/settingspage.dart';
enum NavigationEvents {
  HomePageClickedEvent,
  // SettingsPageClickedEvent,
    AboutPageClickedEvent,
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

    }
  }


}