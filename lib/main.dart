import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:viria_dashboard/utils/app_strings.dart';
import 'package:viria_dashboard/utils/app_theme.dart';
import 'package:viria_dashboard/utils/route_generator.dart';
import 'package:viria_dashboard/utils/screen_bindings.dart';
import 'package:viria_dashboard/utils/session_management.dart/session_management.dart';
import 'package:viria_dashboard/utils/session_management.dart/session_token_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sessionManagement = SessionManagement();
  String initialRoute = kAuthScreenRoute;
  final refreshToken = await sessionManagement.getSessionToken(
    tokenKey: SessionTokenKeys.kRefreshTokenKey,
  );

  if (refreshToken.isNotEmpty) {
    initialRoute = kDashboardScreenRoute; 
  }

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: buildTheme(Brightness.light),
          title: 'Viriaa Admin',
          defaultTransition: Transition.noTransition,
          debugShowCheckedModeBanner: false,
          initialBinding: ScreenBindings(),
          initialRoute: initialRoute, 
          getPages: RouteGenerator.getPages(),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(
                  MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),
                ),
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}
