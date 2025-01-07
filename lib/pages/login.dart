import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:podvibes/auth/auth.dart';
import 'package:podvibes/objects/buttons.dart';
import 'package:podvibes/objects/fields.dart';
import 'package:podvibes/pages/home.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback togglePages;

  const LoginPage({super.key, required this.togglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void login(){
      //Circular loader
      showDialog(
        context:context,
        builder:(context)=>const Center(
          child:CircularProgressIndicator(),
        )
      );
      //Logging in the user
      if(emailController.text.isEmpty&&passwordController.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password or email is empty')));
      }else{
        try{
          Auth().signIn(emailController.text, passwordController.text);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login succesful')));
        }on FirebaseAuthException catch(e){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unable to login an error $e ocuured')));
        }
      }
    }

    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child:Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child:Column(
                children: [
                //Login form
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding:const EdgeInsets.all(20),
                    color:Theme.of(context).colorScheme.primary,
                    child:Column(
                      children: [
                        //Logo section
                        const SizedBox(
                          width:200,
                          child: Image(image:AssetImage('assets/logo/podvibes_bgless.png'))
                          ),
                        //Main text
                        Text(
                          'Login',
                          style:TextStyle(
                            color:Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          )
                          ),
                        const SizedBox(height:20),
                        //Username
                        Fields(
                          color: Theme.of(context).colorScheme.inversePrimary, 
                          hintText: 'Username', 
                          obscureText: false, 
                          controller: usernameController, 
                          icon: const Icon(Icons.person)
                          ),
                        const SizedBox(height:10),
                        //email
                        Fields(
                          color: Theme.of(context).colorScheme.inversePrimary, 
                          hintText: 'E-mail address', 
                          obscureText: false, 
                          controller: emailController, 
                          icon: const Icon(Icons.email)
                          ),
                        const SizedBox(height:10),
                        //Password
                        Fields(
                          color: Theme.of(context).colorScheme.inversePrimary, 
                          hintText: 'password', 
                          obscureText: true, 
                          controller: passwordController, 
                          icon: const Icon(Icons.key)
                        ),
                        const SizedBox(height:10),
                        //Forgot Password
                        Text(
                          'Forgot password?',
                          style:TextStyle(
                            color:Theme.of(context).colorScheme.inversePrimary
                          )
                        ),
                        const SizedBox(height:10),
                        //Buttons
                        MyButtons(
                          color: Colors.amber, 
                          text: 'Login', 
                          textColor: Theme.of(context).colorScheme.inversePrimary, 
                          onTap: (){
                            login();
                          }
                        ),
                        const SizedBox(height:10),
                        //Questions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:[
                              GestureDetector(
                                onTap:(){
                                  widget.togglePages();
                                },
                                child: const Text(
                                  'Register',
                                  style:TextStyle(color:Colors.amber)
                                  ),
                              ),
                              GestureDetector(
                                onTap:(){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context)=>const Home())
                                  );
                                },
                                child: const Text('Continue as guest')
                                )
                            ],
                          ),
                      ],
                      )
                  ),
                )
                ],
              ),
            ),
          ),
        ),
        );
  }
}
