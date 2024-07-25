import 'package:auto_route/auto_route.dart';

import 'main.dart';
import 'router.gr.dart';

/// `auto_route` パッケージによるアプリのルーターインスタンス。
final appRouter = AppRouter();

@AutoRouterConfig(replaceInRouteName: 'Page,PageRouteInfo')
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: HomePageRouteInfo.page,
      path: HomePage.path,
    ),
    AutoRoute(
      page: AddToAppHomePageRouteInfo.page,
      path: AddToAppHomePage.path,
    ),
    AutoRoute(
      page: ProfilePageRouteInfo.page,
      path: ProfilePage.path,
    ),
    AutoRoute(
      page: SettingsPageRouteInfo.page,
      path: SettingsPage.path,
    ),
  ];
}
