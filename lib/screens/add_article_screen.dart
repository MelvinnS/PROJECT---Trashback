import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import 'article_screen.dart';
import '../models/article_model.dart';



class AddArticleScreen extends StatefulWidget {
  const AddArticleScreen({super.key});

  @override
  State<AddArticleScreen> createState() =>
      _AddArticleScreenState();
}

class _AddArticleScreenState
    extends State<AddArticleScreen> {
  static const Color primaryGreen =
      Color(0xFF2E7D32);

  int currentStep = 0;

  final titleController =
      TextEditingController();

  final contentController =
      TextEditingController();

  String selectedCategory =
      'Tips & Edukasi';

  File? selectedImage;

  final List<String> categories = [
    'Tips & Edukasi',
    'Daur Ulang',
    'Lingkungan',
    'Kreativitas',
  ];

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final image =
        await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        selectedImage =
            File(image.path);
      });
    }
  }

  void nextStep() {
    if (currentStep == 0) {
      if (titleController.text
          .trim()
          .isEmpty) {
        showSnack(
            'Judul artikel wajib diisi');
        return;
      }

      if (selectedImage == null) {
        showSnack(
            'Thumbnail wajib dipilih');
        return;
      }
    }

    if (currentStep == 1) {
      if (contentController.text
          .trim()
          .isEmpty) {
        showSnack(
            'Konten artikel wajib diisi');
        return;
      }
    }

    setState(() {
      currentStep++;
    });
  }

  void prevStep() {
    setState(() {
      currentStep--;
    });
  }

  void showSnack(String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  void publishArticle() {
    final article = ArticleModel(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      title:
          titleController.text,
      category:
          selectedCategory,
      thumbnail:
          selectedImage!.path,
      author: 'Anda',
      date: 'Hari Ini',
      views: 0,
      likesCount: 0,
      comments: 0,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            PublishSuccessScreen(
          article: article,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons
                .arrow_back_ios_new,
            color: primaryGreen,
          ),
        ),
        title: const Text(
          'Buat Artikel Baru',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight:
                FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
                height: 12),

            _buildStepper(),

            Expanded(
              child:
                  SingleChildScrollView(
                padding:
                    const EdgeInsets.all(
                        20),
                child: Column(
                  children: [
                    if (currentStep ==
                        0)
                      _buildStep1(),

                    if (currentStep ==
                        1)
                      _buildStep2(),

                    if (currentStep ==
                        2)
                      _buildStep3(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper() {
    Widget item(
      int index,
      String text,
    ) {
      final active =
          currentStep >= index;

      return Expanded(
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration:
                  BoxDecoration(
                shape:
                    BoxShape.circle,
                color: active
                    ? primaryGreen
                    : Colors.white,
                border: Border.all(
                  color:
                      primaryGreen,
                ),
              ),
              alignment:
                  Alignment.center,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontFamily:
                      'Poppins',
                  fontWeight:
                      FontWeight.bold,
                  color: active
                      ? Colors.white
                      : primaryGreen,
                ),
              ),
            ),

            const SizedBox(
                width: 8),

            Expanded(
              child: Container(
                height: 2,
                color: index != 2
                    ? currentStep >
                            index
                        ? primaryGreen
                        : Colors
                            .grey
                            .shade300
                    : Colors
                        .transparent,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        children: [
          item(0,
              'Info Dasar'),
          item(1,
              'Isi Konten'),
          item(2,
              'Pratinjau'),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment
              .start,
      children: [
        const SizedBox(
            height: 24),

        const Text(
          'Judul Artikel',
          style: TextStyle(
            fontFamily:
                'Poppins',
            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(
            height: 10),

        TextField(
          controller:
              titleController,
          decoration:
              InputDecoration(
            hintText:
                'Masukkan judul artikel',
            border:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                      14),
            ),
          ),
        ),

        const SizedBox(
            height: 22),

        const Text(
          'Kategori',
          style: TextStyle(
            fontFamily:
                'Poppins',
            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(
            height: 10),

        DropdownButtonFormField(
          value:
              selectedCategory,
          items: categories
              .map(
                (e) =>
                    DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: (v) {
            setState(() {
              selectedCategory =
                  v!;
            });
          },
          decoration:
              InputDecoration(
            border:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                      14),
            ),
          ),
        ),

        const SizedBox(
            height: 24),

        const Text(
          'Thumbnail Artikel',
          style: TextStyle(
            fontFamily:
                'Poppins',
            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(
            height: 12),

        GestureDetector(
          onTap: pickImage,
          child: Container(
            width:
                double.infinity,
            height: 220,
            decoration:
                BoxDecoration(
              borderRadius:
                  BorderRadius.circular(
                      20),
              border: Border.all(
                color: Colors
                    .grey
                    .shade300,
              ),
            ),
            child: selectedImage ==
                    null
                ? Column(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                    children: const [
                      Icon(
                        Icons.image,
                        size: 52,
                        color:
                            primaryGreen,
                      ),
                      SizedBox(
                          height:
                              12),
                      Text(
                        'Upload Thumbnail',
                        style:
                            TextStyle(
                          fontFamily:
                              'Poppins',
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : ClipRRect(
                    borderRadius:
                        BorderRadius.circular(
                            20),
                    child:
                        Image.file(
                      selectedImage!,
                      fit:
                          BoxFit.cover,
                    ),
                  ),
          ),
        ),

        const SizedBox(
            height: 36),

        SizedBox(
          width:
              double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed:
                nextStep,
            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  primaryGreen,
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                        16),
              ),
            ),
            child: const Text(
              'Selanjutnya',
              style: TextStyle(
                fontFamily:
                    'Poppins',
                color:
                    Colors.white,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment
              .start,
      children: [
        const SizedBox(
            height: 24),

        const Text(
          'Isi Konten Artikel',
          style: TextStyle(
            fontFamily:
                'Poppins',
            fontWeight:
                FontWeight.bold,
            fontSize: 18,
          ),
        ),

        const SizedBox(
            height: 14),

        TextField(
          controller:
              contentController,
          maxLines: 18,
          decoration:
              InputDecoration(
            hintText:
                'Tulis artikelmu di sini...',
            alignLabelWithHint:
                true,
            border:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                      18),
            ),
          ),
        ),

        const SizedBox(
            height: 32),

        Row(
          children: [
            Expanded(
              child:
                  OutlinedButton(
                onPressed:
                    prevStep,
                style:
                    OutlinedButton.styleFrom(
                  minimumSize:
                      const Size(
                          0,
                          56),
                  side:
                      const BorderSide(
                    color:
                        primaryGreen,
                  ),
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            16),
                  ),
                ),
                child: const Text(
                  'Kembali',
                  style:
                      TextStyle(
                    fontFamily:
                        'Poppins',
                    color:
                        primaryGreen,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(
                width: 16),

            Expanded(
              child:
                  ElevatedButton(
                onPressed:
                    nextStep,
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      primaryGreen,
                  minimumSize:
                      const Size(
                          0,
                          56),
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            16),
                  ),
                ),
                child: const Text(
                  'Selanjutnya',
                  style:
                      TextStyle(
                    fontFamily:
                        'Poppins',
                    color:
                        Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment
              .start,
      children: [
        const SizedBox(
            height: 24),

        ClipRRect(
          borderRadius:
              BorderRadius.circular(
                  24),
          child: Image.file(
            selectedImage!,
            width:
                double.infinity,
            height: 260,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(
            height: 18),

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration:
              BoxDecoration(
            color:
                const Color(
              0xFFDCEFD8,
            ),
            borderRadius:
                BorderRadius.circular(
                    20),
          ),
          child: Text(
            selectedCategory,
            style:
                const TextStyle(
              color:
                  primaryGreen,
              fontFamily:
                  'Poppins',
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(
            height: 18),

        Text(
          titleController.text,
          style: const TextStyle(
            fontFamily:
                'Poppins',
            fontSize: 32,
            fontWeight:
                FontWeight.bold,
            height: 1.2,
          ),
        ),

        const SizedBox(
            height: 14),

        const Text(
          'Oleh Anda • Hari Ini',
          style: TextStyle(
            fontFamily:
                'Poppins',
            color: Colors.grey,
          ),
        ),

        const SizedBox(
            height: 22),

        Text(
          contentController.text,
          style: const TextStyle(
            fontFamily:
                'Poppins',
            fontSize: 16,
            height: 1.8,
          ),
        ),

        const SizedBox(
            height: 40),

        Row(
          children: [
            Expanded(
              child:
                  OutlinedButton(
                onPressed:
                    prevStep,
                style:
                    OutlinedButton.styleFrom(
                  minimumSize:
                      const Size(
                          0,
                          56),
                  side:
                      const BorderSide(
                    color:
                        primaryGreen,
                  ),
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            16),
                  ),
                ),
                child: const Text(
                  'Edit Kembali',
                  style:
                      TextStyle(
                    fontFamily:
                        'Poppins',
                    color:
                        primaryGreen,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(
                width: 16),

            Expanded(
              child:
                  ElevatedButton(
                onPressed:
                    publishArticle,
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      primaryGreen,
                  minimumSize:
                      const Size(
                          0,
                          56),
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            16),
                  ),
                ),
                child: const Text(
                  'Kirim Artikel',
                  style:
                      TextStyle(
                    fontFamily:
                        'Poppins',
                    color:
                        Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PublishSuccessScreen
    extends StatelessWidget {
  final ArticleModel article;

  const PublishSuccessScreen({
    super.key,
    required this.article,
  });

  static const Color primaryGreen =
      Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(
                  24),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment
                    .center,
            children: [
              Container(
                width: 180,
                height: 180,
                decoration:
                    BoxDecoration(
                  color:
                      const Color(
                    0xFFE8F5E9,
                  ),
                  shape:
                      BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color:
                      primaryGreen,
                  size: 90,
                ),
              ),

              const SizedBox(
                  height: 34),

              const Text(
                'Artikel Dipublikasikan!',
                textAlign:
                    TextAlign.center,
                style: TextStyle(
                  fontFamily:
                      'Poppins',
                  fontSize: 30,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                  height: 14),

              const Text(
                'Artikelmu telah berhasil dipublikasikan dan dapat dibaca oleh semua pengguna.',
                textAlign:
                    TextAlign.center,
                style: TextStyle(
                  fontFamily:
                      'Poppins',
                  fontSize: 16,
                  color:
                      Colors.grey,
                  height: 1.7,
                ),
              ),

              const SizedBox(
                  height: 36),

              Container(
                padding:
                    const EdgeInsets.all(
                        18),
                decoration:
                    BoxDecoration(
                  border: Border.all(
                    color: Colors
                        .grey
                        .shade300,
                  ),
                  borderRadius:
                      BorderRadius
                          .circular(
                              20),
                ),
                child: Column(
                  children: [
                    _item(
                        'Dilihat',
                        '245'),
                    const Divider(),
                    _item(
                        'Disukai',
                        '32'),
                    const Divider(),
                    _item(
                        'Komentar',
                        '8'),
                  ],
                ),
              ),

              const SizedBox(
                  height: 42),

              Row(
                children: [
                  Expanded(
                    child:
                        OutlinedButton(
                      onPressed:
                          () {
                        Navigator.pop(
                            context,
                            article);
                      },
                      style:
                          OutlinedButton.styleFrom(
                        minimumSize:
                            const Size(
                                0,
                                56),
                        side:
                            const BorderSide(
                          color:
                              primaryGreen,
                        ),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                                  16),
                        ),
                      ),
                      child:
                          const Text(
                        'Lihat Artikel',
                        style:
                            TextStyle(
                          fontFamily:
                              'Poppins',
                          color:
                              primaryGreen,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                      width: 16),

                  Expanded(
                    child:
                        ElevatedButton(
                      onPressed:
                          () {
                        Navigator.pop(
                            context,
                            article);
                      },
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            primaryGreen,
                        minimumSize:
                            const Size(
                                0,
                                56),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                                  16),
                        ),
                      ),
                      child:
                          const Text(
                        'Selesai',
                        style:
                            TextStyle(
                          fontFamily:
                              'Poppins',
                          color:
                              Colors.white,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(
    String label,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
              vertical: 8),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily:
                  'Poppins',
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily:
                  'Poppins',
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}