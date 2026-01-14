import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ============= THEME =============
class AppColors {
  static const primaryTeal = Color(0xFFDA2B28);
  static const accentCoral = Color(0xFFFF6F61);
  static const skyBlue = Color(0xFF00BCD4);
  static const backgroundLight = Color(0xFFF7F9FA);
  static const foregroundLight = Color(0xFF0F172A);
  static const backgroundDark = Color(0xFF0E1E25);
  static const foregroundDark = Color(0xFFE5EDF0);
  // aliases to keep existing references working
  static const background = backgroundLight;
  static const foreground = foregroundLight;
}

TextTheme buildTextTheme(Color baseColor) {
  return TextTheme(
    displayLarge: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: baseColor),
    displayMedium: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: baseColor),
    headlineMedium: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: baseColor),
    titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: baseColor),
    bodyLarge: GoogleFonts.nunito(fontWeight: FontWeight.w400, color: baseColor),
    bodyMedium: GoogleFonts.nunito(fontWeight: FontWeight.w400, color: baseColor.withOpacity(0.9)),
    labelLarge: GoogleFonts.nunito(fontWeight: FontWeight.w700, color: Colors.white),
  );
}

ThemeData buildLightTheme() {
  final scheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryTeal,
    onPrimary: Colors.white,
    secondary: AppColors.accentCoral,
    onSecondary: Colors.white,
    error: Colors.red.shade600,
    onError: Colors.white,
    background: AppColors.backgroundLight,
    onBackground: AppColors.foregroundLight,
    surface: Colors.white,
    onSurface: AppColors.foregroundLight,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.background,
    textTheme: buildTextTheme(scheme.onBackground),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: scheme.onBackground,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20, fontWeight: FontWeight.w600, color: scheme.onBackground,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white.withOpacity(0.75),
      elevation: 0,
      indicatorColor: AppColors.primaryTeal.withOpacity(0.16),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final sel = states.contains(WidgetState.selected);
        return GoogleFonts.nunito(
          fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
          color: sel ? AppColors.primaryTeal : scheme.onSurface.withOpacity(0.7),
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final sel = states.contains(WidgetState.selected);
        return IconThemeData(
          color: sel ? AppColors.primaryTeal : scheme.onSurface.withOpacity(0.7),
        );
      }),
    ),
    cardTheme: CardThemeData(
      color: scheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        textStyle: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: scheme.onSurface.withOpacity(0.08)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primaryTeal, width: 1.2),
      ),
    ),
  );
}

ThemeData buildDarkTheme() {
  final scheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.skyBlue,
    onPrimary: Colors.black,
    secondary: AppColors.accentCoral,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    background: AppColors.backgroundDark,
    onBackground: AppColors.foregroundDark,
    surface: Color(0xFF12242C),
    onSurface: AppColors.foregroundDark,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.background,
    textTheme: buildTextTheme(scheme.onBackground),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: AppColors.foregroundDark,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFF0F2027).withOpacity(0.65),
      indicatorColor: AppColors.skyBlue.withOpacity(0.18),
      labelTextStyle: WidgetStatePropertyAll(
        GoogleFonts.nunito(fontWeight: FontWeight.w700, color: AppColors.skyBlue),
      ),
      iconTheme: const WidgetStatePropertyAll(
        IconThemeData(color: AppColors.skyBlue),
      ),
    ),
    cardTheme: CardThemeData(
      color: scheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
  );
}

// ============= APP ENTRY =============
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SkinAidApp());
}

class SkinAidApp extends StatelessWidget {
  const SkinAidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkinAid',
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

// ============= SPLASH =============
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        _fadeTo(const LoginScreen()),
      );
    });
  }

  Route _fadeTo(Widget page) => PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xCCF0FBFD), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 160,
                  child: Lottie.asset('assets/lottie/splash-medical.json'),
                ),
                const SizedBox(height: 16),
                Text('SkinAid', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text(
                  'AI that cares for your skin.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============= AUTH (LOGIN / SIGNUP) =============
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(_fadeTo(const AppShell()));
  }

  Route _fadeTo(Widget page) => PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: Stack(children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFF1F0), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          right: -40,
          bottom: -30,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryTeal.withOpacity(0.06),
            ),
          ),
        ),
        Positioned(
          left: -30,
          top: -30,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.skyBlue.withOpacity(0.06),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Spacer(),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    TextField(
                      controller: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: passCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: loading ? null : _onLogin,
                        child: loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Continue'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Wire up Firebase Google Sign-In
                      },
                      icon: const Icon(Icons.g_mobiledata_rounded),
                      label: const Text('Sign in with Google'),
                    ),
                  ]),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to signup if you separate screens
                },
                child: const Text('New here? Create an account'),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

