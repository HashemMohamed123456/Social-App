import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/View/widgets/post_item/post_item.dart';
import 'package:social_app/ViewModel/bloc/social_app_cubit/social_app_cubit.dart';
import 'package:social_app/ViewModel/bloc/social_app_cubit/social_app_states.dart';
class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (context,state){},
      builder: (context,state){
        return SocialAppCubit.get(context).posts.isEmpty?
        const Center(child: CircularProgressIndicator(color:Colors.lightBlue,),)
            :SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(8),
                elevation: 10,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Image.network('https://img.freepik.com/free-photo/people-enjoying-guarana-drink-outdoors_23-2150765636.jpg?w=1380&t=st=1724746978~exp=1724747578~hmac=9fa394660b8e90904320bafba9cc74c4a36abf43d5dd68dd0601e13b3672d864',fit: BoxFit.cover,height: 200,width: double.infinity,),
                    Text('Communicate with friends',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                  ],
                ),
              ),
              ListView.separated(shrinkWrap: true,itemBuilder:(context,index){
                return  PostItem(
                  postModel: SocialAppCubit.get(context).posts[index],
                );
              }, separatorBuilder:(context,index)=>Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: 1,color: Colors.grey,width: double.infinity),
              ), itemCount:SocialAppCubit.get(context).posts.length,physics: const NeverScrollableScrollPhysics(),)
            ],
          ),
        );
      },
    );
  }
}