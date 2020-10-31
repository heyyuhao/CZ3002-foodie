import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_core/firebase_core.dart';
import 'package:foodie/model/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:foodie/global.dart' as global;


final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    // Add the following lines after getting the user
    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    String name = user.displayName;
    String email = user.email;
    String imageUrl = user.photoURL;

    global.appUser = new User(email, name, UserType.Client.index);
    global.appUser.imageUrl = imageUrl;

    List<DocumentSnapshot> clientDocuments = (await getClientByEmail(email)).docs;
    if (clientDocuments.length == 0) {
      // no such client, add this client into database
      print('User has not registered');
      User newUser = new User(email, name, UserType.Client.index);
      await addClient(newUser);
      clientDocuments = (await getClientByEmail(email)).docs;
    }
    DocumentSnapshot clientDocument = clientDocuments[0];
    global.appUser.userID = clientDocument.reference.id;

    print('user id: ' + global.appUser.userID);

    return '$user';
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}


