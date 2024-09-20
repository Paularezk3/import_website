import 'dart:html'; // For DivElement, document etc.
import 'dart:ui_web';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:import_website/core/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // For Android/iOS
import 'package:google_maps/google_maps.dart' as gmaps;
import 'package:web/src/dom/html.dart';

class OurLocationSection extends StatelessWidget {
  final bool isMobile;
  const OurLocationSection({required this.isMobile, super.key});

  @override
  Widget build(BuildContext context) {
    const LatLng location =
        LatLng(30.2364, 31.3593); // San Francisco coordinates
    GoogleMapController? mainController;

    // Function to open Google Maps when the marker is clicked
    Future<void> openGoogleMaps() async {
      final String googleMapsUrl =
          "https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}";
      if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
        await launchUrl(Uri.parse(googleMapsUrl));
      } else {
        throw 'Could not open Google Maps.';
      }
    }

    var googleMap = Column(
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 1),
          height: 300,
          width: MediaQuery.of(context).size.width < 750? (MediaQuery.of(context).size.width < 600 ? double.infinity : 400) : (MediaQuery.of(context).size.width > 1400 ? 800 : 500),
          child: kIsWeb
              ? _buildWebMap()
              : _buildMobileMap(openGoogleMaps, location, mainController),
        ),
        const SizedBox(height: 20),
        const Text(
          'This is a static map showing a specific location.\nTap the map to open Google Maps.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        )
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align Row content to the top
        children: [
          Expanded(
            // Ensure Column takes available width within Row
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the start
              children: [
                Text(
                  "Our Location",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 10),
                Text(
                  "Al Masria is located in Egypt, specializing in importing recycling plastic machines since 2008.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w200, color: AppColors.notBlackAndWhiteColor(context).withAlpha(200)),
                ),
                const SizedBox(height: 25),
                Text(
                  "Address",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "Abu Zaabal, Qalubya",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (isMobile) ...[
                  const SizedBox(height: 15),
                  googleMap,
                  const SizedBox(height: 200), // Dummy space to make scrollable
                ]
              ],
            ),
          ),
          if (!isMobile) ...[
            const SizedBox(width: 30),
            googleMap,// Dummy space to make scrollable
          ]
        ],
      ),
    );
  }

  // For Web: Use the google_maps package
  Widget _buildWebMap() {
    // Create map options for the Google Map
    final mapOptions = gmaps.MapOptions()
      ..zoom = 14
      ..draggable = true
      ..clickableIcons = false
      ..center = gmaps.LatLng(30.2364, 31.3593); // Set your location

    // Create a div element that will contain the map
    final mapDiv = DivElement()..style.height = '100%';

    // Create the Google Map inside the div element
    final map = gmaps.Map(mapDiv as HTMLElement, mapOptions);

    // Add a red marker (pin) to the map at the center location
    gmaps.Marker(gmaps.MarkerOptions()
      ..position = gmaps.LatLng(30.2364, 31.3593) // Same as the map center
      ..map = map
      ..title = 'My Location'
      ..icon = null); // Default red pin

    // Add a click listener to the map to open Google Maps in a new tab with the clicked location
    map.onClick.listen((gmaps.MapMouseEventOrIconMouseEvent e) {
      final clickedLatLng = e.latLng;
      if (clickedLatLng != null) {
        final lat = clickedLatLng.lat;
        final lng = clickedLatLng.lng;
        final googleMapsUrl = 'https://www.google.com/maps?q=$lat,$lng';
        _launchURL(googleMapsUrl); // Open the URL in a new tab
      }
    });

    // Register the div element as a platform view
    platformViewRegistry.registerViewFactory('map-element', (int viewId) {
      return mapDiv;
    });

    // Return the HtmlElementView widget to display the map in the Flutter app
    return const HtmlElementView(viewType: 'map-element');
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  // For Mobile: Use google_maps_flutter package
  Widget _buildMobileMap(Future<void> Function() openGoogleMaps,
      LatLng location, GoogleMapController? mainController) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: location,
        zoom: 14.0,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('targetLocation'),
          position: location,
          onTap: openGoogleMaps, // Opens Google Maps when tapped
        ),
      },
      onMapCreated: (GoogleMapController controller) {
        mainController = controller;
      },
      onTap: (LatLng latLng) {
        openGoogleMaps(); // Opens Google Maps when the map is tapped
      },
    );
  }
}
