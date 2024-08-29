import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/Model/Post_model/post_model.dart';
import 'package:social_app/ViewModel/bloc/social_app_cubit/social_app_cubit.dart';
import 'package:social_app/ViewModel/bloc/social_app_cubit/social_app_states.dart';
class PostItem extends StatelessWidget {
  final PostModel? postModel;
  const PostItem({super.key,this.postModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          elevation: 10,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:NetworkImage('${postModel!.image}'),
                    ),
                    const SizedBox(width: 15,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('${postModel!.name}',style: const TextStyle(fontWeight: FontWeight.w900,height: 1.4),),
                              const SizedBox(width: 10,),
                              const Icon(Icons.check_circle,color:Colors.blue,size:16)
                            ],
                          ),
                          Text('${postModel!.dateTime}',style: const TextStyle(color:Colors.grey,fontSize:10,height: 1.4),)
                        ],
                      ),
                    ),
                    const SizedBox(width: 15,),
                    IconButton(onPressed: (){}, icon:const Icon(Icons.more_horiz)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(color: Colors.grey[400],height: 1,width: double.infinity,),
                ),
                Text('${postModel!.text}',
                  style: const TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 15,),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                      children: [
                        SizedBox(
                            height: 25,
                            child: MaterialButton(padding: EdgeInsets.zero,onPressed:(){}, child:Text('#Software',style: TextStyle(color: Colors.blue),),minWidth:1,)),
                        SizedBox(
                            height: 25,
                            child: MaterialButton(padding: EdgeInsets.zero,onPressed:(){}, child:Text('#Software',style: TextStyle(color: Colors.blue),),minWidth: 1,)),
                        SizedBox(
                            height: 25,
                            child: MaterialButton(padding: EdgeInsets.zero,onPressed:(){}, child:Text('#Software',style: TextStyle(color: Colors.blue),),minWidth: 1,)),
                        SizedBox(
                            height: 25,
                            child: MaterialButton(padding: EdgeInsets.zero,onPressed:(){}, child:Text('#Software_development',style: TextStyle(color: Colors.blue),),minWidth: 1,)),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('${postModel!.image}',)
                        ),
                        borderRadius: BorderRadius.circular(4)
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Icon(IconlyBroken.heart,color: Colors.red,size: 20,),
                              const SizedBox(width: 5,),
                              Text('1200',style: TextStyle(color: Colors.grey,fontSize: 15),),
                            ],
                          ),
                        ),
                        onTap: (){},),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(IconlyBroken.message,color: Colors.amber,size: 20,),
                              const SizedBox(width: 5,),
                              Text('1200 Comments',style: TextStyle(color: Colors.grey,fontSize: 15),),
                            ],
                          ),
                        ),
                        onTap: (){},),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(color: Colors.grey[400],height: 1,width: double.infinity,),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage:NetworkImage('https://img.freepik.com/free-photo/brazilian-woman-having-guarana-drink-outdoors_23-2150765625.jpg?w=740&t=st=1724750182~exp=1724750782~hmac=77f2ed0629f7ead8db89386b6cdc3ba7c402a1da8318df880db1c2c6c7790c9d'),
                          ),
                          const SizedBox(width:15 ,),
                          Text('Write a Comment...',style: TextStyle(color:Colors.blueGrey),),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Icon(IconlyBroken.message,color: Colors.amber,size: 20,),
                          const SizedBox(width: 5,),
                          Text('Like',style: TextStyle(color: Colors.grey,fontSize: 15),),
                        ],
                      ),
                      onTap: (){},),
                    const SizedBox(width: 15,),
                    InkWell(
                      child: Row(
                        children: [
                          Icon(IconlyBroken.upload,color: Colors.green,size: 20,),
                          const SizedBox(width: 5,),
                          Text('Share',style: TextStyle(color: Colors.grey,fontSize: 15),),
                        ],
                      ),
                      onTap: (){},),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
