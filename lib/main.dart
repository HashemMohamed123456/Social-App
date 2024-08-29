import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/View/screeens/login/login_screen.dart';
import 'package:social_app/ViewModel/bloc/social_app_cubit/social_app_cubit.dart';
import 'package:social_app/ViewModel/data/local/keys.dart';
import 'package:social_app/layout/social_layout.dart';
import 'ViewModel/bloc/bloc_observer/bloc_observer.dart';
import 'ViewModel/data/local/local_data.dart';
import 'firebase_options.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await LocalData.init();
  //LocalData.clearData();
  Bloc.observer = MyBlocObserver();
  SharedKeys.uId=LocalData.get(key:SharedKeys.uIdKey);
  final Widget? widget;
  if(SharedKeys.uId!=null){
    widget=const SocialLayout();
  }else{
    widget=const LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
   const MyApp({super.key,this.startWidget});
final Widget? startWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=>SocialAppCubit()..getUserData()..getAllPosts())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              elevation: 10,
              selectedItemColor:Colors.lightBlue,
              unselectedItemColor: Colors.blueGrey,
              selectedIconTheme:IconThemeData(
                  size: 30
              ),
              unselectedIconTheme: IconThemeData(
                  size: 20
              ),
              selectedLabelStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.deepOrange
              ),
              unselectedLabelStyle: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20
              )
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              shape: CircleBorder(),
              backgroundColor: Colors.deepOrange
          ),
          fontFamily: 'Jannah',
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              color: Colors.white,
              iconTheme: IconThemeData(
                  color: Colors.black
              )
          ),
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
        home:startWidget
      ),
    );
  }
}
