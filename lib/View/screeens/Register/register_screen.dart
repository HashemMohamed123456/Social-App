import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/View/screeens/login/login_screen.dart';
import 'package:social_app/View/widgets/Navigation_component/navigations.dart';
import 'package:social_app/ViewModel/bloc/social_register_cubit/social_registe_cubit.dart';
import 'package:social_app/ViewModel/bloc/social_register_cubit/social_register_states.dart';
import 'package:social_app/layout/social_layout.dart';
import '../../widgets/elevated_button_custom/elevated_button_custom.dart';
import '../../widgets/textformfield_widget/textformfield_custom.dart';
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state){
          if(state is SocialUserCreationSuccessState){
            Navigation.navigateToAndFinish(context,const SocialLayout());
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar:AppBar(
              title: const Text('Social'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: SocialRegisterCubit.get(context).formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Registration Form',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900),),
                          const SizedBox(height: 20,),
                          TextFormFieldCustom(
                            controller: SocialRegisterCubit.get(context).nameController,
                            label: 'Name',
                            prefix: Icons.person,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please Enter your Name!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextFormFieldCustom(
                            controller: SocialRegisterCubit.get(context).phoneController,
                            label: 'Phone',
                            prefix: Icons.phone,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please Enter your Phone!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextFormFieldCustom(
                            controller: SocialRegisterCubit.get(context).emailController,
                            label: 'Email',
                            prefix: Icons.email,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please put your Email!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextFormFieldCustom(
                            controller:SocialRegisterCubit.get(context).passwordController,
                            label: 'Password',
                            prefix: Icons.lock,
                            suffix:SocialRegisterCubit.get(context).passwordSuffix,
                            obscureText:SocialRegisterCubit.get(context).isPassword,
                            onSuffixPressed: (){
                              SocialRegisterCubit.get(context).changePasswordSuffixIcon();
                            },
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please put your Password!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value){
                              if(SocialRegisterCubit.get(context).formKey.currentState!.validate()){
                                  SocialRegisterCubit.get(context).userRegister(
                                      name:SocialRegisterCubit.get(context).nameController.text,
                                      phone:SocialRegisterCubit.get(context).phoneController.text,
                                      email:SocialRegisterCubit.get(context).emailController.text,
                                      password:SocialRegisterCubit.get(context).passwordController.text);
                              }
                            },
                          ),
                          const SizedBox(height: 20,),
                          (state is SocialRegisterLoadingState)?
                          const Center(child: CircularProgressIndicator(color: Colors.lightBlue,),):
                          ElevatedButtonWidget(buttonLabel: 'Register',onPressed: (){
                            if(SocialRegisterCubit.get(context).formKey.currentState!.validate()){
                              SocialRegisterCubit.get(context).userRegister(
                                  name:SocialRegisterCubit.get(context).nameController.text,
                                  phone:SocialRegisterCubit.get(context).phoneController.text,
                                  email:SocialRegisterCubit.get(context).emailController.text,
                                  password:SocialRegisterCubit.get(context).passwordController.text);
                            }
                          },),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Have an account?'),
                              TextButton(onPressed:(){
                                Navigation.navigateToAndFinish(context,const LoginScreen());
                              }, child:const Text('Login'))
                            ],
                          )
                        ]

                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
