import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quoteflow_app/views/widgets/hero_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? quote;
  String? author;
  bool isLoading = true;

  Future<void> fetchQuote() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://api.api-ninjas.com/v1/quotes'),
        headers: {
          'Content-Type': 'application/json',
          'X-Api-key': dotenv.env['API_NINJAS_KEY'] ?? '',
        },
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        if (jsonData.isNotEmpty) {
          Map<String, dynamic> quoteData = jsonData[0];
          if (mounted) {
            setState(() {
              quote = quoteData['quote'];
              author = quoteData['author'];
              isLoading = false;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              quote = 'No quotes available';
              author = 'unknown';
              isLoading = false;
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            quote = 'Failed to load quote';
            author = 'unknown';
            isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          quote = 'Error loading quote';
          author = e.toString();
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.0),
              HeroWidget(title: 'Showtime App'),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child:
                    isLoading
                        ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white70,
                          ),
                        )
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              quote ?? "No quote avaliable",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 40.0),
                            Text(
                              '-${author ?? "Unknown"}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
              ),

              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: FilledButton(
                  onPressed: () {
                    fetchQuote();
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.teal,
                    textStyle: TextStyle(fontSize: 20.0),
                    minimumSize: Size(double.infinity, 40.0),
                  ),
                  child: Text(
                    'Get New Quote',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
