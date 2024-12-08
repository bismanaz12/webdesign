import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:screendesign/row.dart';

class NavItem {
  final String title;
  final List<String>? dropdownContent;

  NavItem({required this.title, this.dropdownContent});
}

class ContinuousImageGallery extends StatefulWidget {
  final List<String> imagePaths;
  final Duration displayDuration;
  final Duration transitionDuration;

  const ContinuousImageGallery({
    Key? key,
    required this.imagePaths,
    this.displayDuration = const Duration(seconds: 3),
    this.transitionDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  _ContinuousImageGalleryState createState() => _ContinuousImageGalleryState();
}

class _ContinuousImageGalleryState extends State<ContinuousImageGallery> {
  late int _currentImageIndex;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _currentImageIndex = 0;

    // Start the infinite image sequence
    Future.delayed(Duration(seconds: 1), _startInfiniteImageSequence);
  }

  void _startInfiniteImageSequence() {
    // Ensure we have images to display
    if (widget.imagePaths.isEmpty) return;

    setState(() {
      _isVisible = true;
    });

    // Schedule next image transition
    Future.delayed(widget.displayDuration, () {
      setState(() {
        _isVisible = false;
      });

      // Wait for fade out before moving to next image
      Future.delayed(widget.transitionDuration, () {
        setState(() {
          // Cycle back to first image when reaching the end
          _currentImageIndex =
              (_currentImageIndex + 1) % widget.imagePaths.length;
        });

        // Continue the infinite sequence
        _startInfiniteImageSequence();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ensure we have at least one image
    if (widget.imagePaths.isEmpty) {
      return Container();
    }

    return Container(
      height: 400,
      width: double.infinity,
      child: _isVisible
          ? Image.asset(
              widget.imagePaths[_currentImageIndex],
              fit: BoxFit.cover,
            ).animate(effects: [
              FadeEffect(duration: widget.transitionDuration),
              ScaleEffect(
                  begin: Offset(0.9, 0.9),
                  end: Offset(1.0, 1.0),
                  duration: Duration(milliseconds: 700)),
              ShimmerEffect(
                  delay: Duration(seconds: 1), duration: Duration(seconds: 2)),
              MoveEffect(
                  begin: Offset(10, 10),
                  end: Offset.zero,
                  duration: Duration(milliseconds: 700))
            ])
          : Container(), // Invisible between transitions
    );
  }
}

class AnimatedScreen extends StatefulWidget {
  const AnimatedScreen({super.key});

  @override
  _AnimatedScreenState createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentIndex = 0; // Track current selected index
  String? _hoveredItem; // Track hovered menu item

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<NavItem> navItems = [
    NavItem(
      title: 'Home',
      dropdownContent: null,
    ),
    NavItem(
      title: 'About',
      dropdownContent: [
        "Director's Message",
        "Principle's Message"
            'Meet the Team',
        'Campus Facilities',
        'Healthy & Safety',
        'Extracurricular Activities',
        'School Uniform',
        'School Transportation',
        'Our Location'
      ],
    ),
    NavItem(
      title: 'Learning Philosophy',
      dropdownContent: [
        'Learn By Doing',
        'Curriculum',
        'Key Stages & Building Blocks',
        'Academic Philosophy',
        'Digital Ecosystem',
        'Accreditations',
        'E-learning Platforms',
        'Learning Destinations'
      ],
    ),
    NavItem(
      title: 'Admissions',
      dropdownContent: [
        'Admission Process',
        'Why Us',
        'Enrol Now',
        'School Calender'
      ],
    ),
    NavItem(
      title: 'For Parents',
      dropdownContent: [
        'Briding Gaps',
        'Parents Testimonials',
        'Feedback & Suggestions'
      ],
    ),
    NavItem(
      title: 'Media Gallery',
      dropdownContent: ['Photos', 'Videos'],
    ),
    NavItem(
      title: 'Contact',
      dropdownContent: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 251, 235),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.orange.shade100,
                    Colors.orange.shade50,
                  ],
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 1200) {
                          return _buildFullDesktopLayout();
                        } else if (constraints.maxWidth > 600) {
                          return _buildCompactDesktopLayout();
                        } else {
                          return _buildMobileLayout();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1200) {
                  return _buildFullDesktopNavBar();
                } else if (constraints.maxWidth > 600) {
                  return _buildCompactDesktopNavBar();
                } else {
                  return _buildMobileNavBar();
                }
              },
            ),
            ContinuousImageGallery(
              imagePaths: [
                'assets/images/images1.jpeg',
                'assets/images/images2.jpeg',
                'assets/images/image3.jpg',
                'assets/images/images1.jpeg',
                'assets/images/image3.jpg',
              ],
            ),
            ResponsiveSchoolInfo()
          ],
        ),
      ),
    );
  }

  Widget _buildFullDesktopNavBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildNavBarItems(isFullDesktop: true),
      ),
    );
  }

  Widget _buildCompactDesktopNavBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 15, // Horizontal spacing between items
          runSpacing: 15, // Vertical spacing between rows
          children: _buildNavBarItems(isFullDesktop: false)
              .map((item) => item)
              .toList(),
        ),
      ),
    );
  }

  Widget _buildMobileNavBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10, // Horizontal spacing between items
          runSpacing: 10, // Vertical spacing between rows
          children: _buildNavBarItems(isFullDesktop: false)
              .map((item) => item)
              .toList(),
        ),
      ),
    );
  }

  List<Widget> _buildNavBarItems({required bool isFullDesktop}) {
    return navItems.map((item) {
      return StatefulBuilder(
        builder: (context, setState) {
          return MouseRegion(
            onEnter: (_) {
              this.setState(() {
                _hoveredItem = item.title;
              });
            },
            onExit: (_) {
              this.setState(() {
                _hoveredItem = null;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isFullDesktop ? 12.0 : 8.0,
                vertical: 8.0,
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () {
                      this.setState(() {
                        _currentIndex = navItems.indexOf(item);
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                            color: _currentIndex == navItems.indexOf(item)
                                ? Colors.orange[300]
                                : Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (item.dropdownContent != null)
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: _currentIndex == navItems.indexOf(item)
                                ? Colors.orange[300]
                                : Colors.black,
                          )
                      ],
                    ),
                  ),

                  // Dropdown Container
                  if (_hoveredItem == item.title &&
                      item.dropdownContent != null)
                    Positioned(
                      top: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange[300],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 10,
                            )
                          ],
                        ),
                        padding: EdgeInsets.only(top: 4),
                        child: Container(
                          width: 300, // Adjusted width
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 10,
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: item.dropdownContent!
                                .map((content) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Text(
                                        content,
                                        softWrap: true,
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 13,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    }).toList();
  }

  // Floating Animation Widget
  Widget _animatedContainer(Widget child) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, widget) {
        return Transform.translate(
          offset: Offset(0, 5 * (_controller.value - 0.5)),
          child: child,
        );
      },
    );
  }

  // Full Desktop Layout
  Widget _buildFullDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildContactSection(),
        _buildCallbackSection(),
        _buildSocialMediaIcons(),
        _buildEnrollButton(),
      ],
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .slideX(begin: 0.1, end: 0, duration: 500.ms);
  }

  // Compact Desktop Layout
  Widget _buildCompactDesktopLayout() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 10,
      runSpacing: 10,
      children: [
        _buildContactSection(),
        _buildCallbackSection(),
        _buildSocialMediaIcons(),
        _buildEnrollButton(),
      ],
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .slideX(begin: 0.1, end: 0, duration: 500.ms);
  }

  // Mobile Layout
  Widget _buildMobileLayout() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildMobileContactInfo(),
          const SizedBox(height: 10),
          _buildMobileCallbackSection(),
          const SizedBox(height: 10),
          _buildMobileSocialMediaIcons(),
          const SizedBox(height: 10),
          _buildMobileEnrollButton(),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.1, end: 0, duration: 500.ms);
  }

  // Hover Effect Wrapper
  Widget _hoverEffect({required Widget child}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.shade200.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
            )
          ],
        ),
        child: child,
      ),
    );
  }

  // Pulsing Animation for Social Icons
  Widget _buildPulsingSocialIcon(String assetPath) {
    return Image.asset(
      assetPath,
      color: Colors.orange[300],
      height: 22,
      width: 22,
    )
        .animate()
        .scale(duration: 800.ms, curve: Curves.easeInOut)
        .shake(delay: 800.ms, duration: 500.ms);
  }

  // Contact Section
  Widget _buildContactSection() {
    return _animatedContainer(
      _hoverEffect(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange[300],
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade400.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  )
                ],
              ),
              padding: const EdgeInsets.all(11),
              child: const Icon(
                Icons.attach_email_outlined,
                color: Colors.white,
                size: 25,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'info@thevantagesschool.com',
              style: TextStyle(
                color: Colors.orange[300],
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Callback Section
  Widget _buildCallbackSection() {
    return _animatedContainer(
      _hoverEffect(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: Colors.orange[300],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade400.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  )
                ],
              ),
              child: const Icon(
                Icons.call,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Get A Call Back',
              style: TextStyle(
                color: Colors.orange[300],
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Social Media Icons
  Widget _buildSocialMediaIcons() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _buildPulsingSocialIcon('assets/images/facebook.png'),
        _buildPulsingSocialIcon('assets/images/youtube.png'),
        _buildPulsingSocialIcon('assets/images/insta.png'),
        _buildPulsingSocialIcon('assets/images/twitter.png'),
        _buildPulsingSocialIcon('assets/images/linkedin.png'),
      ],
    ).animate().fadeIn(duration: 700.ms).shimmer(duration: 1000.ms);
  }

  // Enroll Button
  Widget _buildEnrollButton() {
    return _hoverEffect(
      child: Container(
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.orange[300],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.shade400.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Center(
          child: Text(
            'Enrol Now',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.2, end: 0, duration: 500.ms);
  }

  // Mobile Contact Info
  Widget _buildMobileContactInfo() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange[300],
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade400.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 5,
                  )
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.email_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'info@thevantagesschool.com',
              style: TextStyle(
                color: Colors.orange[300],
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1, end: 0),
    );
  }

  // Mobile Callback Section
  Widget _buildMobileCallbackSection() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange[300],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade400.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 5,
                  )
                ],
              ),
              child: const Icon(
                Icons.call,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Get A Call Back',
              style: TextStyle(
                color: Colors.orange[300],
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.1, end: 0),
    );
  }

  // Mobile Social Media Icons
  Widget _buildMobileSocialMediaIcons() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 15,
          runSpacing: 10,
          children: [
            _buildPulsingSocialIcon('assets/images/facebook.png'),
            _buildPulsingSocialIcon('assets/images/youtube.png'),
            _buildPulsingSocialIcon('assets/images/insta.png'),
            _buildPulsingSocialIcon('assets/images/twitter.png'),
            _buildPulsingSocialIcon('assets/images/linkedin.png'),
          ],
        ),
      ).animate().fadeIn(duration: 700.ms).shimmer(duration: 1000.ms),
    );
  }

  // Mobile Enroll Button
  Widget _buildMobileEnrollButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 250,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.orange[300],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.shade400.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Center(
        child: Text(
          'Enrol Now',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.2, end: 0, duration: 500.ms);
  }
}