// ============= APP SHELL WITH BOTTOM NAV =============
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  final pages = const [
    HomeScreen(),
    UploadScreen(),
    ReportsScreen(),
    DoctorsScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bar = NavigationBar(
      selectedIndex: index,
      onDestinationSelected: (i) => setState(() => index = i),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.add_a_photo_outlined), selectedIcon: Icon(Icons.add_a_photo), label: 'Upload'),
        NavigationDestination(icon: Icon(Icons.assignment_outlined), selectedIcon: Icon(Icons.assignment), label: 'Reports'),
        NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map), label: 'Doctors'),
        NavigationDestination(icon: Icon(Icons.info_outline), selectedIcon: Icon(Icons.info), label: 'About'),
      ],
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Dermavision', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.person, size: 18, color: Colors.white),
            ),
          ),
        ],
      ),
      body: AnimatedSwitcher(duration: const Duration(milliseconds: 250), child: pages[index]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white.withOpacity(0.6)
                    : const Color(0xFF0F2027).withOpacity(0.6),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, -2)),
                ],
              ),
              child: bar,
            ),
          ),
        ),
      ),
    );
  }
}

// ============= HOME =============
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _animatedActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required int index,
    Color? color,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + index * 80),
      curve: Curves.easeOutCubic,
      builder: (context, v, child) {
        return Transform.translate(
          offset: Offset(0, (1 - v) * 16),
          child: Opacity(opacity: v, child: child),
        );
      },
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 14, offset: const Offset(0, 8)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [color ?? AppColors.primaryTeal, AppColors.skyBlue]),
                ),
                padding: const EdgeInsets.all(12),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                  )
                ]),
              ),
              const Icon(Icons.chevron_right),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.of(context).size.width > 380 ? 20.0 : 12.0;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: false,
          expandedHeight: 160,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFE5E4), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(children: [
                Positioned(
                  right: -40,
                  top: -30,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryTeal.withOpacity(0.08),
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  bottom: -20,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.skyBlue.withOpacity(0.08),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(pad),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Welcome back 👋', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Text(
                        'Smart Skin Care with AI',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            ),
                      ),
                    ]),
                  ),
                ),
              ]),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(pad, 16, pad, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _animatedActionCard(
                context: context,
                index: 0,
                icon: Icons.add_a_photo_outlined,
                title: 'Upload Image',
                subtitle: 'Detect skin conditions with AI',
                onTap: () => _go(context, const UploadScreen()),
                color: AppColors.primaryTeal,
              ),
              const SizedBox(height: 14),
              _animatedActionCard(
                context: context,
                index: 1,
                icon: Icons.map_outlined,
                title: 'Find Doctor',
                subtitle: 'Dermatologists near your location',
                onTap: () => _go(context, const DoctorsScreen()),
                color: AppColors.skyBlue,
              ),
              const SizedBox(height: 14),
              _animatedActionCard(
                context: context,
                index: 2,
                icon: Icons.assignment_outlined,
                title: 'Reports',
                subtitle: 'Review your past scan results',
                onTap: () => _go(context, const ReportsScreen()),
                color: AppColors.accentCoral,
              ),
              const SizedBox(height: 14),
              _animatedActionCard(
                context: context,
                index: 3,
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'Privacy, contacts, and disclaimer',
                onTap: () => _go(context, const AboutScreen()),
                color: AppColors.primaryTeal,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  void _go(BuildContext context, Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }
}

// ============= UPLOAD =============
class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool analyzing = false;
  ImageProvider? preview = const AssetImage('assets/images/sample-skin.jpg'); // placeholder

  Future<void> _pickFromCamera() async {
    // TODO: Use image_picker to capture image and set `preview`
    setState(() {
      preview = const AssetImage('assets/images/sample-skin.jpg');
    });
  }

  Future<void> _pickFromGallery() async {
    // TODO: Use image_picker to pick image and set `preview`
    setState(() {
      preview = const AssetImage('assets/images/sample-skin.jpg');
    });
  }

  Future<void> _analyze() async {
    setState(() => analyzing = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => analyzing = false);

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const ResultScreen(
          diseaseName: 'Eczema (Atopic Dermatitis)',
          confidence: 0.84,
        ),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonRow = Row(children: [
      Expanded(child: OutlinedButton.icon(onPressed: analyzing ? null : _pickFromCamera, icon: const Icon(Icons.photo_camera_outlined), label: const Text('Camera'))),
      const SizedBox(width: 10),
      Expanded(child: OutlinedButton.icon(onPressed: analyzing ? null : _pickFromGallery, icon: const Icon(Icons.photo_library_outlined), label: const Text('Gallery'))),
    ]);

    return Scaffold(
      body: Stack(children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFFEFFAF9), Colors.white], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    height: 230,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
                      image: preview != null ? DecorationImage(image: preview!, fit: BoxFit.cover) : null,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16)],
                    ),
                    child: preview == null ? Center(child: Text('No image selected', style: Theme.of(context).textTheme.bodyMedium)) : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              buttonRow,
              const SizedBox(height: 16),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.primaryTeal, AppColors.skyBlue]),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: AppColors.primaryTeal.withOpacity(0.4), blurRadius: 14, spreadRadius: 1)],
                ),
                child: FilledButton.icon(
                  onPressed: analyzing ? null : _analyze,
                  icon: const Icon(Icons.auto_awesome),
                  label: const Padding(padding: EdgeInsets.symmetric(vertical: 4), child: Text('Analyze with AI')),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (analyzing)
                Expanded(
                  child: Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(height: 140, child: Lottie.asset('assets/lottie/ai-analyze.json')),
                      const SizedBox(height: 8),
                      Text('Analyzing…', style: GoogleFonts.urbanist(fontWeight: FontWeight.w300, fontSize: 16)),
                    ]),
                  ),
                ),
            ]),
          ),
        ),
      ]),
    );
  }
}

