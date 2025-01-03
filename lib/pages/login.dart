import 'package:flutter/material.dart';
import 'package:podvibes/objects/buttons.dart';
import 'package:podvibes/objects/fields.dart';
import 'package:podvibes/pages/home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController=TextEditingController();
    final TextEditingController passwordController=TextEditingController();
    return Scaffold(
      body:Container(
        padding:const EdgeInsets.all(20),
        decoration:BoxDecoration(
          image:DecorationImage(
            image: const AssetImage('assets/background.png'),
            fit:BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8),
              BlendMode.dstATop
            )
            )
        ),
        child:Column(
          children:[
            //Logo
            const SizedBox(
              height:200,
              child: Image(
                image: AssetImage('assets/logo/podvibes_bgless.png')
                ),
            ),
            //Text 
            const Text(
              'Episodic series of digital audio',
              style:TextStyle(
                color:Color.fromARGB(255, 255, 255, 255),
                fontSize:30,
                fontWeight: FontWeight.bold
                )
              ),
            const SizedBox(height:10),
            //FIELDS
            //Email address field
            Fields(
              color: const Color.fromARGB(255, 255, 255, 255), 
              hintText: 'E-mail address',
              obscureText: false, 
              controller: emailController,
              icon:const Icon(
                Icons.email,
                color:Color.fromARGB(255, 255, 255, 255)
                )
            ),
            const SizedBox(height:10),
            //Password field
             Fields(
              color: const Color.fromARGB(255, 255, 255, 255), 
              hintText: 'Password',
              obscureText: true, 
              controller: passwordController,
              icon:const Icon(
                Icons.key,
                color:Color.fromARGB(255, 255, 255, 255)
                )
            ),
            const SizedBox(height:20),
            //BUTTONS
            //Login button
            MyButtons(
              color: Colors.blue,
              text: 'Login',
              textColor:Colors.white,
              onTap:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:(context)=>const Home()
                  ),
                );
              }   
            ),
            const SizedBox(height:10),
            //Forgot password text
            const Text(
              'Forgot Password ?',
              style:TextStyle(color:Color.fromARGB(255, 255, 255, 255))
              ),
            const SizedBox(height:20),
            //Register new account button
            MyButtons(
              color:Colors.red,
              text:'Register new account',
              textColor:Colors.white,
              onTap:(){}
            )
          ],
        ),
      )
    );
  }
}