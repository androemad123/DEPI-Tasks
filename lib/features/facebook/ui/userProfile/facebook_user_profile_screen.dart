import 'package:flutter/material.dart';

class FacebookUserProfileScreen extends StatefulWidget {
  const FacebookUserProfileScreen({super.key});

  @override
  State<FacebookUserProfileScreen> createState() =>
      _FacebookUserProfileScreen();
}

class _FacebookUserProfileScreen extends State<FacebookUserProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildProfileHeader(),
          SizedBox(height: 45,),
          _buildProfileActions(),
          _buildProfileInfo(),
          const Divider(height: 10, thickness: 1, color: Colors.grey),
          _buildTabBar(),
          _buildTabBarView(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://dummyjson.com/image/400x200'),
              // Placeholder
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Positioned(
          top: 120,
          left: 10 ,
          child: CircleAvatar(
            radius: 75,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(
                  'https://dummyjson.com/image/150x150'), // Placeholder
            ),
          ),
        ),
        Positioned(
          left: 120,
          top: 220,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.camera_alt,
              color: Colors.black54,
              size: 20,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.camera_alt,
              color: Colors.black54,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileActions() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Andrew Habib',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            '1.1k Friends',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Add to Story'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz, color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.work, color: Colors.grey),
              SizedBox(width: 8),
              Text('Works at Example Co.'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.school, color: Colors.grey),
              SizedBox(width: 8),
              Text('Studied at University of XYZ'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.grey),
              SizedBox(width: 8),
              Text('Lives in City, Country'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.more_horiz, color: Colors.grey),
              SizedBox(width: 8),
              Text('See Your About Info'),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.blue,
        tabs: const [
          Tab(text: 'Posts'),
          Tab(text: 'Photos'),
          Tab(text: 'Friends'),
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height * 0.8, // Adjust height as needed
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildPostsTab(),
          _buildPhotosTab(),
          _buildFriendsTab(),
        ],
      ),
    );
  }

  Widget _buildPostsTab() {
    return Center(
      child: Text("Posts"),
    );
  }

  Widget _buildPhotosTab() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      // Important for nested scrolling
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: 9,
      // Example photos
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  'https://dummyjson.com/image/100x100/008080/ffffff?text=${index + 1}'), // Placeholder
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  Widget _buildFriendsTab() {
    return Center(child: Text("friends"));
  }
}
