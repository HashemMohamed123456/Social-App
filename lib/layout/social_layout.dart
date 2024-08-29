import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/View/screeens/new_post_screen/new_post_screen.dart';
import 'package:social_app/View/screeens/notifications/notifiication_screen.dart';
import 'package:social_app/View/screeens/search/search_screen.dart';
import 'package:social_app/View/widgets/Navigation_component/navigations.dart';
import 'package:social_app/ViewModel/bloc/social_app_cubit/social_app_cubit.dart';
import '../ViewModel/bloc/social_app_cubit/social_app_states.dart';
class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (context,state){
      },
      builder: (context,state){
        var cubit=SocialAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.navigationBarIndex]),
            actions: [
              IconButton(onPressed: (){
                Navigation.navigateTo(context, const NotificationScreen());
              }, icon:const Icon(IconlyBroken.notification)),
              IconButton(onPressed: (){
                Navigation.navigateTo(context, const SearchScreen());
              }, icon:const Icon(IconlyBroken.search)),
              IconButton(onPressed: (){
                Navigation.navigateTo(context, const NewPostScreen());
              }, icon:const Icon(IconlyBroken.paperUpload))
            ],
          ),
          bottomNavigationBar:BottomNavigationBar(
            currentIndex: cubit.navigationBarIndex,
            onTap:(index){
              cubit.changeNavBarIndex(index);
            } ,
            items:const  [
              BottomNavigationBarItem(icon:Icon(IconlyBroken.home),label: 'Home'),
             BottomNavigationBarItem(icon:Icon(IconlyBroken.chat),label: 'Chat'),
             BottomNavigationBarItem(icon:Icon(IconlyBroken.location),label: 'User'),
             BottomNavigationBarItem(icon:Icon(IconlyBroken.setting),label: 'Settings'),
            ],
          ),
          body:cubit.navbarScreens[cubit.navigationBarIndex]
        );
      },
    );
  }
}
