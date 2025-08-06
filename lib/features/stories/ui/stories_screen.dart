// stories_screen.dart
import 'package:flutter/material.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EC), // Soft, cozy background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),

              // TextButton - Flat style button
              // This is a flat button with no elevation by default.
              // It's usually used for less important or secondary actions like "Cancel" or "Skip".
              TextButton(
                onPressed: () {
                  // nothing yet
                },
                style: TextButton.styleFrom(
                  //we can change the overlay color when the btn is pressed as below
                  overlayColor: Colors.black,
                  foregroundColor: const Color(0xFF3E2723),
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text(
                  'Text Button',
                  style: TextStyle(
                      fontFamily: "Poppins", fontWeight: FontWeight.w600),
                ),
              ),

              const SizedBox(height: 70),

              // ElevatedButton - Raised style
              // This button appears "lifted" with shadow and a background by default.
              // It's typically used for primary actions like "Submit", "Continue", etc.
              // More prominent in the UI and draws attention to user interaction.
              ElevatedButton(
                onPressed: () {
                  //nothing yet
                },
                style: ElevatedButton.styleFrom(
                  overlayColor: Colors.black,

                  backgroundColor: const Color(0xFFD7CCC8),
                  // Background color
                  foregroundColor: const Color(0xFF3E2723),
                  // Text color
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
                  elevation: 3,
                  // Default elevation (adds shadow)
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12), // Rounded edges for a modern look
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text(
                  'Elevated Button',
                  style: TextStyle(
                      fontFamily: "Poppins", fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
