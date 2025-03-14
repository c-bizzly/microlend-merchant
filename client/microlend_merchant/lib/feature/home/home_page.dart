import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:microlend_merchant/core/space_box.dart';
import 'package:microlend_merchant/feature/qr/qr_page.dart';
import 'package:microlend_merchant/models/item_model.dart';
import 'package:path_provider/path_provider.dart';

import '../../util/store.dart';
import '../quantity/quantity_page.dart';

final _scaffoldKey = GlobalKey<ScaffoldState>();
// Future<List<Map<String, dynamic>>> _fetchGroupedItems() async {
//   final appDocDir = await getApplicationDocumentsDirectory();
//   String filePath = '${appDocDir.path}/data.json';
//   File file = File(filePath);

//   if (await file.exists()) {
//     String content = await file.readAsString();
//     debugPrint(jsonDecode(content).toString());
//     return jsonDecode(content); // Decode JSON data into a list of maps
//   }

//   return []; // Return an empty list if the file doesn't exist
// }

Future<List<Map<String, dynamic>>> _fetchGroupedItems() async {
  final data = await getData('txns');

  if (data != null && data.isNotEmpty) {
    List<dynamic> jsonList = jsonDecode(data); // Decode JSON data

    // Explicitly cast jsonList to List<Map<String, dynamic>>
    return jsonList.cast<Map<String, dynamic>>();
  }

  return []; // Return an empty list if the file doesn't exist
}

class HomePage extends StatefulWidget {
  final bool? rebuild;
  const HomePage({super.key, this.rebuild = false});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.rebuild == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset('assets/brand/logo-lg-merchant.png', height: 32),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning',
              style: GoogleFonts.openSans(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Mofe Metals',
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SpaceBox.large(),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Search for items or sales',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SpaceBox.large(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Recent Transactions',
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                FutureBuilder(
                  future: _fetchGroupedItems(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 40, bottom: 20),
                            child: Image.asset(
                              'assets/icon/icon-diamond.png',
                              height: 94,
                            ),
                          ),
                          Text(
                            'No Sales Made Yet',
                            style: GoogleFonts.openSans(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5E6A81),
                            ),
                          ),
                          Text(
                            'Find transactions made and their\npayment statuses here',
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: Color(0xFF5E6A81),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }

