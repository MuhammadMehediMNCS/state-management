import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state/easy_state/shopNameNotifier.dart';

import 'itemAddNotifier.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {

  final TextEditingController _itemControler = TextEditingController();
  final TextEditingController _shopControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Items"),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: _itemControler,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Item Name',
              ),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              child: const Text("Add Items"),
              onPressed: () async {
                if(_itemControler.text.isEmpty) {
                  return ;
                }
                await Provider.of<ItemAddNotifier>(context, listen: false)
                .addItem(_itemControler.text);
                Navigator.of(context).pop();
              }
            ),
            const SizedBox(height: 20.0),
            TextButton(
              child: const Text("Add Item Screen"),
              onPressed: () async {
                Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const AddItemScreen()
                )
              );
              }
            ),
            TextField(
              controller: _shopControler,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Shop Name',
              ),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              child: const Text("Add Shop"),
              onPressed: () async {
                if(_shopControler.text.isEmpty) {
                  return ;
                }
                await Provider.of<ShopNameNotifier>(context, listen: false)
                .updateShopeName(_shopControler.text);
                Navigator.of(context).pop();
              }
            ),
          ],
        ),
      ),
    );
  }
}