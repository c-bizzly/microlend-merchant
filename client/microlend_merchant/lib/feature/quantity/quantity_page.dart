import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:microlend_merchant/core/space_box.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/item_model.dart';
import '../../util/store.dart';

Future<List<ItemModel>> getItems() async {
  final data = await getData('txns');

  List<dynamic> jsonList = [];
  if (data != null && data.isNotEmpty) {
    jsonList = jsonDecode(data); // Decode the JSON data
  }

  final group =
      jsonList.isNotEmpty
          ? jsonList.last
          : null; // Get the last list if it exists, or null if the list is empty

  // Return the items if the group is found, or an empty list otherwise
  if (group != null && group['items'] is List<dynamic>) {
    return (group['items'] as List<dynamic>)
        .map((item) => ItemModel.fromJson(item))
        .toList();
  }

  return []; // Return an empty list if no group or items are found
}

class QuantityPage extends StatefulWidget {
  const QuantityPage({super.key});

  @override
  State<QuantityPage> createState() => _QuantityPageState();
}

class _QuantityPageState extends State<QuantityPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController skuController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // make back arrow ios style

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        titleSpacing: 0,
        title: Text(
          'Quantity',
          style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: getItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Color(0xFFEAEEF5)),
                color: Color(0xFFF7F9FD),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Qty',
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          'Item',
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Price',
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Color(0xFFDADFE8)),
                  SpaceBox.small(),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, i) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 36,
                            height: 36,
                            child: TextField(
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontSize: 16),
                              decoration: InputDecoration(
                                // contentPadding: EdgeInsets.all(8),
                                // border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SpaceBox.small(),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data![i].name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  snapshot.data![i].sku,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF5E6A81),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SpaceBox.small(),
                          //TODO: space between here, currency digits overflow
                          Expanded(
                            child: Text(
                              '\$${snapshot.data![i].salePrice}',
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => SpaceBox.small(),
                  ),
                  Spacer(),
                  Divider(color: Color(0xFFDADFE8)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${snapshot.data!.first.salePrice}',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tax',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '\$0.00',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SpaceBox.medium(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${snapshot.data!.first.salePrice}',
                        style: GoogleFonts.openSans(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
      // a button that sticks to the bottom of the screen
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlinedButton(onPressed: () {}, child: Text('Add another item')),
            SpaceBox.medium(),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).push('/payment'),
              child: Text('Sell'),
            ),
          ],
        ),
      ),
    );
  }
}
