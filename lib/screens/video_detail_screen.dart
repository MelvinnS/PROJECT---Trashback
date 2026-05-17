import 'package:flutter/material.dart';

class VideoDetailScreen extends StatefulWidget {
  final Map<String, dynamic> video;

  const VideoDetailScreen({
    super.key,
    required this.video,
  });

  @override
  State<VideoDetailScreen> createState() =>
      _VideoDetailScreenState();
}

class _VideoDetailScreenState
    extends State<VideoDetailScreen> {
  static const Color primaryGreen =
      Color(0xFF2E7D32);

  bool isFollowing = false;
  bool isLiked = false;

  int likes = 1200;

  final TextEditingController
      commentController =
      TextEditingController();

  final List<Map<String, dynamic>>
      comments = [
    {
      'name': 'Rizky Maulana',
      'comment':
          'Keren banget idenya! Jadi semangat pilah sampah 😍',
      'likes': 24,
      'time': '2 hari lalu',
    },
  ];

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;

      if (isLiked) {
        likes++;
      } else {
        likes--;
      }
    });
  }

  void sendComment() {
    if (commentController.text
        .trim()
        .isEmpty) {
      return;
    }

    setState(() {
      comments.insert(0, {
        'name': 'Anda',
        'comment':
            commentController.text,
        'likes': 0,
        'time': 'Baru saja',
      });
    });

    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.video;

    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding:
              const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color:
                    Colors.grey.shade200,
              ),
            ),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage:
                    NetworkImage(
                  'https://i.pravatar.cc/150?img=12',
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: TextField(
                  controller:
                      commentController,
                  decoration:
                      InputDecoration(
                    hintText:
                        'Tulis komentar...',
                    filled: true,
                    fillColor:
                        const Color(
                      0xFFF5F7FA,
                    ),
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                              30),
                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              GestureDetector(
                onTap: sendComment,
                child: Container(
                  width: 50,
                  height: 50,
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
              const EdgeInsets.only(
            bottom: 120,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    video['thumbnail'],
                    width:
                        double.infinity,
                    height: 320,
                    fit: BoxFit.cover,
                  ),

                  Container(
                    width:
                        double.infinity,
                    height: 320,
                    color:
                        Colors.black26,
                  ),

                  Positioned(
                    top: 20,
                    left: 16,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(
                            context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color:
                            Colors.white,
                      ),
                    ),
                  ),

                  const Positioned.fill(
                    child: Center(
                      child: Icon(
                        Icons.play_circle_fill,
                        size: 70,
                        color:
                            Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding:
                    const EdgeInsets.all(
                        20),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      video['title'],
                      style:
                          const TextStyle(
                        fontFamily:
                            'Poppins',
                        fontSize: 30,
                        fontWeight:
                            FontWeight.bold,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(
                        height: 18),

                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage:
                              NetworkImage(
                            'https://i.pravatar.cc/150?img=32',
                          ),
                        ),

                        const SizedBox(
                            width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: const [
                              Text(
                                'Budi Speed',
                                style:
                                    TextStyle(
                                  fontFamily:
                                      'Poppins',
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              SizedBox(
                                  height:
                                      2),

                              Text(
                                '66K subscribers',
                                style:
                                    TextStyle(
                                  fontFamily:
                                      'Poppins',
                                  color:
                                      Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isFollowing =
                                  !isFollowing;
                            });
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal:
                                  24,
                              vertical:
                                  12,
                            ),
                            decoration:
                                BoxDecoration(
                              color: isFollowing
                                  ? Colors
                                      .grey
                                  : primaryGreen,
                              borderRadius:
                                  BorderRadius.circular(
                                      14),
                            ),
                            child: Text(
                              isFollowing
                                  ? 'Diikuti'
                                  : 'Ikuti',
                              style:
                                  const TextStyle(
                                color:
                                    Colors.white,
                                fontFamily:
                                    'Poppins',
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                        height: 26),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        _actionButton(
                          isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          '$likes',
                          onTap:
                              toggleLike,
                        ),
                        _actionButton(
                          Icons
                              .thumb_down_alt_outlined,
                          '36',
                        ),
                        _actionButton(
                          Icons.share,
                          'Bagikan',
                        ),
                        _actionButton(
                          Icons.download,
                          'Unduh',
                        ),
                        _actionButton(
                          Icons.bookmark_border,
                          'Simpan',
                        ),
                      ],
                    ),

                    const SizedBox(
                        height: 24),

                    Container(
                      padding:
                          const EdgeInsets.all(
                              18),
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
                      child: const Text(
                        'Di video kali ini, Budi Speed akan berbagi tips dan trik mengelola sampah dengan cara yang cerdas, efisien, dan pastinya bermanfaat untuk lingkungan! 🌱',
                        style: TextStyle(
                          fontFamily:
                              'Poppins',
                          height: 1.7,
                        ),
                      ),
                    ),

                    const SizedBox(
                        height: 28),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: const [
                        Text(
                          'Komentar 128',
                          style: TextStyle(
                            fontFamily:
                                'Poppins',
                            fontSize: 22,
                            fontWeight:
                                FontWeight.bold,
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
                                FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                        height: 18),

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
                                  bottom:
                                      16),
                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    NetworkImage(
                                  'https://i.pravatar.cc/150?img=${index + 12}',
                                ),
                              ),

                              const SizedBox(
                                  width:
                                      12),

                              Expanded(
                                child:
                                    Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
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

                                        const SizedBox(
                                            width:
                                                8),

                                        Text(
                                          comment[
                                              'time'],
                                          style:
                                              TextStyle(
                                            fontFamily:
                                                'Poppins',
                                            color:
                                                Colors.grey[600],
                                            fontSize:
                                                12,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                        height:
                                            6),

                                    Text(
                                      comment[
                                          'comment'],
                                      style:
                                          const TextStyle(
                                        fontFamily:
                                            'Poppins',
                                        height:
                                            1.6,
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
                        );
                      },
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

  Widget _actionButton(
    IconData icon,
    String text, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.black87,
          ),

          const SizedBox(height: 6),

          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}