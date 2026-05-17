import 'package:flutter/material.dart';
// import 'article_screen.dart';
// import 'add_article_screen.dart';
import '../models/article_model.dart';

class ArticleDetailScreen extends StatefulWidget {
  final ArticleModel article;

  const ArticleDetailScreen({
    super.key,
    required this.article,
  });

  @override
  State<ArticleDetailScreen> createState() =>
      _ArticleDetailScreenState();
}

class _ArticleDetailScreenState
    extends State<ArticleDetailScreen> {
  static const Color primaryGreen =
      Color(0xFF2E7D32);

  bool isLiked = false;
  bool isSaved = false;

  late int likesCount;

  final TextEditingController
      _commentController =
      TextEditingController();

  final List<Map<String, dynamic>>
      comments = [
    {
      'name': 'Rizky Maulana',
      'comment':
          'Artikel yang sangat bermanfaat! Saya jadi lebih semangat untuk mulai memilah sampah di rumah.',
      'time': '2 hari lalu',
      'likes': 24,
    },
    {
      'name': 'Siti Nur Aisyah',
      'comment':
          'Terima kasih infonya kak 🙌 sangat membantu!',
      'time': '1 hari lalu',
      'likes': 12,
    },
  ];

  @override
  void initState() {
    super.initState();
    likesCount = widget.article.likesCount;
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;

      if (isLiked) {
        likesCount++;
      } else {
        likesCount--;
      }
    });
  }

  void _sendComment() {
    if (_commentController.text
        .trim()
        .isEmpty) {
      return;
    }

    setState(() {
      comments.insert(0, {
        'name': 'Anda',
        'comment':
            _commentController.text.trim(),
        'time': 'Baru saja',
        'likes': 0,
      });
    });

    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;

    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding:
              const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundImage:
                    NetworkImage(
                  'https://i.pravatar.cc/150?img=12',
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color:
                        const Color(
                      0xFFF5F7FA),
                    borderRadius:
                        BorderRadius
                            .circular(
                                30),
                  ),
                  child: TextField(
                    controller:
                        _commentController,
                    decoration:
                        const InputDecoration(
                      border:
                          InputBorder
                              .none,
                      hintText:
                          'Tulis komentar...',
                      hintStyle:
                          TextStyle(
                        fontFamily:
                            'Poppins',
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(
                        horizontal:
                            18,
                        vertical:
                            14,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              GestureDetector(
                onTap: _sendComment,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration:
                      const BoxDecoration(
                    color:
                        primaryGreen,
                    shape:
                        BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.send,
                    color:
                        Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(
            20,
            10,
            20,
            120,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,
            children: [
              // =========================
              // APPBAR
              // =========================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                          context);
                    },
                    child: const Icon(
                      Icons
                          .arrow_back_ios_new,
                      color:
                          primaryGreen,
                    ),
                  ),

                  const Text(
                    'Artikel',
                    style: TextStyle(
                      fontFamily:
                          'Poppins',
                      fontSize: 20,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSaved =
                                !isSaved;
                          });
                        },
                        child: Icon(
                          isSaved
                              ? Icons
                                  .bookmark
                              : Icons
                                  .bookmark_border,
                          color:
                              primaryGreen,
                        ),
                      ),

                      const SizedBox(
                          width: 18),

                      const Icon(
                        Icons.share,
                        color:
                            primaryGreen,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // =========================
              // CATEGORY
              // =========================

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color:
                      const Color(
                    0xFFDCEFD8,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                          20),
                ),
                child: Text(
                  article.category,
                  style:
                      const TextStyle(
                    fontFamily:
                        'Poppins',
                    fontSize: 12,
                    fontWeight:
                        FontWeight
                            .w600,
                    color:
                        primaryGreen,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // =========================
              // TITLE
              // =========================

              Text(
                article.title,
                style: const TextStyle(
                  fontFamily:
                      'Poppins',
                  fontSize: 34,
                  fontWeight:
                      FontWeight.bold,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 18),

              // =========================
              // AUTHOR
              // =========================

              Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage:
                        NetworkImage(
                      'https://i.pravatar.cc/150?img=32',
                    ),
                  ),

                  const SizedBox(width: 12),

                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Row(
                        children: [
                          Text(
                            article.author,
                            style:
                                const TextStyle(
                              fontFamily:
                                  'Poppins',
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),

                          const SizedBox(
                              width:
                                  4),

                          const Icon(
                            Icons
                                .verified,
                            color:
                                primaryGreen,
                            size:
                                18,
                          ),
                        ],
                      ),

                      Text(
                        '${article.date} • 5 menit baca',
                        style:
                            const TextStyle(
                          fontFamily:
                              'Poppins',
                          color:
                              Colors
                                  .grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // =========================
              // IMAGE
              // =========================

              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius
                            .circular(
                                24),
                    child:
                        Image.network(
                      article.thumbnail,
                      width:
                          double.infinity,
                      height: 320,
                      fit:
                          BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal:
                            12,
                        vertical:
                            6,
                      ),
                      decoration:
                          BoxDecoration(
                        color: Colors
                            .black54,
                        borderRadius:
                            BorderRadius.circular(
                                20),
                      ),
                      child:
                          const Text(
                        '1/5',
                        style:
                            TextStyle(
                          color: Colors
                              .white,
                          fontFamily:
                              'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // =========================
              // STATS
              // =========================

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        Colors.grey
                            .shade300,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                          22),
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceEvenly,
                  children: [
                    _statItem(
                      Icons
                          .remove_red_eye_outlined,
                      _formatNumber(
                          article
                              .views),
                      'Dilihat',
                    ),

                    _divider(),

                    _statItem(
                      Icons
                          .mode_comment_outlined,
                      article.comments
                          .toString(),
                      'Komentar',
                    ),

                    _divider(),

                    GestureDetector(
                      onTap:
                          _toggleLike,
                      child: _statItem(
                        isLiked
                            ? Icons
                                .favorite
                            : Icons
                                .favorite_border,
                        likesCount
                            .toString(),
                        'Disukai',
                        color: isLiked
                            ? Colors.red
                            : Colors
                                .black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // =========================
              // CONTENT
              // =========================

              const Text(
                'Sampah plastik menjadi salah satu masalah lingkungan terbesar saat ini. Namun, kita bisa memulainya dari rumah dengan langkah-langkah kecil yang berdampak besar.',
                style: TextStyle(
                  fontFamily:
                      'Poppins',
                  fontSize: 17,
                  height: 1.8,
                ),
              ),

              const SizedBox(height: 26),

              const Text(
                'Mengapa penting mengelola sampah plastik?',
                style: TextStyle(
                  fontFamily:
                      'Poppins',
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              const Text(
                'Plastik membutuhkan waktu ratusan tahun untuk terurai dan dapat mencemari tanah, air, hingga laut. Dengan pengelolaan yang baik, kita dapat mengurangi dampak negatifnya sekaligus menjaga lingkungan tetap bersih.',
                style: TextStyle(
                  fontFamily:
                      'Poppins',
                  fontSize: 17,
                  height: 1.8,
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Langkah-langkah sederhana di rumah',
                style: TextStyle(
                  fontFamily:
                      'Poppins',
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              _stepItem(
                '1',
                'Pisahkan sampah plastik dari sampah lainnya.',
              ),

              _stepItem(
                '2',
                'Bersihkan plastik sebelum dibuang atau didaur ulang.',
              ),

              _stepItem(
                '3',
                'Gunakan kembali botol atau wadah plastik untuk keperluan lain.',
              ),

              _stepItem(
                '4',
                'Setorkan sampah ke bank sampah atau program daur ulang.',
              ),

              const SizedBox(height: 28),

              Container(
                padding:
                    const EdgeInsets.all(
                        18),
                decoration: BoxDecoration(
                  color:
                      const Color(
                    0xFFE8F5E9,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                          20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.eco,
                      color:
                          primaryGreen,
                    ),

                    SizedBox(width: 14),

                    Expanded(
                      child: Text(
                        'Dengan mengelola sampah plastik, kamu ikut berkontribusi untuk bumi yang lebih bersih dan sehat 🌱',
                        style:
                            TextStyle(
                          fontFamily:
                              'Poppins',
                          color:
                              primaryGreen,
                          height:
                              1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 34),

              // =========================
              // COMMENTS
              // =========================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: const [
                  Text(
                    'Komentar (128)',
                    style: TextStyle(
                      fontFamily:
                          'Poppins',
                      fontSize: 24,
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

              const SizedBox(height: 20),

              ListView.builder(
                itemCount:
                    comments.length,
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemBuilder:
                    (context, index) {
                  final comment =
                      comments[index];

                  return Container(
                    margin:
                        const EdgeInsets.only(
                            bottom: 18),
                    padding:
                        const EdgeInsets.all(
                            16),
                    decoration:
                        BoxDecoration(
                      border: Border.all(
                        color: Colors
                            .grey
                            .shade200,
                      ),
                      borderRadius:
                          BorderRadius
                              .circular(
                                  20),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage:
                                  NetworkImage(
                                'https://i.pravatar.cc/150?img=${index + 10}',
                              ),
                            ),

                            const SizedBox(
                                width:
                                    10),

                            Expanded(
                              child:
                                  Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment[
                                        'name'],
                                    style:
                                        const TextStyle(
                                      fontFamily:
                                          'Poppins',
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    comment[
                                        'time'],
                                    style:
                                        const TextStyle(
                                      fontFamily:
                                          'Poppins',
                                      color:
                                          Colors.grey,
                                      fontSize:
                                          12,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              children: [
                                const Icon(
                                  Icons
                                      .favorite_border,
                                  size:
                                      18,
                                  color:
                                      Colors.grey,
                                ),
                                const SizedBox(
                                    width:
                                        4),
                                Text(
                                  comment[
                                          'likes']
                                      .toString(),
                                  style:
                                      const TextStyle(
                                    fontFamily:
                                        'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(
                            height: 14),

                        Text(
                          comment[
                              'comment'],
                          style:
                              const TextStyle(
                            fontFamily:
                                'Poppins',
                            height: 1.7,
                          ),
                        ),

                        const SizedBox(
                            height: 12),

                        const Text(
                          'Balas',
                          style:
                              TextStyle(
                            fontFamily:
                                'Poppins',
                            color:
                                Colors
                                    .black54,
                          ),
                        ),
                      ],
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

  Widget _divider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.grey.shade300,
    );
  }

  Widget _statItem(
    IconData icon,
    String value,
    String label, {
    Color color = Colors.black,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 28,
        ),

        const SizedBox(height: 6),

        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight:
                FontWeight.bold,
            fontSize: 18,
          ),
        ),

        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _stepItem(
    String number,
    String text,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
              bottom: 16),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration:
                const BoxDecoration(
              color: primaryGreen,
              shape: BoxShape.circle,
            ),
            alignment:
                Alignment.center,
            child: Text(
              number,
              style:
                  const TextStyle(
                color: Colors.white,
                fontFamily:
                    'Poppins',
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(
                      top: 5),
              child: Text(
                text,
                style:
                    const TextStyle(
                  fontFamily:
                      'Poppins',
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }

    return number.toString();
  }
}