import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AboutAppContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.39,
      margin: EdgeInsets.fromLTRB(16, 35, 16, 32),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.4),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(height: 36),
          SvgPicture.asset("assets/images/app_name.svg"),
          Container(height: 50),
          Text(
            'Developed by',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Container(height: 20),
          Text(
            'Team Asgardians',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 30),
          Text(
            'Roshan G Rahman',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          Container(height: 6),
          Text(
            'Siva Perumal K',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          Container(height: 6),
          Text(
            'Varun M',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          Container(height: 6),
          Text(
            'Suresh Kumar V',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          Container(height: 8),
        ],
      ),
    );
  }
}
