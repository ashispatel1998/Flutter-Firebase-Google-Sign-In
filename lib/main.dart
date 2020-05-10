import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   bool islogin=false;
   GoogleSignIn _googleSignIn=GoogleSignIn(scopes: ['email']);

  _login() async{
    try{
        await _googleSignIn.signIn();
        setState(() {
          islogin=true;
        });
    }catch(err){
      print(err);
    }

  }
  _logout(){
    _googleSignIn.signOut();
    setState(() {
      islogin=false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
         body: islogin==false? Center(
           child: RaisedButton(
             child: Text('Google SignIn',
             style: TextStyle(
               fontSize: 20.0,
               color: Colors.white,
             ),
             ),
             color: Colors.green[400],
             padding: EdgeInsets.all(20.0),
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.all(Radius.circular(25.0))),
             onPressed: () {
               _login();
             },
           ),
         ):
         SafeArea(
           child: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 CircleAvatar(
                   backgroundImage: NetworkImage(_googleSignIn.currentUser.photoUrl),
                   radius: 50.0,
                 ),
                 Padding(
                   padding: const EdgeInsets.all(4.0),
                   child: Text(
                     _googleSignIn.currentUser.displayName,
                     style: TextStyle(
                       fontSize: 20.0,
                       fontWeight: FontWeight.bold,
                       color: Colors.black,
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(4.0),
                   child: Text(
                     _googleSignIn.currentUser.email,
                     style: TextStyle(
                       fontSize: 20.0,
                       fontWeight: FontWeight.bold,
                       color: Colors.black,
                     ),
                   ),
                 ),
                 RaisedButton(
                   child: Text('Sign Out',
                     style: TextStyle(
                       fontSize: 20.0,
                       color: Colors.white,
                     ),
                   ),
                   color: Colors.red[400],
                   padding: EdgeInsets.all(10.0),
                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.all(Radius.circular(15.0))),
                   onPressed: () {
                     _logout();
                   },
                 ),

               ],
             ),
           ),
         ),
    );
  }
}
