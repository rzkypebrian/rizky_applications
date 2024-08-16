// Copyright (c) 2019 Souvik Biswas

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignUtil {
  final GoogleSignIn googleSignIn = GoogleSignIn();
//8F:64:05:4E:A0:2D:70:C5:C0:13:CF:2D:14:05:11:B1:2F:32:3F:EE
//8F:64:05:4E:A0:2D:70:C5:C0:13:CF:2D:14:05:11:B1:2F:32:3F:EE
  String id;
  String name;
  String email;
  String imageUrl;
  String phoneNumber;

  Future<String> signIn() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      // Optional clientId
      // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    return _googleSignIn.signIn().then((user) {
      // Checking if email and name is null
      assert(user.id != null);
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoUrl != null);
      // assert(user.phoneNumber != null);

      id = user.id;
      name = user.displayName;
      email = user.email;
      imageUrl = user.photoUrl;
      // phoneNumber = user.phoneNumber;

      // Only taking the first part of the name, i.e., First Name
      if (name.contains(" ")) {
        name = name.substring(0, name.indexOf(" "));
      }

      return 'signInWithGoogle succeeded: $user';
    });
  }

  Future<GoogleSignInAccount> signOut() async {
    return googleSignIn.signOut();
  }

  Future<GoogleSignInAccount> disconnect() {
    return googleSignIn.disconnect();
  }
}
