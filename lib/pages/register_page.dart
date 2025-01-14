import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:podvibes/auth/auth.dart';
import 'package:podvibes/objects/buttons.dart';
import 'package:podvibes/objects/fields.dart';
import 'package:podvibes/pages/home.dart';


class RegisterPage extends StatefulWidget {
  final VoidCallback togglePages;

  const RegisterPage({
    super.key,
    required this.togglePages
    });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController=TextEditingController();
    final TextEditingController emailController=TextEditingController();
    final TextEditingController passwordController=TextEditingController();
    final TextEditingController confirmPasswordController=TextEditingController();

    void registerUser(){
      //Show loading circle
      showDialog(
        context:context,
        builder:(context)=> const Center(
          child:CircularProgressIndicator(),
        )
      );
      //Check for passwords
      if (passwordController.text!=confirmPasswordController.text){
        //Inform user
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Passwords do not match')));
      }else{
        //try user creation
        try{
          Auth().createUser(emailController.text, passwordController.text,usernameController.text);
          Navigator.pop(context);
          //Informing the user of the creation
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Account succesfully created')));
          //Clearing the fields
          setState((){
            usernameController.clear();
            emailController.clear();
            passwordController.clear();
            confirmPasswordController.clear();
          });
        }on FirebaseAuthException catch(e){
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Unable to register due to error $e')));
        }
      }
    }

    void dispose(){
      setState((){
        usernameController.dispose();
        emailController.dispose();
        passwordController.dispose();
        confirmPasswordController.dispose();
      });
    }

    return Scaffold(
      body:SafeArea(
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
                          child: Image(image:AssetImage('assets/logo/podvibes_transparent.png'))
                          ),
                        //Main text
                        Text(
                          'Register',
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
                        const SizedBox(height:20),
                        //Email
                        Fields(
                          color: Theme.of(context).colorScheme.inversePrimary, 
                          hintText: 'E-mail address', 
                          obscureText: false, 
                          controller: emailController, 
                          icon: const Icon(Icons.email)
                        ),
                        const SizedBox(height:20),
                        //Password
                        Fields(
                          color: Theme.of(context).colorScheme.inversePrimary, 
                          hintText: 'password', 
                          obscureText: true, 
                          controller: passwordController, 
                          icon: const Icon(Icons.key)
                        ),
                        const SizedBox(height:20),
                        //Confirm password
                        Fields(
                          color: Theme.of(context).colorScheme.inversePrimary, 
                          hintText: 'Confirm password', 
                          obscureText: true, 
                          controller: confirmPasswordController, 
                          icon: const Icon(Icons.key)
                        ),                  
                        const SizedBox(height:20),
                        //Buttons
                        MyButtons(
                          color: Colors.amber, 
                          text: 'Register', 
                          textColor: Theme.of(context).colorScheme.inversePrimary, 
                          onTap: (){
                            registerUser();
                          }
                        ),
                        const SizedBox(height:10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:[
                              GestureDetector(
                                onTap:(){
                                  widget.togglePages();
                                },
                                child: const Text(
                                  'Login',
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
