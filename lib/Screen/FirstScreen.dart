import 'package:flutter/material.dart';
import 'package:tes_internship_william_hubertus/Screen/SecondScreen.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController palindromeController = TextEditingController();

  void showCustomDialog(BuildContext context, String message,
      {bool isPalindrome = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(
                isPalindrome
                    ? Icons.check_circle
                    : Icons.error, // Ikon berdasarkan hasil
                color: isPalindrome ? Colors.green : Colors.red,
              ),
              SizedBox(width: 10),
              Text('Result'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFF2B637B),
              ),
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  bool isPalindrome(String input) {
    String processedInput = input.replaceAll(' ', '').toLowerCase();
    String reversedInput = processedInput.split('').reversed.join('');
    return processedInput == reversedInput;
  }

  void checkPalindrome() {
    if (palindromeController.text.isEmpty) {
      showCustomDialog(context, 'Please fill palindrome field.');
      return;
    }

    if (isPalindrome(palindromeController.text)) {
      showCustomDialog(context, 'Is palindrome', isPalindrome: true);
    } else {
      showCustomDialog(context, 'Not palindrome', isPalindrome: false);
    }
  }

  void navigateToNextScreen() {
    if (nameController.text.isEmpty || palindromeController.text.isEmpty) {
      showCustomDialog(context, 'Please fill in both fields.');
    } else {
      if (!isPalindrome(palindromeController.text)) {
        showCustomDialog(context, 'It must be palindrome');
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondScreen(name: nameController.text),
          ),
        );
      }
    }
  }

  Future<void> clearTextFields() async {
    setState(() {
      nameController.clear();
      palindromeController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
          RefreshIndicator(
            onRefresh: clearTextFields,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 200), 
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    child: Icon(
                      Icons.person_add_alt_1_rounded,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextField(
                      controller: palindromeController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Palindrome',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: checkPalindrome,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2B637B),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'CHECK',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: navigateToNextScreen,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2B637B),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'NEXT',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 200), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
