import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  // This is required...
  WidgetsFlutterBinding.ensureInitialized();

  // ... before we can do this...
  await Firebase.initializeApp();

  // And some other things to remember:
  //
  // 1. GoogleService-info.plist needs to be added to the Runner target
  //     in xCode.  Use 'Open in xCode' on the iOS folder in the flutter
  //     project, then right-click the Runner target and "Add files to Runner",
  //     adding GoogleService-info.plist and checking "Copy items if needed"
  //
  // 2. Slightly more obvious: to 'await' the initializeApp() call, the usually
  //     'sync' main() method needs to be made 'async'.
  //
  // 3. iOS platform version in Podfile needs to be increased from 9.0 (I went
  //     straight to 11.0, which worked, though may not be the minimum
  //     supported)

  // Finally, not something to change, but to explain what's going on above...
  //
  // runApp() internally calls 'ensureInitialized()' which is why we don't
  //  usually need to do it ourselves before runApp() itself is called.

  runApp(const ChatApp());
}
