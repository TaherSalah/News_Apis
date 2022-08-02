import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_apis/shared/cubit/cubit.dart';
import 'package:news_apis/shared/network/remote/dio_helper.dart';
import '../../shared/cubit/states.dart';
class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusinessData(),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: const Text('News App'),
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                  IconButton(onPressed: ()
                  {
                    ThemeCubit.get(context).changeMode();
                  },
                      icon: const Icon(Icons.brightness_4_outlined)),

                ],
              ),
              // floatingActionButton: FloatingActionButton(
              //   child: Icon(Icons.add),
              //   onPressed: ()
              //   {
              //   DioHelper.getData(
              //         url: 'v2/top-headlines',
              //         query: {
              //           'country':'eg',
              //           'category':'business',
              //           'apiKey':'0ec2a561fd4949cdb8cc32cd9b66a4a1',
              //         }
              //     ).then((value){
              //       print(value.data['articles'][3]['title'].toString());
              //     }).catchError((error){
              //       print(error.toString());
              //     });
              //   },

              // ),
              bottomNavigationBar: BottomNavigationBar(
                unselectedLabelStyle: const TextStyle(
                    fontSize: 10.5, fontWeight: FontWeight.w500),
                selectedIconTheme:
                    const IconThemeData(color: Colors.deepOrange),
                selectedItemColor: Colors.orange,
                type: BottomNavigationBarType.fixed,
                // selectedFontSize: 16.0,

                items: cubit.bottomItems,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
              ),
              body: cubit.screens[cubit.currentIndex],
            );
          }),
    );
  }
}
