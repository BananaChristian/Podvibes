import 'package:flutter/material.dart';
import 'package:podvibes/objects/buttons.dart';
import 'package:podvibes/objects/fields.dart';
import 'package:podvibes/pages/home.dart';


class RegisterPage extends StatelessWidget {
  final VoidCallback togglePages;

  const RegisterPage({
    super.key,
    required this.togglePages
    });

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController=TextEditingController();
    final TextEditingController emailController=TextEditingController();
    final TextEditingController passwordController=TextEditingController();
    final TextEditingController confirmPasswordController=TextEditingController();

    return Scaffold(
      body:SingleChildScrollView(
        child: Container(
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
                  'Welcome Stranger!',
                  style:TextStyle(
                    color:Color.fromARGB(255, 255, 255, 255),
                    fontSize:30,
                    fontWeight: FontWeight.bold
                    )
                  ),
                const SizedBox(height:10),
                //FIELDS
                //Username field
                Fields(
                  color: const Color.fromARGB(255, 255, 255, 255), 
                  hintText: 'Username',
                  obscureText: false, 
                  controller: usernameController,
                  icon:const Icon(
                    Icons.person,
                    color:Color.fromARGB(255, 255, 255, 255)
                    )
                ),
                const SizedBox(height:10),
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
                const SizedBox(height:10),
                //Confirm password field
                Fields(
                  color: const Color.fromARGB(255, 255, 255, 255), 
                  hintText: 'Confirm Password',
                  obscureText: true, 
                  controller: confirmPasswordController,
                  icon:const Icon(
                    Icons.key_sharp,
                    color:Color.fromARGB(255, 255, 255, 255)
                    )
                ),
                const SizedBox(height:20),
                //BUTTONS
                //Login button
                MyButtons(
                  color: Colors.blue,
                  text: 'Register',
                  textColor:Colors.white,
                  onTap:() async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder:(context)=>Home())
                    );
                  }   
                ),         
                const SizedBox(height:20),
                //Log into existing account button
                MyButtons(
                  color:Colors.red,
                  text:'Login',
                  textColor:Colors.white,
                  onTap:(){
                    togglePages();
                  }
                )
              ],
            ),
        ),
      )
    );
  }
}
