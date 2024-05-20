import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();
  final void Function()? onTap;
  RegisterPage({
    super.key,
    required this.onTap,
  });

  //register
  void register(BuildContext context) {
    //get auth service
    final _auth = AuthService();

    //if password matches
    if (_passController.text == _confirmpassController.text) {
      try {
        _auth.signUpWithEmailPassword(
          _emailController.text,
          _passController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }
    //if password dosent match
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Center(child: Text('Password don\'t match\nTry Again!')),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(),
              icon: const Icon(Icons.dark_mode_outlined))
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 30),
            //welcome back text
            Text(
              'Lets Create an Account for you!',
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 25),
            //email
            MyTextField(
              hinttext: 'Enter your Mail',
              obscuretext: false,
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            //password
            MyTextField(
              hinttext: 'Enter Password',
              obscuretext: true,
              controller: _passController,
            ),
            const SizedBox(height: 10),
            //confirm password
            MyTextField(
              hinttext: 'Confirm Password',
              obscuretext: true,
              controller: _confirmpassController,
            ),
            const SizedBox(height: 25),
            //login
            MyButton(
              text: 'Register',
              onTap: () => register(context),
            ),
            const SizedBox(height: 25),
            //register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already a member? ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text('Login Now',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
