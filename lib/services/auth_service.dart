import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //login with google
  Future<UserCredential> signInWithGoogle() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication = await googleUser?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> register(email, password){
    return FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  }
  Future<UserCredential> login(email, password){
    return FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }
  Future<void> forgotPassword(email){
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
  Stream<User?> getAuthUser() {
    return FirebaseAuth.instance.authStateChanges();
  }

  //delete user account
  Future<void> deleteUser() {
    return FirebaseAuth.instance.currentUser!.delete();
  }
  logout(){
    return FirebaseAuth.instance.signOut();
  }
  String getCurrentUserUID() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

}