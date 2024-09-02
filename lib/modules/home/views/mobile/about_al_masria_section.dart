import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/app_colors.dart';

class AboutAlMasriaSection extends StatefulWidget {
  const AboutAlMasriaSection({super.key});

  @override
  _AboutAlMasriaSectionState createState() => _AboutAlMasriaSectionState();
}

class _AboutAlMasriaSectionState extends State<AboutAlMasriaSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Updated fetchImage method to accept a file name
  Future<http.Response> fetchImage(String fileName) async {
    final String url =
        'https://maroon-lyrebird-471853.hostingersite.com/files/images/get_this.php?path=$fileName';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Al Masria',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.notBlackAndWhiteColor(context),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Leading importer of recycling machines in Egypt since 2008, committed to quality and continuous improvement.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            // First image
            _buildImage('homepage_photo1.jpg'),
            const SizedBox(height: 16),
            // Second image with smaller height and rounded corners
            _buildImage('homepage_photo2.jpg'),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String fileName,
      {double? height, bool roundedCorners = true}) {
    return FutureBuilder<http.Response>(
      future: fetchImage(fileName),
      builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Icon(Icons.broken_image_outlined));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Icon(Icons.error_outlined));
        } else {
          // Decode the response body to get the image data
          final imageBytes = snapshot.data!.bodyBytes;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: roundedCorners
                    ? BorderRadius.circular(12.0)
                    : BorderRadius.zero,
                child: Image.memory(
                  imageBytes,
                  height: height,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return const Center(
                      child: Text('Failed to display image'),
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