                    final groupedData = snapshot.data!;

                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: groupedData.length,
                            itemBuilder: (_, i) {
                              final group = groupedData[i];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SpaceBox.medium(),

                                  Text(
                                    "TXN ID: ${group['id']}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      height: 1,
                                    ),
                                  ),
                                  // List of items within this group
                                  ...group['items'].map<Widget>((item) {
                                    final itemModel = ItemModel.fromJson(item);
                                    return Column(
                                      children: [
                                        SpaceBox.medium(),

                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                color: Color(0xFFDAFCE2),
                                              ),
                                            ),
                                            SpaceBox.small(),
                                            Expanded(
                                              flex: 4,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    itemModel.name,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.openSans(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1,
                                                    ),
                                                  ),
                                                  Text(
                                                    itemModel.insertedAt,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.openSans(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                '\$${itemModel.salePrice}',
                                                style: GoogleFonts.openSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ],
                              );
                            },
                          ),
                          SpaceBox.medium(),
                          Text(
                            'Start of transactions',
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF5E6A81),
                            ),
                          ),
                          SpaceBox.medium(),
                          Divider(color: Color(0xFFE5EBF6)),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        // shape: CircularNotchedRectangle(),
        // notchMargin: 8,
        height: 64,
        color: const Color(0x00fefefe),
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // IconButton(onPressed: () {}, icon: Icon(Icons.menu, size: 40)),
            IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              icon: Image.asset('assets/icon/icon-menu.png'),
            ),
            ElevatedButtonTheme(
              data: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5066F4),
                  foregroundColor: Colors.white,
                  minimumSize: Size(140, 52),
                  textStyle: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  // padding: EdgeInsets.all(16),
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // pull up bottom sheet above the bottom app bar
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12),
                      ),
                    ),

                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 24,
                          left: 16,
                          right: 16,
                          bottom: 86,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Column(
                              children: [
                                // close icon with circular border
                                Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Icon(Icons.close, size: 24),
                                    ),
                                  ),
                                ),

                                // IconButton(onPressed: (){}, icon: Icon(Icons.clo)),
                                Text(
                                  'Start Sale',
                                  style: GoogleFonts.openSans(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF252F40),
                                  ),
                                ),
                                SpaceBox.small(),
                                Text(
                                  'Begin a transaction by selecting\nto add items or scan SKU',
                                  style: GoogleFonts.openSans(
                                    fontSize: 16,
                                    color: Color(0xFF5E6A81),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SpaceBox.medium(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // make a couple of square outlined buttons with icon and text on top of each other, each sized 114 in height auto width
                                    Flexible(
                                      child: AspectRatio(
                                        aspectRatio: 1.2,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            // go router goooooo to page add item
                                            GoRouter.of(context).pop();
                                            GoRouter.of(
                                              context,
                                            ).push('/add-item');
                                          },
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/icon/icon-diamond.png',
                                                height: 48,
                                              ),
                                              SpaceBox.small(),

                                              Text(
                                                'Add Items',
                                                style: GoogleFonts.openSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF252F40),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Flexible(
                                      child: AspectRatio(
                                        aspectRatio: 1.2,
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/icon/icon-diamond.png',
                                                height: 48,
                                              ),
                                              SpaceBox.small(),
                                              Text(
                                                'Scan SKU',
                                                style: GoogleFonts.openSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF252F40),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text('Sell'),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.cached_rounded, size: 40),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        // sample drawer
        backgroundColor: Color(0xFFFEFEFE),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                title: Image.asset(
                  'assets/brand/logo-lg-merchant.png',
                  height: 32,
                ),
                actions: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    ListTile(
                      // dense: true,
                      contentPadding: EdgeInsets.zero,
                      // minTileHeight: 64,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        // side: BorderSide(color: Color(0xFF252F40)),
                      ),

                      leading: CircleAvatar(
                        radius: 28,
                        foregroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2013/09/25/12/25/monk-186094_1280.jpg',
                        ),
                      ),
                      title: Text(
                        'Nawasaki Feeso',
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF252F40),
                        ),
                      ),
                      subtitle: Text(
                        '+252634409796',
                        style: GoogleFonts.openSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5E6A81),
                        ),
                      ),
                      onTap: () {},
                    ),
                    SpaceBox(h: 24),
                    ListTile(
                      // dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),

                      // minTileHeight: 64,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        // side: BorderSide(color: Color(0xFF252F40)),
                        side: BorderSide(color: Color(0xFF252F40)),
                      ),
                      leading: Image.asset('assets/temp/logo-Mofe-Metals.png'),
                      title: Text(
                        'Mofe Metals',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF252F40),
                        ),
                      ),
                      subtitle: Text(
                        'Switch Business Account',
                        style: GoogleFonts.openSans(
                          fontSize: 12,
                          // fontWeight: FontWeight.bold,
                          color: Color(0xFF5E6A81),
                        ),
                      ),
                      onTap: () {},
                    ),
                    SpaceBox.large(),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      leading: Image.asset(
                        'assets/icon/icon-person.png',
                        height: 32,
                      ),
                      title: Text(
                        'Personal Information',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF252F40),
                          letterSpacing: 0,
                        ),
                      ),
                      onTap: () {},
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    ),
                    Divider(color: Color(0xFFE5EBF6), height: 0),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      leading: Image.asset(
                        'assets/icon/icon-notification.png',
                        height: 32,
                      ),
                      title: Text(
                        'Notifications and Alerts',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF252F40),
                          letterSpacing: 0,
                        ),
                      ),
                      onTap: () {},
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    ),
                    Divider(color: Color(0xFFE5EBF6), height: 0),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      leading: Image.asset(
                        'assets/icon/icon-settings.png',
                        height: 32,
                      ),
                      title: Text(
                        'Security settings',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF252F40),
                          letterSpacing: 0,
                        ),
                      ),
                      onTap: () {},
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    ),

                    Divider(color: Color(0xFFE5EBF6)),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      leading: Image.asset(
                        'assets/icon/icon-globe.png',
                        height: 32,
                      ),
                      title: Text(
                        'Preferred language',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF252F40),
                          letterSpacing: 0,
                        ),
                      ),
                      subtitle: Text(
                        'Preferred language',
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: Color(0xFF5E6A81),
                          letterSpacing: 0,
                        ),
                      ),
                      onTap: () {},
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    ),
                    Divider(color: Color(0xFFE5EBF6)),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      leading: Image.asset(
                        'assets/icon/icon-support.png',
                        height: 32,
                      ),
                      title: Text(
                        'Support',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF252F40),
                          letterSpacing: 0,
                        ),
                      ),
                      onTap: () {},
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    ),
                    Divider(color: Color(0xFFE5EBF6), height: 0),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      leading: Image.asset(
                        'assets/icon/icon-tandc.png',
                        height: 32,
                      ),
                      title: Text(
                        'Terms & Conditions',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF252F40),
                          letterSpacing: 0,
                        ),
                      ),
                      onTap: () {},
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    ),

                    Divider(color: Color(0xFFE5EBF6)),

                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      leading: Image.asset(
                        'assets/icon/icon-log-out.png',
                        height: 32,
                      ),
                      title: Text(
                        'Log out',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFC8102E),
                          letterSpacing: 0,
                        ),
                      ),
                      onTap: () {},
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 12.0),
      //   child: IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
      //   // child: ElevatedButton(onPressed: () {}, child: Text('New Request')),
      // ),
    );
  }
}
