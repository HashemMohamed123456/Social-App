import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/View/screeens/Register/register_screen.dart';
import 'package:social_app/View/widgets/Navigation_component/navigations.dart';
import 'package:social_app/View/widgets/elevated_button_custom/elevated_button_custom.dart';
import 'package:social_app/View/widgets/textformfield_widget/textformfield_custom.dart';
import 'package:social_app/ViewModel/constructions/constructions.dart';
import 'package:social_app/ViewModel/data/local/keys.dart';
import 'package:social_app/ViewModel/data/local/local_data.dart';
import 'package:social_app/layout/social_layout.dart';
import '../../../ViewModel/bloc/social_login_cubit/social_login_cubit.dart';
import '../../../ViewModel/bloc/social_login_cubit/social_login_states.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is SocialLoginErrorState){
            showToast(message: state.error??'', state:ToastStates.error);
          }
          if(state is SocialLoginSuccessState){
            LocalData.set(key:SharedKeys.uIdKey, value:state.uId);
            Navigation.navigateToAndFinish(context,const SocialLayout());
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar:AppBar(
              title: Text('Social'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: SocialLoginCubit.get(context).formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Login To Our Social Application',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900),),
                          const SizedBox(height: 20,),
                          TextFormFieldCustom(
                            controller: SocialLoginCubit.get(context).emailController,
                            label: 'Email',
                            prefix: Icons.email,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please put your Email!';
                              }
                            },
                          ),
                          const SizedBox(height:20,),
                          TextFormFieldCustom(
                            controller:SocialLoginCubit.get(context).passwordController,
                            label: 'Password',
                            prefix: Icons.lock,
                            suffix:SocialLoginCubit.get(context).passwordSuffix,
                            obscureText:SocialLoginCubit.get(context).isPassword,
                            onSuffixPressed: (){
                              SocialLoginCubit.get(context).changePasswordSuffixIcon();
                            },
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please put your Password!';
                              }
                            },
                            onFieldSubmitted: (value){
                              if(SocialLoginCubit.get(context).formKey.currentState!.validate()){
                                SocialLoginCubit.get(context).userLogin(
                                    email:SocialLoginCubit.get(context).emailController.text,
                                    password:SocialLoginCubit.get(context).passwordController.text);

                              }
                            },
                          ),
                          const SizedBox(height: 20,),
                          (state is SocialLoginLoadingState)?
                          const Center(child: CircularProgressIndicator(color: Colors.lightBlue,),):
                          ElevatedButtonWidget(buttonLabel: 'Login',onPressed: (){
                            if(SocialLoginCubit.get(context).formKey.currentState!.validate()){
                              SocialLoginCubit.get(context).userLogin(
                                  email:SocialLoginCubit.get(context).emailController.text,
                                  password:SocialLoginCubit.get(context).passwordController.text);
                            }
                          },),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(onPressed:(){
                                Navigation.navigateToAndFinish(context, const RegisterScreen());
                              }, child:const Text('Register'))
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
