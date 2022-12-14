import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_apis/shared/cubit/cubit.dart';
import 'package:news_apis/shared/cubit/states.dart';
import 'package:news_apis/shared/network/local/cach_halper.dart';
import 'package:news_apis/shared/network/remote/dio_helper.dart';
import 'layout/news_app/news_layout.dart';

void main() async {
  ////// بتأكد ان كل حاجه هنا في اmethod خلصت وبعدين بيفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  BlocOverrides.runZoned(() {
    runApp(MyApp(isDark));
  });
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  // ignore: use_key_in_widget_constructors
  const MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit()
        ..changeMode(
          fromShard: isDark,
        ),
      child: BlocConsumer<ThemeCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                )),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: Colors.white,
                    unselectedIconTheme: IconThemeData(
                      color: Colors.grey,
                    ),
                    unselectedItemColor: Colors.grey,
                    elevation: 25.0),
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange),
                appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(
                    color: Colors.black,
                    size: 30.0,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                ),
                bottomAppBarTheme: const BottomAppBarTheme(
                  elevation: 20.0,
                )),
            darkTheme: ThemeData(
              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              )),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: HexColor('333739'),
                  unselectedIconTheme: const IconThemeData(
                    color: Colors.grey,
                  ),
                  unselectedItemColor: Colors.grey,
                  elevation: 25.0),
              scaffoldBackgroundColor: HexColor('333739'),
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                iconTheme: const IconThemeData(
                  color: Colors.white,
                  size: 30.0,
                ),
                backgroundColor: HexColor('333739'),
                elevation: 20.0,
                // ignore: deprecated_member_use
                // titleTextStyle: const TextStyle(
                //   color: Colors.white,
                //   fontSize: 20.0,
                //   fontWeight: FontWeight.bold,
                // ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
            ),
            themeMode: ThemeCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const NewsLayout(),
          );
        },
      ),
    );
  }
}
