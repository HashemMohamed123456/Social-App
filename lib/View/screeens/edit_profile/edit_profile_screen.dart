import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/View/widgets/elevated_button_custom/elevated_button_custom.dart';
import 'package:social_app/View/widgets/textformfield_widget/textformfield_custom.dart';
import 'package:social_app/ViewModel/bloc/social_app_cubit/social_app_cubit.dart';
import '../../../ViewModel/bloc/social_app_cubit/social_app_states.dart';
class EditProfileScreen extends StatelessWidget {
    const EditProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (context,state){},
      builder: (context,state){
        SocialAppCubit.get(context).editProfileNameController.text=SocialAppCubit.get(context).userModel!.name!;
        SocialAppCubit.get(context).editProfileBioController.text=SocialAppCubit.get(context).userModel!.bio!;
        SocialAppCubit.get(context).editProfilePhoneController.text=SocialAppCubit.get(context).userModel!.phone!;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: const Icon(IconlyBroken.arrowLeft2),onPressed: (){
              Navigator.pop(context);
            },),
            title: const Text('Edit Profile'),
            titleSpacing: 0,
            actions: [
              TextButton(onPressed:(){
               SocialAppCubit.get(context).updateUser(
                   name:SocialAppCubit.get(context).editProfileNameController.text,
                   bio:SocialAppCubit.get(context).editProfileBioController.text,
                   phone:SocialAppCubit.get(context).editProfilePhoneController.text,
               );
              }, child:const Text('UPDATE',style: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.bold),))
            ],
          ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                if(state is SocialUpdateUserLoadingState)
                const LinearProgressIndicator(color:Colors.lightBlue),
                if(state is SocialUpdateUserLoadingState)
               const SizedBox(height: 10,),
               SizedBox(
                  height: 250,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: SocialAppCubit.get(context).coverImage==null?NetworkImage('${SocialAppCubit.get(context).userModel!.coverImage}',):
                                          FileImage(SocialAppCubit.get(context).coverImage!)
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
                                    SocialAppCubit.get(context).getCoverImage();
                                  }, icon:const Icon(IconlyBroken.camera,color: Colors.white,size:16))),
                            )
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 65,backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage:SocialAppCubit.get(context).profileImage==null?NetworkImage(
                                '${SocialAppCubit.get(context).userModel!.image}' ,
                              ):FileImage(SocialAppCubit.get(context).profileImage!),
                            ),
                            CircleAvatar(
                                radius: 18,
                                backgroundColor:Colors.lightBlue,
                                child: IconButton(onPressed:(){
                                  SocialAppCubit.get(context).getProfileImage();
                                }, icon:const Icon(IconlyBroken.camera,color: Colors.white,size:16)))],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height:10,),
                if(SocialAppCubit.get(context).profileImage!=null  || SocialAppCubit.get(context).coverImage!=null)
                  Row(
                  children: [
                    if(SocialAppCubit.get(context).profileImage!=null)
                    Expanded(child: Column(
                      children: [
                        ElevatedButtonWidget(buttonLabel: 'Update Profile',onPressed: (){
                          SocialAppCubit.get(context).uploadProfileImage(
                              name:SocialAppCubit.get(context).editProfileNameController.text,
                              bio:SocialAppCubit.get(context).editProfileBioController.text,
                              phone:SocialAppCubit.get(context).editProfilePhoneController.text
                          );
                        },),
                        if(state is SocialUpdateUserLoadingState)
                        const SizedBox(height: 5,),
                        if(state is SocialUpdateUserLoadingState)
                        const LinearProgressIndicator()
                      ],
                    )),
                    const SizedBox(width: 5,),
                    if(SocialAppCubit.get(context).coverImage!=null)
                    Expanded(child: Column(
                      children: [
                        ElevatedButtonWidget(buttonLabel:'Update Cover',onPressed: (){
                          SocialAppCubit.get(context).uploadCoverImage(
                              name:SocialAppCubit.get(context).editProfileNameController.text,
                              bio:SocialAppCubit.get(context).editProfileBioController.text,
                              phone:SocialAppCubit.get(context).editProfilePhoneController.text
                          );
                        },),
                        if(state is SocialUpdateUserLoadingState)
                        const SizedBox(height: 5,),
                        if(state is SocialUpdateUserLoadingState)
                        const LinearProgressIndicator()
                      ],
                    ))
                  ],
                ),
                if(SocialAppCubit.get(context).profileImage!=null  || SocialAppCubit.get(context).coverImage!=null)
                const SizedBox(height: 20,),
                TextFormFieldCustom(
                  controller: SocialAppCubit.get(context).editProfileNameController,
                  label: 'Name',
                  prefix: IconlyBroken.user2,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please Put Your New Name To Edit';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 10,),
                TextFormFieldCustom(
                  controller: SocialAppCubit.get(context).editProfileBioController,
                  label: 'Bio',
                  prefix: IconlyBroken.infoCircle,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please Put Your New Bio To Edit';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10,),
                TextFormFieldCustom(
                  controller: SocialAppCubit.get(context).editProfilePhoneController,
                  label: 'Phone',
                  prefix: IconlyBroken.call,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please Put Your New Phone Number To Edit';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
        ),) ;
      },
    );
  }
}
