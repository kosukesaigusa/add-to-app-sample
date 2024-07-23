// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:add_to_app_sample/main.dart' as _i1;
import 'package:auto_route/auto_route.dart' as _i2;

abstract class $AppRouter extends _i2.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    AddToAppHomePageRouteInfo.name: (routeData) {
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddToAppHomePage(),
      );
    },
    HomePageRouteInfo.name: (routeData) {
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    ProfilePageRouteInfo.name: (routeData) {
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ProfilePage(),
      );
    },
    SettingsPageRouteInfo.name: (routeData) {
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.SettingsPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddToAppHomePage]
class AddToAppHomePageRouteInfo extends _i2.PageRouteInfo<void> {
  const AddToAppHomePageRouteInfo({List<_i2.PageRouteInfo>? children})
      : super(
          AddToAppHomePageRouteInfo.name,
          initialChildren: children,
        );

  static const String name = 'AddToAppHomePageRouteInfo';

  static const _i2.PageInfo<void> page = _i2.PageInfo<void>(name);
}

/// generated route for
/// [_i1.HomePage]
class HomePageRouteInfo extends _i2.PageRouteInfo<void> {
  const HomePageRouteInfo({List<_i2.PageRouteInfo>? children})
      : super(
          HomePageRouteInfo.name,
          initialChildren: children,
        );

  static const String name = 'HomePageRouteInfo';

  static const _i2.PageInfo<void> page = _i2.PageInfo<void>(name);
}

/// generated route for
/// [_i1.ProfilePage]
class ProfilePageRouteInfo extends _i2.PageRouteInfo<void> {
  const ProfilePageRouteInfo({List<_i2.PageRouteInfo>? children})
      : super(
          ProfilePageRouteInfo.name,
          initialChildren: children,
        );

  static const String name = 'ProfilePageRouteInfo';

  static const _i2.PageInfo<void> page = _i2.PageInfo<void>(name);
}

/// generated route for
/// [_i1.SettingsPage]
class SettingsPageRouteInfo extends _i2.PageRouteInfo<void> {
  const SettingsPageRouteInfo({List<_i2.PageRouteInfo>? children})
      : super(
          SettingsPageRouteInfo.name,
          initialChildren: children,
        );

  static const String name = 'SettingsPageRouteInfo';

  static const _i2.PageInfo<void> page = _i2.PageInfo<void>(name);
}
