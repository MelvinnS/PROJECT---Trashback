// =============================
// IMPORT
// =============================

import 'package:flutter/material.dart';

import '../models/article_model.dart';
import '../widgets/bottom_nav_bar.dart';
import 'article_detail_screen.dart';
import 'add_article_screen.dart';

// =============================
// SCREEN
// =============================

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() =>
      _ArticleScreenState();
}

class _ArticleScreenState
    extends State<ArticleScreen> {
  static const Color primaryGreen =
      Color(0xFF2E7D32);

  final TextEditingController
      _searchController =
      TextEditingController();

  String selectedCategory = 'Semua';

  final List<String> categories = [
    'Semua',
    'Tips & Edukasi',
    'Daur Ulang',
    'Lingkungan',
    'Kreativitas',
  ];

  late List<ArticleModel> articles;

  @override
  void initState() {
    super.initState();

    articles = [
      ArticleModel(
        id: '1',
        title:
            'Cara Mengurangi Sampah Plastik di Rumah',
        category:
            'Tips & Edukasi',
        thumbnail:
            'https://images.unsplash.com/photo-1497436072909-60f360e1d4b1?q=80&w=1200&auto=format&fit=crop',
        author: 'Eco Team',
        date: '14 Juni 2025',
        views: 2450,
        likesCount: 320,
        comments: 28,
      ),
      ArticleModel(
        id: '2',
        title:
            'Kreativitas Daur Ulang Botol Bekas',
        category: 'Kreativitas',
        thumbnail:
            'https://images.unsplash.com/photo-1520607162513-77705c0f0d4a?q=80&w=1200&auto=format&fit=crop',
        author: 'Melvin',
        date: '12 Juni 2025',
        views: 1890,
        likesCount: 210,
        comments: 15,
      ),
      ArticleModel(
        id: '3',
        title:
            'Pentingnya Memilah Sampah Organik',
        category: 'Lingkungan',
        thumbnail:
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=1200&auto=format&fit=crop',
        author: 'Eco Care',
        date: '10 Juni 2025',
        views: 3120,
        likesCount: 512,
        comments: 44,
      ),
      ArticleModel(
        id: '4',
        title:
            'Cara Mudah Daur Ulang Kardus Bekas',
        category: 'Daur Ulang',
        thumbnail:
            'https://images.unsplash.com/photo-1482192596544-9eb780fc7f66?q=80&w=1200&auto=format&fit=crop',
        author: 'Green Life',
        date: '8 Juni 2025',
        views: 980,
        likesCount: 120,
        comments: 9,
      ),
      ArticleModel(
        id: '5',
        title:
            'Eco Living untuk Anak Muda',
        category:
            'Tips & Edukasi',
        thumbnail:
            'https://images.unsplash.com/photo-1466611653911-95081537e5b7?q=80&w=1200&auto=format&fit=crop',
        author: 'Admin Eco',
        date: '7 Juni 2025',
        views: 1450,
        likesCount: 177,
        comments: 13,
      ),
    ];
  }

  List<ArticleModel>
      get filteredArticles {
    return articles.where((article) {
      final matchSearch = article
          .title
          .toLowerCase()
          .contains(
            _searchController.text
                .toLowerCase(),
          );

      final matchCategory =
          selectedCategory == 'Semua' ||
              article.category ==
                  selectedCategory;

      return matchSearch &&
          matchCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton:
          FloatingActionButton(
        backgroundColor:
            primaryGreen,
        elevation: 3,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          final result =
              await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddArticleScreen(),
            ),
          );

          if (result != null &&
              result is ArticleModel) {
            setState(() {
              articles.insert(
                  0, result);
            });
          }
        },
      ),

      bottomNavigationBar:
          BottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 3) return;

          if (index == 0) {
            Navigator.pushNamed(
                context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(
                context,
                '/history');
          } else if (index == 2) {
            Navigator.pushNamed(
                context,
                '/profile');
          }
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(
            20,
            16,
            20,
            100,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              // =========================
              // TOP BAR
              // =========================

              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration:
                        BoxDecoration(
                      color:
                          const Color(
                              0xFFF5F7FA),
                      borderRadius:
                          BorderRadius.circular(
                              14),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(
                            context);
                      },
                      icon: const Icon(
                        Icons
                            .arrow_back,
                        color:
                            Colors.black,
                        size: 22,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  const Text(
                    'Artikel',
                    style: TextStyle(
                      fontFamily:
                          'Poppins',
                      fontSize: 32,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // =========================
              // SEARCH
              // =========================

              TextField(
                controller:
                    _searchController,
                onChanged: (_) {
                  setState(() {});
                },
                decoration:
                    InputDecoration(
                  hintText:
                      'Cari artikel...',
                  hintStyle:
                      TextStyle(
                    color:
                        Colors.grey[500],
                    fontFamily:
                        'Poppins',
                  ),
                  prefixIcon:
                      const Icon(
                    Icons.search,
                    color:
                        Colors.grey,
                  ),
                  filled: true,
                  fillColor:
                      const Color(
                    0xFFF5F7FA,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                            18),
                    borderSide:
                        BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // =========================
              // CATEGORY
              // =========================

              SizedBox(
                height: 42,
                child: ListView.builder(
                  scrollDirection:
                      Axis.horizontal,
                  itemCount:
                      categories.length,
                  itemBuilder:
                      (context, index) {
                    final category =
                        categories[index];

                    final isSelected =
                        selectedCategory ==
                            category;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory =
                              category;
                        });
                      },
                      child: AnimatedContainer(
                        duration:
                            const Duration(
                                milliseconds:
                                    250),
                        margin:
                            const EdgeInsets.only(
                                right: 12),
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        decoration:
                            BoxDecoration(
                          color: isSelected
                              ? primaryGreen
                              : const Color(
                                  0xFFF5F7FA),
                          borderRadius:
                              BorderRadius.circular(
                                  20),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            fontFamily:
                                'Poppins',
                            fontWeight:
                                FontWeight.w600,
                            color: isSelected
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // =========================
              // BANNER
              // =========================

              if (filteredArticles
                  .isNotEmpty)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ArticleDetailScreen(
                          article:
                              filteredArticles[0],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width:
                        double.infinity,
                    height: 285,
                    decoration:
                        BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(
                              28),
                      image:
                          DecorationImage(
                        image: NetworkImage(
                          filteredArticles[0]
                              .thumbnail,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      padding:
                          const EdgeInsets.all(
                              24),
                      decoration:
                          BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(
                                28),
                        gradient:
                            LinearGradient(
                          begin:
                              Alignment.topCenter,
                          end: Alignment
                              .bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black
                                .withOpacity(
                                    0.82),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.end,
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration:
                                BoxDecoration(
                              color:
                                  primaryGreen,
                              borderRadius:
                                  BorderRadius.circular(
                                      20),
                            ),
                            child: Text(
                              filteredArticles[0]
                                  .category,
                              style:
                                  const TextStyle(
                                color:
                                    Colors.white,
                                fontFamily:
                                    'Poppins',
                                fontSize: 12,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(
                              height: 16),

                          Text(
                            filteredArticles[0]
                                .title,
                            style:
                                const TextStyle(
                              fontFamily:
                                  'Poppins',
                              fontSize: 25,
                              fontWeight:
                                  FontWeight.bold,
                              color:
                                  Colors.white,
                              height: 1.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 38),

              // =========================
              // SECTION TITLE
              // =========================

              const Text(
                'Artikel Terbaru',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 21,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              // =========================
              // ARTICLE LIST
              // =========================

              ListView.builder(
                itemCount:
                    filteredArticles.length,
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemBuilder:
                    (context, index) {
                  final article =
                      filteredArticles[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ArticleDetailScreen(
                            article:
                                article,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(
                              bottom: 26),
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [

                          // IMAGE

                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(
                                    20),
                            child:
                                Image.network(
                              article
                                  .thumbnail,
                              width: 122,
                              height: 122,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(
                              width: 16),

                          // CONTENT

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [

                                // CATEGORY

                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal:
                                        10,
                                    vertical: 5,
                                  ),
                                  decoration:
                                      BoxDecoration(
                                    color:
                                        const Color(
                                            0xFFDCEFD8),
                                    borderRadius:
                                        BorderRadius.circular(
                                            14),
                                  ),
                                  child: Text(
                                    article
                                        .category,
                                    style:
                                        const TextStyle(
                                      fontFamily:
                                          'Poppins',
                                      fontSize:
                                          11,
                                      fontWeight:
                                          FontWeight.w600,
                                      color:
                                          primaryGreen,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                    height:
                                        12),

                                // TITLE

                                Text(
                                  article.title,
                                  maxLines: 2,
                                  overflow:
                                      TextOverflow
                                          .ellipsis,
                                  style:
                                      const TextStyle(
                                    fontFamily:
                                        'Poppins',
                                    fontSize:
                                        19,
                                    fontWeight:
                                        FontWeight.bold,
                                    height:
                                        1.3,
                                  ),
                                ),

                                const SizedBox(
                                    height:
                                        10),

                                // AUTHOR

                                Text(
                                  'Oleh ${article.author} • ${article.date}',
                                  style:
                                      TextStyle(
                                    fontFamily:
                                        'Poppins',
                                    fontSize:
                                        12,
                                    color:
                                        Colors.grey[600],
                                    fontWeight:
                                        FontWeight.w400,
                                  ),
                                ),

                                const SizedBox(
                                    height:
                                        14),

                                // META

                                Row(
                                  children: [
                                    _metaItem(
                                      Icons
                                          .remove_red_eye_outlined,
                                      _formatNumber(
                                          article.views),
                                    ),

                                    const SizedBox(
                                        width:
                                            12),

                                    _metaItem(
                                      Icons
                                          .mode_comment_outlined,
                                      article
                                          .comments
                                          .toString(),
                                    ),

                                    const SizedBox(
                                        width:
                                            12),

                                    _metaItem(
                                      Icons
                                          .favorite_border,
                                      article
                                          .likesCount
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                              width: 8),

                          Padding(
                            padding:
                                const EdgeInsets.only(
                                    top: 4),
                            child: Icon(
                              Icons
                                  .bookmark_border,
                              color:
                                  Colors.grey[700],
                              size: 22,
                            ),
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

  Widget _metaItem(
    IconData icon,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.grey[600],
        ),

        const SizedBox(width: 5),

        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }

    return number.toString();
  }
}