// ============= RESULT =============
class ResultScreen extends StatelessWidget {
  final String diseaseName;
  final double confidence; // 0.0 to 1.0

  const ResultScreen({
    super.key,
    required this.diseaseName,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (confidence * 100).toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryTeal,
                  ),
                  child: const Icon(Icons.health_and_safety, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Detected condition',
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 4),
                        Text(diseaseName,
                            style: Theme.of(context).textTheme.titleLarge),
                      ]),
                ),
              ]),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text('Confidence',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 12),
                Center(child: AIConfidenceGauge(value: confidence)),
                const SizedBox(height: 8),
                Text(
                  '$percent%',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ]),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Short description',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Eczema is a chronic inflammatory skin condition characterized by itchy, dry, and inflamed patches. '
            'Early consultation helps prevent complications.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.foreground.withOpacity(0.8)),
          ),
          const Spacer(),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const DoctorsScreen(),
                  transitionsBuilder: (_, anim, __, child) =>
                      FadeTransition(opacity: anim, child: child),
                ),
              );
            },
            icon: const Icon(Icons.map_outlined),
            label: const Text('Find Nearby Doctor'),
          )
        ]),
      ),
    );
  }
}

// ============= AI CONFIDENCE GAUGE =============
class AIConfidenceGauge extends StatelessWidget {
  final double value; // 0.0..1.0
  const AIConfidenceGauge({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (context, v, _) {
        return SizedBox(
          width: 140,
          height: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: v,
                  strokeWidth: 10,
                  backgroundColor: AppColors.skyBlue.withOpacity(0.15),
                  valueColor: const AlwaysStoppedAnimation(AppColors.primaryTeal),
                ),
              ),
              Icon(Icons.check_circle,
                  size: 28,
                  color: v > 0.8 ? AppColors.primaryTeal : AppColors.accentCoral),
            ],
          ),
        );
      },
    );
  }
}

