import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodie_vendor/model/restaurant.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:foodie_vendor/model/vendor.dart';

// Add these three variables to store the info
// retrieved from the FirebaseUser
Vendor vendor;
Restaurant restaurant;
String userID;
String name;
String email;
String imageUrl;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    // Add the following lines after getting the user
    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    userID = user.uid;
    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;

    print('user ID: ' + userID);
    print('name: ' + name);
    print('email: ' + email );

    // fetch the vendor
    List<DocumentSnapshot> vendorDocuments = (await getVendorByEmail(email)).docs;
    if (vendorDocuments.length == 0) {
      // no such vendor
      print('no such vendor');
      return null;
    }
    DocumentSnapshot vendorDocument = vendorDocuments[0];
    DocumentReference vendorDocumentReference = vendorDocument.reference;
    vendor = getVendorFromDocument(vendorDocument);


    // fetch the restaurant
    List<DocumentSnapshot> restaurantDocuments = (await getRestaurantByVendor(vendorDocumentReference)).docs;
    if (restaurantDocuments.length == 0) {
      // no restaurant for this vendor, don't login
      print('no restaurant for vendor');
      return null;
    }
    DocumentSnapshot restaurantDocument = restaurantDocuments[0];
    restaurant = await getRestaurantFromDocument(restaurantDocument);

    return '$user';
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}


