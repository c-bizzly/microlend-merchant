import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:microlend_merchant/core/space_box.dart';
import 'package:phone_form_field/phone_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Image.asset('assets/brand/logo-lg-merchant.png', height: 32),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
        ],
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/brand/bg-login.png"), // Your image path
            fit: BoxFit.cover, // Adjust the image's fit
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Log in',
              style: GoogleFonts.openSans(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            PhoneFormField(
              initialValue: PhoneNumber.parse('+33'), // or use the controller
              validator: PhoneValidator.compose([
                // PhoneValidator.required(),
                // PhoneValidator.validMobile(),
              ]),
              countrySelectorNavigator: const CountrySelectorNavigator.page(),
              onChanged: (phoneNumber) => print('changed into $phoneNumber'),
              enabled: true,
              isCountrySelectionEnabled: true,
              isCountryButtonPersistent: true,
              countryButtonStyle: const CountryButtonStyle(
                showDialCode: true,
                // showIsoCode: true,
                showFlag: true,
                flagSize: 16,
              ),

              // + all parameters of TextField
              // + all parameters of FormField
              // ...
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {},
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
