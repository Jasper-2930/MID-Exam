import 'package:flutter/material.dart';

void main() {
  runApp(const GRCApp());
}

class GRCApp extends StatelessWidget {
  const GRCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Global Reciprocal Colleges",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}

// ---------------- Home Page with Bottom Navigation ----------------
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const CCSPage(),
    const EventsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        titleSpacing: 0,
        title: Row(
          children: [
            // Circle profile slot (upper-left)


            const SizedBox(width: 20),
            const Text(
              "Global Reciprocal Colleges",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red[800],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: "CCS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: "Events",
          ),
        ],
      ),
    );
  }
}

// ---------------- Home Page Design ----------------
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFc62828), // dark red
                Color(0xFFe53935), // light red
              ],
            ),
          ),
        ),
        // Content
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "GLOBAL RECIPROCAL COLLEGES",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "TOUCHING HEARTS, RENEWING MINDS, TRANSFORMING LIVES",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        // Wave bottom
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: 120,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------- CCS Page ----------------
class CCSPage extends StatelessWidget {
  const CCSPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = ["Information Technology (IT)", "CCS", "CBAE", "COA", "COE"];

    return ListView.builder(
      itemCount: courses.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.red[50],
          child: ListTile(
            leading: const Icon(Icons.book, color: Colors.red),
            title: Text(
              courses[index],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        );
      },
    );
  }
}

// ---------------- Events Page ----------------
class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      {"title": "Foundation Day", "date": "October 15, 2025"},
      {"title": "Intramurals", "date": "November 10–14, 2025"},
      {"title": "IT Symposium", "date": "December 5, 2025"},
      {"title": "Christmas Party", "date": "December 20, 2025"},
    ];

    return ListView.builder(
      itemCount: events.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.event, color: Colors.red),
            title: Text(events[index]["title"]!),
            subtitle: Text("Date: ${events[index]["date"]}"),
          ),
        );
      },
    );
  }
}

// ---------------- Wave Shape ----------------
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(3 * size.width / 4, size.height - 60);
    var secondEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(
        secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
