import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/ViewModel/bloc/social_app_cubit/social_app_cubit.dart';
import 'package:social_app/ViewModel/bloc/social_app_cubit/social_app_states.dart';
class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
            leading: IconButton(icon: const Icon(IconlyBroken.arrowLeft2),onPressed: (){
              Navigator.pop(context);
            },),
            titleSpacing: 0,
            actions: [
              TextButton(onPressed:(){
                if(SocialAppCubit.get(context).postImage==null){
                  SocialAppCubit.get(context).createPost(
                      dateTime:SocialAppCubit.get(context).now,
                      text:SocialAppCubit.get(context).postController.text);
                  SocialAppCubit.get(context).postController.clear();
                }else{
                  SocialAppCubit.get(context).uploadPostImage(
                      dateTime:SocialAppCubit.get(context).now,
                      text:SocialAppCubit.get(context).postController.text);
                  SocialAppCubit.get(context).postController.clear();
                }
              }, child:const Text('POST',style: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.bold),))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                const LinearProgressIndicator(color: Colors.lightBlue,),
                if(state is SocialCreatePostLoadingState)
                const SizedBox(height: 10,),
                Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage:NetworkImage('${SocialAppCubit.get(context).userModel!.image}'),
                      ),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('${SocialAppCubit.get(context).userModel!.name}',style: const TextStyle(fontWeight: FontWeight.w900,height: 1.4),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]
                ),
                Expanded(
                  child: TextFormField(
                    controller: SocialAppCubit.get(context).postController,
                    decoration: InputDecoration(
                      hintText: 'What\'s On Your Mind ${SocialAppCubit.get(context).userModel!.name}',
                      border: InputBorder.none
                    ),
                  ),
                ),
                if(SocialAppCubit.get(context).postImage!=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(SocialAppCubit.get(context).postImage!)
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          radius: 18,
                          backgroundColor:Colors.lightBlue,
                          child: IconButton(onPressed:(){
                            SocialAppCubit.get(context).removePostImage();
                          }, icon:const Icon(Icons.close,color: Colors.white,size:16))),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed:(){
                        SocialAppCubit.get(context).getPostImage();
                      }, child:const Row(
                        children: [
                         Icon(IconlyBroken.image,color: Colors.lightBlue,),
                         SizedBox(width: 5,),
                          Text('Add Photo',style:TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.bold))
                        ],
                      )
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          TextButton(onPressed:(){},
                              child:
                              const Text('# tags',
                                  style:TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.bold))
                          ),
                        ],
                      ),
                    )
                  ],
                ),
               
              ],
            ),
          ),
        );
      },
    );
  }
}
