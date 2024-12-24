import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double _rating = 3.5;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          title: Center(child: Text('Book Details')),
          actions: [
            IconButton(icon: Icon(Icons.favorite_border), onPressed: () {})
          ],
        ),
      ),
      body: Column(
        children: [
          // Book Image and Title Section (Fixed)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              children: [
                SizedBox(
                    height: screenHeight *
                        0.02), // Optional, to maintain some padding from top
                Image.asset(
                  'images/book1.png',
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.3,
                ),
                // Removed SizedBox here to eliminate space between book and title
                Text(
                  'Catcher in the Rye',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Muhammad Usaid',
                  style: TextStyle(fontSize: screenWidth * 0.03),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      initialRating: 3.5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: screenWidth * 0.05,
                      itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print("Rating is : $rating");
                      },
                    ),
                    SizedBox(width: 8),
                    Text(
                      '$_rating',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),

          // Scrollable About Author and Overview Sections
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // About Author Section
                    Text(
                      'About Author',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Muhammad Usaid is an emerging author known for his creative storytelling and captivating characters. His works often explore themes of human nature, resilience, and societal change.',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 20),

                    // Overview Section
                    Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'The book "Catcher in the Rye" is a profound exploration of the struggles of adolescence, identity, and the complex nature of human relationships.',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          // Buttons Section (New button on left, Old button on right)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // New Button (left side)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 219, 59),
                    shadowColor: Colors.black,
                    elevation: 5,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.015,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'New',
                    style: TextStyle(
                        fontSize: screenWidth * 0.04, color: Colors.black),
                  ),
                ),
                // Old Button (right side)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 54, 54, 54),
                    shadowColor: Colors.black,
                    elevation: 5,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.015,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Old',
                    style: TextStyle(
                        fontSize: screenWidth * 0.04, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
