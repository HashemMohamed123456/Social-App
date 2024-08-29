import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/View/screeens/edit_profile/edit_profile_screen.dart';
import 'package:social_app/View/widgets/Navigation_component/navigations.dart';
import 'package:social_app/ViewModel/bloc/social_app_cubit/social_app_cubit.dart';
import 'package:social_app/ViewModel/bloc/social_app_cubit/social_app_states.dart';

import '../../widgets/elevated_button_custom/elevated_button_custom.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage('${SocialAppCubit.get(context).userModel!.coverImage}',)
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            )
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 65,backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:NetworkImage(
                          '${SocialAppCubit.get(context).userModel!.image}' ,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text('${SocialAppCubit.get(context).userModel!.name}',style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              Text('${SocialAppCubit.get(context).userModel!.bio}',style: const TextStyle(fontSize: 15,color: Colors.blueGrey),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(children: [
                          Text('100',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          const Text('Posts',style: const TextStyle(fontSize: 10,color: Colors.blueGrey),),
                        ],),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(children: [
                          Text('265',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          const Text('Photos',style: TextStyle(fontSize: 10,color: Colors.blueGrey),),
                        ],),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(children: [
                          Text('10k',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          const Text('Followers',style: TextStyle(fontSize: 10,color: Colors.blueGrey),),
                        ],),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(children: [
                          Text('1000',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          const Text('Following',style: TextStyle(fontSize: 10,color: Colors.blueGrey),),
                        ],),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButtonWidget(
                      buttonLabel: 'Add Photo',
                      onPressed: (){},
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(
                       onPressed: (){
                         Navigation.navigateTo(context, EditProfileScreen());
                       },
                      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
        ),
                        minimumSize: const Size(double.infinity,50),
                        backgroundColor: Colors.lightBlue
                      ), child:const Icon(IconlyBroken.edit,color: Colors.white,),
        )

                    )
                ],
              )
            ],
          ),
        );
      },

    );
  }
}