import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:microlend_merchant/core/space_box.dart';
import 'package:microlend_merchant/models/item_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../util/store.dart';

Future<List<Map<String, dynamic>>> _fetchGroupedItems() async {
  final data = await getData('txns');

  if (data != null && data.isNotEmpty) {
    List<dynamic> jsonList = jsonDecode(data); // Decode JSON data

    // Explicitly cast jsonList to List<Map<String, dynamic>>
    return jsonList.cast<Map<String, dynamic>>();
  }

  return []; // Return an empty list if the file doesn't exist
}

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  @override
  Widget build(BuildContext context) {
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
          'Payment QR Code',
          style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: _fetchGroupedItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final txnCode = snapshot.data!.last;

            txnCode.removeWhere((k, v) => k == 'items');
            debugPrint(txnCode.toString());

            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Color(0xFFBDC9EE)),
                        color: Color(0xFFF7F9FD),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/temp/logo-Mofe-Metals.png'),
                              SpaceBox.small(),
                              Text(
                                'Mofe Metals',
                                style: GoogleFonts.openSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF252F40),
                                ),
                              ),
                            ],
                          ),
                          SpaceBox.medium(),
                          Text(
                            'Transaction ID:',
                            style: GoogleFonts.openSans(
                              color: Color(0xFF252F40),
                            ),
                          ),
                          Text(
                            txnCode['id'].toString(),
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF252F40),
                            ),
                          ),
                        ],
                      ),
                    ),

                    QrImageView(data: txnCode.toString()),

                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Color(0xFFBDC9EE)),
                        color: Color(0xFFF7F9FD),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            child: Text('Show details'),
                          ),
                          SpaceBox.small(),
                          Divider(color: Color(0xFFDADFE8)),
                          SpaceBox.small(),
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
                                '\$${txnCode['total_price']}',
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
                                '\$${txnCode['total_price']}',
                                style: GoogleFonts.openSans(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SpaceBox.medium(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                        GoRouter.of(context).go('/', extra: true);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 64),
                        backgroundColor: Colors.green.shade800,
                      ),
                      child: Text('Simulate Txn Successful'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
