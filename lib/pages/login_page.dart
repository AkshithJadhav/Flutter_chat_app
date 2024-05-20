import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  //email and pass controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final void Function()? onTap;

  LoginPage({
    super.key,
    required this.onTap,
  });

  //login
  void login(BuildContext context) async {
    //auth service
    final authService = AuthService();

    //try
    try {
      await authService.signInWithtEmailPassword(
          _emailController.text, _passController.text);
    }
    //catch
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
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
              'Welcome Back, you\'ve been missed!',
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
            const SizedBox(
              height: 10,
            ),
            //password
            MyTextField(
              hinttext: 'Enter Password',
              obscuretext: true,
              controller: _passController,
            ),
            const SizedBox(height: 25),
            //login
            MyButton(
              text: 'Login',
              onTap: () => login(context),
            ),
            const SizedBox(height: 25),
            //register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member? ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text('Register Now',
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
