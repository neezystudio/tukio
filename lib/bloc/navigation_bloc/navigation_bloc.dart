import 'package:bloc/bloc.dart';
import 'package:tukio/pages/check_in/check_in.dart';
import 'package:tukio/pages/Check_out/check_out.dart';
import 'package:tukio/pages/event_tabs/options.dart';
import 'package:tukio/pages/homescreen.dart';
import 'package:tukio/pages/settings.dart';

enum NavigationEvents {
  DashboardClickedEvent,
  OptionsClickedEvent,
  CheckInClickedEvent,
  CheckOutClickedEvent,
  SettingsClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  final Function onMenuTap;

  NavigationBloc(this.onMenuTap);

  NavigationStates get initialState => HomePage(
        onMenuTap: onMenuTap,
      );

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashboardClickedEvent:
        yield HomePage(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.OptionsClickedEvent:
        yield OptionsPage(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.CheckInClickedEvent:
        yield CheckInPage(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.CheckOutClickedEvent:
        yield CheckOutPage(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.SettingsClickedEvent:
        yield SettingsPage(
          onMenuTap: onMenuTap,
        );
    }
  }
}
