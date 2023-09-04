import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state/easy_state/shopNameNotifier.dart';
import 'add_Item.dart';
import 'itemAddNotifier.dart';

class Pro_Manage extends StatelessWidget {
  const Pro_Manage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ItemAddNotifier>(
          create: (BuildContext context) {
            return ItemAddNotifier();
          }
        ),
        ChangeNotifierProvider<ShopNameNotifier>(
          create: (BuildContext context) {
            return ShopNameNotifier();
          }
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: homeProvider(),
      ),
    );
  }
}

class homeProvider extends StatefulWidget {
  const homeProvider({Key? key}) : super(key: key);

  @override
  State<homeProvider> createState() => _homeProviderState();
}

class _homeProviderState extends State<homeProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const AddItemScreen()
                )
              );
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<ItemAddNotifier>(
                builder: (context, itemAddNotifier, _) {
                  return ListView.builder(
                    itemCount: itemAddNotifier.itemList.length, // itemCount only for RangeError (index):
                    itemBuilder: (context, index) {
                      final myItem = itemAddNotifier.itemList [index];
                      
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          myItem.itemName,
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.black
                          ),
                        ),
                      );
                    }
                  );
                }
              )
            ),
            Consumer<ShopNameNotifier>(
              builder: (context, shopNameNotifier, _) {
                return Text('Shop Name: ${shopNameNotifier.shopName}');
              }
            )
          ],
        ),
      ),
    );
  }
}