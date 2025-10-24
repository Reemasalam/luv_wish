import 'package:flutter/material.dart';
import 'package:luve_wish/CartScreen/AddressFormScreen.dart';
import 'package:luve_wish/LoginScreen/LoginScreen.dart';
import 'package:luve_wish/MyOrder/MyOrderScreen.dart';
import 'package:luve_wish/Wishlist/WishlistScreen.dart';


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            // Profile Header
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/profile.jpg'), // Add your profile image
                ),
                SizedBox(width: 16.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sarah Anderson',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'sarah.anderson@email.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Premium Member',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            // Account Section inside a Container
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                'Account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildListItem('My Orders', Icons.history_outlined, 'View your order history', context),
                  _buildListItem('Delivery Addresses', Icons.location_on_outlined, 'Manage your addresses', context),
                  _buildListItem('Payment Methods', Icons.credit_card_outlined, 'Manage your payment methods', context),
                  _buildListItem('Saved Items', Icons.favorite_border, 'Your Wish List', context),
                ],
              ),
            ),
            SizedBox(height: 24),
            // Log out Section inside a Container
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListTile(
                title: Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.red,
                ),
                onTap: () {
                  _showLogoutConfirmationDialog(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // List item widget for simple text, outline icons, and navigation
  Widget _buildListItem(String title, IconData icon, String description, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        description,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: () {
        // Navigate to the corresponding screen when the arrow is clicked
        if (title == 'My Orders') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyOrderScreen()),
          );
        } else if (title == 'Delivery Addresses') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddressFormScreen()),
          );
        } else if (title == 'Payment Methods') {
         // Navigator.push(
           // context,
           // MaterialPageRoute(builder: (context) => PaymentMethodsScreen()),
         // );
        } else if (title == 'Saved Items') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WishlistScreen()),
          );
        }
      },
    );
  }

  // Show logout confirmation dialog
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the login screen (replace with your actual login screen)
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Log Out'),
            ),
          ],
        );
      },
    );
  }
}

//




