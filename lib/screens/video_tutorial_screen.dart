
import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';
import 'video_detail_screen.dart';

class VideoTutorialScreen extends StatefulWidget {
  const VideoTutorialScreen({super.key});

  @override
  State<VideoTutorialScreen> createState() =>
      _VideoTutorialScreenState();
}

class _VideoTutorialScreenState
    extends State<VideoTutorialScreen> {
  static const Color primaryGreen = Color(0xFF2E7D32);

  String selectedCategory = 'Semua';
  String searchQuery = '';

  final TextEditingController
      _searchController =
      TextEditingController();

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Semua',
      'icon': Icons.play_circle_outline,
    },
    {
      'title': 'Daur Ulang',
      'icon': Icons.recycling,
    },
    {
      'title': 'Kompos',
      'icon': Icons.delete_outline,
    },
    {
      'title': 'Pemilahan',
      'icon': Icons.restore_from_trash_outlined,
    },
    {
      'title': 'Eco Tips',
      'icon': Icons.eco_outlined,
    },
  ];

  final List<Map<String, dynamic>> videos = [
    {
      'title':
          'Cara Budi Speed Mengelola Sampah dengan IQ 150!',
      'creator': 'Budi Speed',
      'category': 'Eco Tips',
      'views': '66K views',
      'time': '2 hari lalu',
      'duration': '10:23',
      'thumbnail':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1200&auto=format&fit=crop',
    },
    {
      'title':
          'Marathon Undang Pandawara! Serasa Ikut Nongkrong',
      'creator': 'Reza Indo',
      'category': 'Daur Ulang',
      'views': '66K views',
      'time': '5 hari lalu',
      'duration': '08:45',
      'thumbnail':
          'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?q=80&w=1200&auto=format&fit=crop',
    },
    {
      'title':
          'Cara Dr.Tirta Join Pandawara',
      'creator': 'Dr.Tirta',
      'category': 'Pemilahan',
      'views': '66K views',
      'time': '1 minggu lalu',
      'duration': '12:15',
      'thumbnail':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=1200&auto=format&fit=crop',
    },
    {
      'title':
          'Kompos dari Sampah Dapur, Mudah dan Praktis!',
      'creator': 'TrashBack Official',
      'category': 'Kompos',
      'views': '45K views',
      'time': '1 minggu lalu',
      'duration': '07:30',
      'thumbnail':
          'https://images.unsplash.com/photo-1520607162513-77705c0f0d4a?q=80&w=1200&auto=format&fit=crop',
    },
  ];

  List<Map<String, dynamic>>
      filteredVideos = [];

  @override
  void initState() {
    super.initState();
    filteredVideos = videos;
  }

  void _runFilter() {
    List<Map<String, dynamic>> results =
        [];

    if (selectedCategory == 'Semua' &&
        searchQuery.isEmpty) {
      results = videos;
    } else {
      results = videos.where((video) {
        final title = video['title']
            .toString()
            .toLowerCase();

        final creator = video['creator']
            .toString()
            .toLowerCase();

        final category = video['category']
            .toString()
            .toLowerCase();

        final query =
            searchQuery.toLowerCase();

        final matchesSearch =
            title.contains(query) ||
                creator.contains(query);

        final matchesCategory =
            selectedCategory == 'Semua' ||
                category ==
                    selectedCategory
                        .toLowerCase();

        return matchesSearch &&
            matchesCategory;
      }).toList();
    }

    setState(() {
      filteredVideos = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton:
          FloatingActionButton(
        backgroundColor:
            primaryGreen,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
      ),

      bottomNavigationBar:
          BottomNavBar(
        currentIndex: 2,
        onTap: (index) {},
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            100,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(
                          context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color:
                          primaryGreen,
                    ),
                  ),

                  const SizedBox(width: 6),

                  const Expanded(
                    child: Text(
                      'Video Panduan',
                      style: TextStyle(
                        fontFamily:
                            'Poppins',
                        fontSize: 28,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons
                          .notifications_none,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 54,
                      decoration:
                          BoxDecoration(
                        color:
                            const Color(
                          0xFFF5F7FA,
                        ),
                        borderRadius:
                            BorderRadius.circular(
                                18),
                      ),
                      child: TextField(
                        controller:
                            _searchController,
                        onChanged:
                            (value) {
                          searchQuery =
                              value;

                          _runFilter();
                        },
                        decoration:
                            const InputDecoration(
                          border:
                              InputBorder
                                  .none,
                          hintText:
                              'Cari video panduan...',
                          hintStyle:
                              TextStyle(
                            fontFamily:
                                'Poppins',
                          ),
                          prefixIcon:
                              Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Container(
                    height: 54,
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    decoration:
                        BoxDecoration(
                      color:
                          const Color(
                        0xFFF5F7FA,
                      ),
                      borderRadius:
                          BorderRadius.circular(
                              18),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.tune),
                        SizedBox(width: 8),
                        Text(
                          'Filter',
                          style:
                              TextStyle(
                            fontFamily:
                                'Poppins',
                            fontWeight:
                                FontWeight
                                    .w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(
                        20),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(
                          26),
                  color: const Color(
                    0xFFE8F5E9,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          const Text(
                            'Belajar mengelola\nsampah jadi lebih mudah\nbersama TrashBack!',
                            style:
                                TextStyle(
                              fontFamily:
                                  'Poppins',
                              fontSize:
                                  20,
                              fontWeight:
                                  FontWeight
                                      .bold,
                              height: 1.3,
                            ),
                          ),

                          const SizedBox(
                              height:
                                  12),

                          const Text(
                            'Video edukasi lengkap untuk\nhidup yang lebih bersih dan hijau.',
                            style:
                                TextStyle(
                              fontFamily:
                                  'Poppins',
                              color: Colors
                                  .black54,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(
                              height:
                                  18),

                          ElevatedButton(
                            onPressed:
                                () {},
                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  primaryGreen,
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                        14),
                              ),
                            ),
                            child:
                                const Text(
                              'Mulai Belajar',
                              style:
                                  TextStyle(
                                color: Colors
                                    .white,
                                fontFamily:
                                    'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                        width: 12),

                    const Icon(
                      Icons.recycling,
                      size: 90,
                      color:
                          primaryGreen,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection:
                      Axis.horizontal,
                  itemCount:
                      categories.length,
                  itemBuilder:
                      (context, index) {
                    final item =
                        categories[index];

                    final isSelected =
                        selectedCategory ==
                            item['title'];

                    return GestureDetector(
                      onTap: () {
                        selectedCategory =
                            item['title'];

                        _runFilter();
                      },
                      child: Container(
                        width: 92,
                        margin:
                            const EdgeInsets.only(
                                right:
                                    12),
                        child: Column(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration:
                                  BoxDecoration(
                                color:
                                    isSelected
                                        ? primaryGreen
                                        : const Color(
                                            0xFFF5F7FA),
                                shape:
                                    BoxShape
                                        .circle,
                              ),
                              child: Icon(
                                item[
                                    'icon'],
                                color:
                                    isSelected
                                        ? Colors
                                            .white
                                        : primaryGreen,
                              ),
                            ),

                            const SizedBox(
                                height:
                                    8),

                            Text(
                              item[
                                  'title'],
                              textAlign:
                                  TextAlign
                                      .center,
                              style:
                                  const TextStyle(
                                fontFamily:
                                    'Poppins',
                                fontSize:
                                    12,
                                fontWeight:
                                    FontWeight
                                        .w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: const [
                  Text(
                    'Video Terbaru',
                    style: TextStyle(
                      fontFamily:
                          'Poppins',
                      fontSize: 22,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),

                  Text(
                    'Lihat Semua',
                    style: TextStyle(
                      fontFamily:
                          'Poppins',
                      color:
                          primaryGreen,
                      fontWeight:
                          FontWeight
                              .w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              filteredVideos.isEmpty
                  ? const Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(
                          vertical: 40,
                        ),
                        child: Text(
                          'Video tidak ditemukan',
                          style:
                              TextStyle(
                            fontFamily:
                                'Poppins',
                            fontSize:
                                16,
                            fontWeight:
                                FontWeight
                                    .w500,
                            color: Colors
                                .grey,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          filteredVideos
                              .length,
                      shrinkWrap:
                          true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      itemBuilder:
                          (context,
                              index) {
                        final video =
                            filteredVideos[
                                index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) =>
                                        VideoDetailScreen(
                                  video:
                                      video,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin:
                                const EdgeInsets.only(
                                    bottom:
                                        22),
                            child: Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(
                                              18),
                                      child:
                                          Image.network(
                                        video[
                                            'thumbnail'],
                                        width:
                                            150,
                                        height:
                                            100,
                                        fit: BoxFit
                                            .cover,
                                      ),
                                    ),

                                    Positioned(
                                      right:
                                          8,
                                      bottom:
                                          8,
                                      child:
                                          Container(
                                        padding:
                                            const EdgeInsets.symmetric(
                                          horizontal:
                                              8,
                                          vertical:
                                              4,
                                        ),
                                        decoration:
                                            BoxDecoration(
                                          color:
                                              Colors.black87,
                                          borderRadius:
                                              BorderRadius.circular(
                                                  8),
                                        ),
                                        child:
                                            Text(
                                          video[
                                              'duration'],
                                          style:
                                              const TextStyle(
                                            color:
                                                Colors.white,
                                            fontSize:
                                                11,
                                            fontFamily:
                                                'Poppins',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                    width:
                                        14),

                                Expanded(
                                  child:
                                      Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Text(
                                        video[
                                            'title'],
                                        maxLines:
                                            3,
                                        overflow:
                                            TextOverflow.ellipsis,
                                        style:
                                            const TextStyle(
                                          fontFamily:
                                              'Poppins',
                                          fontSize:
                                              21,
                                          fontWeight:
                                              FontWeight.bold,
                                          height:
                                              1.3,
                                        ),
                                      ),

                                      const SizedBox(
                                          height:
                                              10),

                                      Row(
                                        children: [
                                          Text(
                                            video[
                                                'creator'],
                                            style:
                                                TextStyle(
                                              fontFamily:
                                                  'Poppins',
                                              fontSize:
                                                  13,
                                              color:
                                                  Colors.grey[700],
                                            ),
                                          ),

                                          const SizedBox(
                                              width:
                                                  6),

                                          const Icon(
                                            Icons
                                                .verified,
                                            size:
                                                16,
                                            color:
                                                primaryGreen,
                                          ),
                                        ],
                                      ),

                                      const SizedBox(
                                          height:
                                              6),

                                      Text(
                                        '${video['views']} • ${video['time']}',
                                        style:
                                            TextStyle(
                                          fontFamily:
                                              'Poppins',
                                          fontSize:
                                              12,
                                          color:
                                              Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Icon(
                                  Icons
                                      .more_vert,
                                  color:
                                      Colors
                                          .grey,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
