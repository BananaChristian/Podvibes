import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  User? get currentUser=>_firebaseAuth.currentUser;

  Stream<User?> get authStateChanges=>_firebaseAuth.authStateChanges();

  //User sign in
  Future<void> signIn(String email,String password) async{
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password
    );
  }

  //Create a user and store the details in firestore
  Future<void> createUser(String email, String password,String username) async{
    try{
      //Create the user with email and password
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password
      );
      //Save user details
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username':username,
        'email':email,
        'subscriptions':[],
        'createdAt':FieldValue.serverTimestamp(),
      });
    }catch (e){
      print('Error creating account $e');
      rethrow;
    }
  }

  Future<void> addSubscription(String userId,String subscriptionId) async{
    try{
      await _firestore.collection('users').doc(userId).update({
        'subscriptions':FieldValue.arrayUnion([subscriptionId])
      });
    }catch(e){
      print('Error adding subscription');
    }
  }

  Future<void> removeSubscription(String userId,String subscriptionId) async{
    try{
      await _firestore.collection('users').doc(userId).update({
        'subscriptions':FieldValue.arrayRemove([subscriptionId])
      });
    }catch (e){
      print('Error removing subscriptions');
    }
  }

  Future <List<dynamic>> getSubscriptions(String userId) async{
    try{
      DocumentSnapshot userDoc=await _firestore.collection('users').doc(userId).get();
      return (userDoc.data() as Map<String,dynamic>)['subscriptions']??[];
    }catch (e){
      print('Error fecthing subscriptions: $e');
      return [];
    }
  }

  Future<void> signOut() async{
    _firebaseAuth.signOut();
  }

  Future<void> deleteAccount() async{
    final user=_firebaseAuth.currentUser;
    if(user!=null){
      try{
        await user.delete();
      }catch(e){
        print('Error deleting account $e');
      }
    }
  }
}