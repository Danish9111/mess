import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final bool isUser = true;

  // const ProfileScreen({super.key, required this.isUser});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _headerAnimation;
  late Animation<double> _contentAnimation;
  late Animation<double> _buttonAnimation;
  late Animation<Color?> _appBarColorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Header animation (fade + slide)
    _headerAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.4, curve: Curves.easeOut),
    ));

    // Content animation (staggered fade)
    _contentAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.8, curve: Curves.easeIn),
    ));

    // Button animation (bounce effect)
    _buttonAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 1.0, curve: Curves.elasticOut),
    ));

    // App bar color animation
    _appBarColorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.lightBlueAccent.withOpacity(0.9),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    // Start animations after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // Modern big app bar with color animation
              SliverAppBar(
                expandedHeight: 240.0,
                pinned: true,
                backgroundColor: _appBarColorAnimation.value,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.blueAccent,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: kToolbarHeight * 1.5),
                      child: Transform.translate(
                        offset: Offset(0, 50 * (1 - _headerAnimation.value)),
                        child: Opacity(
                          opacity: _headerAnimation.value,
                          child: _buildProfileHeader(),
                        ),
                      ),
                    ),
                  ),
                  title: Transform.scale(
                    scale: 1.0 + (0.2 * (1 - _headerAnimation.value)),
                    child: Text(
                      widget.isUser ? "User Profile" : "Manager Dashboard",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 4.0,
                            color: Colors.black26,
                            offset: const Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(bottom: 16),
                ),
                actions: [
                  ScaleTransition(
                    scale: _buttonAnimation,
                    child: IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),

              // Main content section with staggered animations
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        // User-specific content with fade animation
                        FadeTransition(
                          opacity: _contentAnimation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.3),
                              end: Offset.zero,
                            ).animate(_contentAnimation),
                            child: _buildUserSpecificContent(),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Common section with fade animation
                        FadeTransition(
                          opacity: _contentAnimation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.2),
                              end: Offset.zero,
                            ).animate(_contentAnimation),
                            child: _buildCommonSection(),
                          ),
                        ),
                        const SizedBox(height: 40),
                        // Logout button with bounce animation
                        ScaleTransition(
                          scale: _buttonAnimation,
                          child: _buildLogoutButton(context),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        // Profile picture with scale animation
        ScaleTransition(
          scale: _headerAnimation,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 46,
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.blue),
                  onPressed: () => _animateCameraIcon(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Name with fade animation
        FadeTransition(
          opacity: _headerAnimation,
          child: Text(
            widget.isUser ? 'John Doe' : 'Sarah Manager',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Email with fade animation
        FadeTransition(
          opacity: _headerAnimation,
          child: Text(
            widget.isUser ? 'john.doe@example.com' : 'sarah@messmanager.com',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Edit button with scale animation
        ScaleTransition(
          scale: _buttonAnimation,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 3,
            ),
            child: const Text('Edit Profile'),
          ),
        ),
      ],
    );
  }

  void _animateCameraIcon() {
    // Create a temporary animation for camera icon press
    final animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    final animation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      }
    });

    animationController.forward();

    // Show dialog after animation completes
    Future.delayed(const Duration(milliseconds: 600), () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Upload Photo"),
          content:
              const Text("Choose an option to update your profile picture"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Camera"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Gallery"),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildUserSpecificContent() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              widget.isUser ? 'User Settings' : 'Manager Dashboard',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
          ),
          ..._buildUserSpecificTiles(),
        ],
      ),
    );
  }

  List<Widget> _buildUserSpecificTiles() {
    if (widget.isUser) {
      return [
        _buildAnimatedTile(Icons.fastfood, 'My Orders', 0),
        _buildAnimatedTile(Icons.favorite, 'My Favorites', 1),
        _buildAnimatedTile(Icons.restaurant_menu, 'Dietary Preferences', 2),
        _buildAnimatedTile(Icons.notifications, 'Notification Settings', 3),
        _buildAnimatedTile(Icons.payment, 'Payment Methods', 4),
      ];
    } else {
      return [
        _buildAnimatedTile(Icons.business, 'Mess Name', 0),
        _buildAnimatedTile(Icons.people, 'Total Subscribers', 1),
        _buildAnimatedTile(Icons.menu_book, 'Menu Management', 2),
        _buildAnimatedTile(Icons.subscriptions, 'Subscription Settings', 3),
        _buildAnimatedTile(Icons.analytics, 'Revenue Dashboard', 4),
        _buildAnimatedTile(Icons.support_agent, 'Staff Requests', 5),
      ];
    }
  }

  Widget _buildAnimatedTile(IconData icon, String title, int index) {
    // Create staggered animation based on index
    final animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.4 + (0.1 * index),
          0.8 + (0.1 * index),
          curve: Curves.easeInOut,
        ),
      ),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.5, 0),
          end: Offset.zero,
        ).animate(animation),
        child: _buildTile(icon, title),
      ),
    );
  }

  Widget _buildCommonSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              'Support',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
          ),
          _buildTile(Icons.help, 'Help & Support'),
        ],
      ),
    );
  }

  Widget _buildTile(IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.lightBlue[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.blue),
          ),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          trailing: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.lightBlue[50],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_forward_ios,
                size: 14, color: Colors.blue),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          onTap: () => _onTileTap(title),
        ),
        const Divider(height: 1, indent: 72, endIndent: 16),
      ],
    );
  }

  void _onTileTap(String title) {
    // Create ripple effect animation
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
          appBar: AppBar(title: Text(title)),
          body: Center(child: Text('$title Screen')),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.9, end: 1).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: const Icon(Icons.logout, color: Colors.red),
        label: const Text('Logout', style: TextStyle(color: Colors.red)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: const BorderSide(color: Colors.red),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () => _confirmLogout(context),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              title: const Text(
                'Are you sure you want to logout?',
                style: TextStyle(fontWeight: FontWeight.bold),
                // subtitle: const Text('You can always log back in'),
                // leading: const Icon(Icons.logout, color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      // Actual logout logic here
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
