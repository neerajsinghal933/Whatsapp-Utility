import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Whatsapp Utility",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp Utility'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                hintText: "Enter number",
                labelText: "Phone Number",
              ),
            ),
            ElevatedButton(
              onPressed: () => {
                sendMessage(context),
              },
              child: Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }

  final snackbar = SnackBar(
    content: Text("Enter valid number", textAlign: TextAlign.center ),
  );

  void sendMessage(context) {
    var txt = _controller.text;
    if (txt.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    else{
      _launchURL(txt);
    }
  }

  var _url = "https://api.whatsapp.com/send?phone=91";

  void _launchURL(txt) async =>
      await canLaunch(_url + txt) ? await launch(_url + txt) : throw 'Could not launch $_url';


}