// ============= DOCTORS (MAP + LIST) =============
class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  GoogleMapController? mapCtrl;
  bool showMap = true;

  final sampleMarkers = <Marker>{
    const Marker(
      markerId: MarkerId('d1'),
      position: LatLng(37.7749, -122.4194),
      infoWindow: InfoWindow(title: 'Dr. Alice Kim, MD', snippet: 'Dermatologist • 4.8★ • 1.2 km'),
    ),
    const Marker(
      markerId: MarkerId('d2'),
      position: LatLng(37.7849, -122.4094),
      infoWindow: InfoWindow(title: 'Dr. Omar Singh, MD', snippet: 'Dermatologist • 4.6★ • 2.1 km'),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dermatologists')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: true, icon: Icon(Icons.map_outlined), label: Text('Map')),
              ButtonSegment(value: false, icon: Icon(Icons.list_alt_outlined), label: Text('List')),
            ],
            selected: {showMap},
            onSelectionChanged: (s) => setState(() => showMap = s.first),
          ),
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) =>
                SlideTransition(position: Tween<Offset>(begin: const Offset(0.08, 0), end: Offset.zero).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)), child: FadeTransition(opacity: anim, child: child)),
            child: showMap
                ? ClipRRect(
                    key: const ValueKey('map'),
                    borderRadius: BorderRadius.circular(12),
                    child: GoogleMap(
                      initialCameraPosition: const CameraPosition(target: LatLng(37.7749, -122.4194), zoom: 12),
                      markers: sampleMarkers,
                      onMapCreated: (c) => mapCtrl = c,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                    ),
                  )
                : ListView.separated(
                    key: const ValueKey('list'),
                    padding: const EdgeInsets.all(12),
                    itemCount: 3,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final name = ['Dr. Alice Kim, MD', 'Dr. Omar Singh, MD', 'Dr. Priya Desai, MD'][i];
                      final rating = [4.8, 4.6, 4.7][i];
                      final distance = ['1.2 km', '2.1 km', '3.0 km'][i];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(backgroundColor: AppColors.primaryTeal, child: const Icon(Icons.medical_services, color: Colors.white)),
                          title: Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                          subtitle: Text('Dermatologist • $rating★ • $distance'),
                          trailing: Wrap(spacing: 8, children: [
                            IconButton(onPressed: () {}, icon: const Icon(Icons.call_outlined)),
                            IconButton(onPressed: () {}, icon: const Icon(Icons.chat_bubble_outline)),
                            IconButton(onPressed: () {}, icon: const Icon(Icons.directions_outlined)),
                          ]),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ]),
    );
  }
}

// ============= REPORTS =============
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sample = List.generate(6, (i) {
      final diseases = [
        'Eczema',
        'Psoriasis',
        'Acne',
        'Rosacea',
        'Melanocytic Nevus',
        'Contact Dermatitis'
      ];
      final conf = [0.82, 0.65, 0.91, 0.72, 0.88, 0.79][i];
      final date = DateTime.now().subtract(Duration(days: i * 3));
      return (diseases[i], conf, date);
    });

    return Scaffold(
      body: Stack(children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFFFFF6F6), Colors.white], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
        Positioned(
          right: -60,
          top: -50,
          child: Container(width: 200, height: 200, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryTeal.withOpacity(0.05))),
        ),
        ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: sample.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            final (name, conf, date) = sample[i];
            final percent = (conf * 100).toStringAsFixed(0);
            return Card(
              child: ListTile(
                title: Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                subtitle: Text('Confidence: $percent% • ${date.toLocal().toIso8601String().substring(0, 10)}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => ResultScreen(diseaseName: name, confidence: conf),
                      transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ]),
    );
  }
}

// ============= ABOUT =============
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final infoStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.foreground.withOpacity(0.8),
        );

    return Scaffold(
      body: Stack(children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFFFFF1F0), Colors.white], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
        Positioned(
          left: -40,
          bottom: -40,
          child: Container(width: 180, height: 180, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.skyBlue.withOpacity(0.06))),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('About SkinAid', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'SkinAid helps you detect potential skin conditions using AI and recommends nearby dermatologists.',
              style: infoStyle,
            ),
            const SizedBox(height: 16),
            Text('Data Privacy', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Your images and results are stored securely. We never share your data without consent.',
              style: infoStyle,
            ),
            const SizedBox(height: 16),
            Text('Contact', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('support@skinaid.app', style: infoStyle),
            const SizedBox(height: 16),
            Text('Disclaimer', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'The app is not a substitute for professional medical advice. '
              'Consult a dermatologist for diagnosis and treatment.',
              style: infoStyle,
            ),
          ]),
        ),
      ]),
    );
  }
}