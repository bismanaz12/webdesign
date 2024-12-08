import 'package:flutter/material.dart';

class ResponsiveSchoolInfo extends StatelessWidget {
  const ResponsiveSchoolInfo({super.key});

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine layout based on screen width
        if (constraints.maxWidth > 1200) {
          return _buildFullDesktopLayout(context);
        } else if (constraints.maxWidth > 600) {
          return _buildTabletLayout(context);
        } else {
          return _buildMobileLayout(context);
        }
      },
    );
  }

  Widget _buildFullDesktopLayout(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, opacity, child) {
        return Opacity(
          opacity: opacity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _buildInformationColumn(),
              ),
              Expanded(
                flex: 3,
                child: _buildLogoAndIntroColumn(),
              ),
              Expanded(
                flex: 2,
                child: _buildContactAndSocialColumn(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, opacity, child) {
        return Opacity(
          opacity: opacity,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildInformationColumn()),
                  Expanded(child: _buildLogoAndIntroColumn()),
                ],
              ),
              _buildContactAndSocialColumn(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, opacity, child) {
        return Opacity(
          opacity: opacity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildInformationColumn(),
                _buildLogoAndIntroColumn(),
                _buildContactAndSocialColumn(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInformationColumn() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: 250,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Information of TextBoard'),
              _buildInfoItem(
                  'Curriculum', 'The National Curriculum in England'),
              _buildInfoItem('School', 'Cambridge International School'),
              _buildInfoItem('Year Levels', 'Play Group – Cambridge IGCSE'),
              _buildAcademicCalendar(),
              _buildHighlightItem('Fully air-conditioned classes'),
              _buildHighlightItem(
                  'CCTV coverage and strict security protocols'),
              _buildHighlightItem('Professional and experienced management'),
              _buildHighlightItem('Highly qualified faculty members'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoAndIntroColumn() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 500,
        maxHeight: 800,
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 250,
                  width: 350,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'The Vantage – An Introduction',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 4, 57, 100),
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Text(
                      "At The Vantage School, we are committed to providing an exceptional educational experience that goes beyond traditional learning. Our innovative approach combines the rigorous British Curriculum with a holistic development strategy, ensuring that each student receives personalized attention and comprehensive support.",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Our state-of-the-art facilities are designed to create an inspiring and dynamic learning environment. From advanced technological resources to collaborative spaces, we provide students with the tools and infrastructure necessary to explore, innovate, and excel in their academic and personal pursuits.",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "We believe in nurturing not just academic excellence, but also emotional intelligence, critical thinking, and global citizenship. Our curriculum is designed to prepare students for the challenges of the 21st century, equipping them with the skills, knowledge, and ethical grounding to become leaders and changemakers in their chosen fields.",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactAndSocialColumn() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 500,
        maxHeight: 950,
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            _buildContactSection(),
            _buildSocialMediaIcons(),
            _buildPrincipalMessage(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            'Locations & Contact',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'D-5, Block-9, Gulshan-e-Iqbal, Karachi, Pakistan',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'PABX: +92 213 482 2408-09',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            'WhatsApp: +92 316 279 2278',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            'info@thevantageschool.com',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaIcons() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSocialIcon('assets/images/facebook.png', Colors.blue),
          _buildSocialIcon('assets/images/youtube.png', Colors.red),
          _buildSocialIcon('assets/images/insta.png', Colors.pink),
          _buildSocialIcon('assets/images/twitter.png', Colors.lightBlue),
          _buildSocialIcon('assets/images/linkedin.png', Colors.indigo),
        ],
      ),
    );
  }

  Widget _buildPrincipalMessage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 120,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16),
          Text(
            'Principal\'s Vision and Message',
            style: TextStyle(
              color: Colors.grey[900],
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            "Education is not just about academic achievements, but about cultivating a lifelong love for learning, critical thinking, and personal growth. At The Vantage School, we are dedicated to creating an environment that nurtures each student's unique potential, encouraging them to become independent, creative, and compassionate individuals.",
            style: TextStyle(
              color: Colors.grey[800],
              fontFamily: 'Poppins',
              fontSize: 16,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 16),
          Text(
            "Our approach goes beyond traditional education. We integrate cutting-edge pedagogical techniques with a holistic development framework that addresses academic, emotional, and social aspects of learning. By providing personalized guidance, fostering a growth mindset, and creating a supportive community, we empower our students to become confident, adaptable, and forward-thinking leaders.",
            style: TextStyle(
              color: Colors.grey[800],
              fontFamily: 'Poppins',
              fontSize: 16,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 24),
          Text(
            'Ms. Saima Shah',
            style: TextStyle(
              color: Colors.grey[900],
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Principal',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: const Color.fromARGB(255, 4, 57, 100),
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightItem(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline,
              color: Colors.blue.shade300, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.blue.shade800,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(String assetPath, Color bgColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(8),
      child: Image.asset(
        assetPath,
        color: Colors.white,
        width: 24,
        height: 24,
      ),
    );
  }

  Widget _buildAcademicCalendar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Annual Academic Calendar',
            style: TextStyle(
              color: Colors.green.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          _buildCalendarTerm('Term 1', 'September - December'),
          _buildCalendarTerm('Term 2', 'January - March'),
          _buildCalendarTerm('Term 3', 'April - June'),
        ],
      ),
    );
  }

  Widget _buildCalendarTerm(String term, String months) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.calendar_month, color: Colors.green.shade300, size: 20),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                term,
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                months,
                style: TextStyle(
                  color: Colors.green.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
