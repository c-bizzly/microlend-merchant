import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:microlend_merchant/core/space_box.dart';
import 'package:microlend_merchant/models/item_model.dart';
import 'package:path_provider/path_provider.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();

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
          'New Item',
          style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  text: 'Enter all the details manually. To scan SKU code ',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Color(0xFF5E6A81),
                  ),
                  children: [
                    TextSpan(
                      text: 'start here',
                      style: TextStyle(color: Color(0xFF5066F4)),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
              SpaceBox.medium(),

              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Name',
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SpaceBox.small(),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter the item name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name cannot be empty";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SpaceBox.medium(),

              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'SKU',
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SpaceBox.small(),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: skuController,
                          decoration: InputDecoration(
                            hintText: 'Enter the SKU Code or scan',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "SKU cannot be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                      SpaceBox.small(),
                      // outlined button with a prefic icon
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.qr_code_scanner_rounded),
                        label: Text(
                          'Scan',
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Color(0xFF5066F4),
                          ), // outline border color
                          foregroundColor: Color(0xFF5066F4),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SpaceBox.medium(),

              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Price',
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SpaceBox.small(),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d*'),
                      ), // Allow digits and a single decimal
                    ],
                    decoration: InputDecoration(
                      hintText: '0.00',
                      prefixText: '\$',
                      prefixStyle: TextStyle(fontSize: 24),
                    ),
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 40),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Price cannot be empty";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // a button that sticks to the bottom of the screen
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.all(16),
      //   child: ElevatedButton(
      //     onPressed: () async {
      //       if (_formKey.currentState?.validate() ?? false) {
      //         // If validation passes
      //         final appDocDir = await getApplicationDocumentsDirectory();
      //         String filePath = '${appDocDir.path}/data.json';

      //         final data = ItemModel(
      //           id: "0",
      //           name: nameController.text,
      //           sku: skuController.text,
      //           salePrice: priceController.text,
      //           insertedAt: DateTime.now().toUtc().toString(),
      //         );

      //         File file = File(filePath);
      //         List<dynamic> jsonList = [];

      //         // Check if the file exists and read its content if it does
      //         if (await file.exists()) {
      //           String content = await file.readAsString();
      //           jsonList = jsonDecode(content); // Decode the existing JSON data
      //         }

      //         // Add new data to the list
      //         // jsonList.add(data.toJson());

      //         // Show the dialog while processing
      //         showDialog(
      //           context: context,
      //           barrierDismissible:
      //               false, // Prevent dismissing while processing
      //           builder: (context) {
      //             return Dialog(
      //               insetPadding: EdgeInsets.all(16),
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(16),
      //               ),
      //               child: AspectRatio(
      //                 aspectRatio: 1,
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(0),
      //                   child: Column(
      //                     mainAxisSize: MainAxisSize.min,
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       CircularProgressIndicator(color: Color(0xFF5066F4)),
      //                       SpaceBox.large(),
      //                       Text(
      //                         'Adding\n${nameController.text}',
      //                         textAlign: TextAlign.center,
      //                         style: GoogleFonts.openSans(
      //                           color: Color(0xFF252F40),
      //                           fontSize: 20,
      //                           fontWeight: FontWeight.bold,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             );
      //           },
      //         );

      //         // Write the JSON data to the file
      //         await file.writeAsString(jsonEncode(jsonList));

      //         // Once the file writing is complete, close the dialog and navigate
      //         if (context.mounted) {
      //           Navigator.of(context).pop(); // Close the dialog
      //           GoRouter.of(
      //             context,
      //           ).push('/quantity', extra: nameController.text);
      //         }
      //       }
      //     },
      //     child: Text(
      //       'Continue',
      //       style: GoogleFonts.openSans(
      //         fontSize: 16,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //   ),
      // ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              // If validation passes

              final data = ItemModel(
                id: "0",
                name: nameController.text,
                sku: skuController.text,
                salePrice: priceController.text,
                insertedAt: DateTime.now().toUtc().toString(),
              );

              // Add new data to the list
              // jsonList.add(data.toJson());

              // Show the dialog while processing
              showDialog(
                context: context,
                barrierDismissible:
                    false, // Prevent dismissing while processing
                builder: (context) {
                  return Dialog(
                    insetPadding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: Color(0xFF5066F4)),
                            SpaceBox.large(),
                            Text(
                              'Adding\n${nameController.text}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                color: Color(0xFF252F40),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );

              List<ItemModel> list = [];
              list.add(data);

              final group = await addNewGroup(list);
              // Once the file writing is complete, close the dialog and navigate
              if (context.mounted) {
                Navigator.of(context).pop(); // Close the dialog
                GoRouter.of(context).push('/quantity', extra: group);
              }
            }
          },
          child: Text(
            'Continue',
            style: GoogleFonts.openSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> addNewGroup(List<ItemModel> newItems) async {
  // Step 1: Get the file path
  final appDocDir = await getApplicationDocumentsDirectory();
  String filePath = '${appDocDir.path}/data.json';

  File file = File(filePath);
  List<dynamic> jsonList = [];

  // Step 2: Check if the file exists and read it
  if (await file.exists()) {
    String content = await file.readAsString();
    jsonList = jsonDecode(content); // Decode JSON into a list of maps
  }

  // Step 3: Calculate the new group ID
  int newGroupId = jsonList.length + 1;

  // Step 4: Create the new group
  Map<String, dynamic> newGroup = {
    "id": newGroupId,
    "business_id": "daa57269-8291-44fc-81a5-b701bae55060",
    "business_name": "Mofe Metals",
    "total_price": newItems.last.salePrice,
    "items": newItems.map((item) => item.toJson()).toList(),
  };

  // Step 5: Add the new group to the list
  jsonList.add(newGroup);

  // Step 6: Save the updated JSON back to the file
  await file.writeAsString(jsonEncode(jsonList));

  print('New group with ID $newGroupId has been added.');

  return newGroup;
}
