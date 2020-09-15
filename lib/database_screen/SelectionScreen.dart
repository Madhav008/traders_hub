import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trades_club/provider/url.dart';

// ignore: must_be_immutable
class AdminPage extends StatefulWidget {
  String uid;
  AdminPage({this.uid});
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final idController = TextEditingController();
  final closeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Trader",
          )),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'OpenUrl'),
              controller: idController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'CloseUrl'),
              controller: closeController,
            ),
            RaisedButton.icon(
              onPressed: () {
                _saveForm();
              },
              icon: Icon(Icons.save),
              label: Text("data"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveForm() async {
    await Provider.of<ProvideUrl>(context, listen: false)
        .addProduct(idController.text, closeController.text);
        
    Provider.of<ProvideUrl>(context, listen: false).fetchAndSetProducts();
    Provider.of<ProvideUrl>(context, listen: false).items;
  }
}
