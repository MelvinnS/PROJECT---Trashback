import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  static const Color primaryGreen = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),

        title: Row(
          children: const [
            const CircleAvatar(
  backgroundImage: AssetImage(
    'assets/images/Earlene.png',
  ),
),

            SizedBox(width: 12),

            Text(
              "Earlene Zabrina",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),

      body: Column(
        children: [

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [

                _Bubble(
                  text: "Hallo, Ditunggu ya kak",
                  isMe: true,
                ),

                _Bubble(
                  text: "Oke mbud",
                  isMe: false,
                ),

                _Bubble(
                  text: "Saya sudah di depan rumah",
                  isMe: true,
                ),

                _Bubble(
                  text: "Sampahnya di depan pagar",
                  isMe: false,
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Message",
                      hintStyle: const TextStyle(fontFamily: 'Poppins'),
                      filled: true,
                      fillColor: const Color(0xFFF5F7FA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                const Icon(Icons.mic, color: Colors.grey),
                const SizedBox(width: 12),
                const Icon(Icons.attach_file, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final String text;
  final bool isMe;

  const _Bubble({
    required this.text,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          isMe ? Alignment.centerRight : Alignment.centerLeft,

      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(maxWidth: 260),

        decoration: BoxDecoration(
          color: isMe
              ? const Color(0xFF2E7D32)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),

        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: isMe ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}