import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ============= THEME =============
class AppColors {
  // Enhanced modern medical color palette
  // Primary red theme
  static const primaryTeal = Color(0xFFE53935); // now primary red
  static const primaryDark = Color(0xFFB71C1C);
  static const accentCoral = Color(0xFFFF6B81);
  static const accentOrange = Color(0xFFFFB347);
  static const skyBlue = Color(0xFF4FC3F7);
  static const purpleAccent = Color(0xFF9C89F5);
  static const lavender = Color(0xFFB8A4F5);
  static const mintGreen = Color(0xFF7FFFD4);
  static const peach = Color(0xFFFFDAB9);
  static const backgroundLight = Color(0xFFF5F8FF);
  static const foregroundLight = Color(0xFF1A1F36);
  static const backgroundDark = Color(0xFF0E1318);
  static const foregroundDark = Color(0xFFE8ECF0);
  static const cardLight = Color(0xFFFFFFFF);
  static const cardDark = Color(0xFF1A2028);
  // Gradient colors
  static const gradientStart = Color(0xFFE53935);
  static const gradientMid = Color(0xFFFF7043);
  static const gradientEnd = Color(0xFFFFC107);
  // aliases to keep existing references working
  static const background = backgroundLight;
  static const foreground = foregroundLight;
}

class AppRadii {
  static const r12 = Radius.circular(12);
  static const r16 = Radius.circular(16);
  static const r20 = Radius.circular(20);
  static const r24 = Radius.circular(24);
}

class AppShadows {
  static List<BoxShadow> soft(ColorScheme scheme) => [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 18,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: scheme.primary.withOpacity(0.08),
          blurRadius: 22,
          offset: const Offset(0, 16),
        ),
      ];
}

class AppGradients {
  static const hero = LinearGradient(
    colors: [AppColors.gradientStart, AppColors.gradientMid, AppColors.gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const softBg = LinearGradient(
    colors: [Color(0xFFF3FBFF), Color(0xFFFDF7FF), Colors.white],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient tint(ColorScheme scheme) => LinearGradient(
        colors: [
          scheme.primary.withOpacity(0.10),
          scheme.secondary.withOpacity(0.08),
          scheme.primary.withOpacity(0.04),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}

class GradientScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool extendBodyBehindAppBar;

  const GradientScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.extendBodyBehindAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(decoration: BoxDecoration(gradient: AppGradients.softBg)),
          DecoratedBox(decoration: BoxDecoration(gradient: AppGradients.tint(scheme))),
          Positioned(
            right: -80,
            top: -60,
            child: _Blob(color: scheme.primary.withOpacity(0.14), size: 220),
          ),
          Positioned(
            left: -60,
            bottom: -80,
            child: _Blob(color: scheme.secondary.withOpacity(0.10), size: 240),
          ),
          SafeArea(bottom: false, child: body),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  final Color color;
  final double size;
  const _Blob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class _HomeIconChip extends StatelessWidget {
  final IconData icon;
  const _HomeIconChip({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppGradients.hero,
      ),
      child: Icon(icon, size: 18, color: Colors.white),
    );
  }
}

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final BorderRadius borderRadius;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(AppRadii.r20),
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? scheme.surface.withOpacity(0.62) : Colors.white.withOpacity(0.62);
    final border = isDark ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.75);

    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: borderRadius,
            border: Border.all(color: border, width: 1),
            boxShadow: AppShadows.soft(scheme),
          ),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
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
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.primaryTeal,
    brightness: Brightness.light,
    primary: AppColors.primaryTeal,
    secondary: AppColors.accentCoral,
    surface: Colors.white,
    error: Colors.red.shade600,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    textTheme: buildTextTheme(AppColors.foregroundLight),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: scheme.onSurface,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20, fontWeight: FontWeight.w600, color: scheme.onSurface,
      ),
    ),
    dividerTheme: DividerThemeData(color: scheme.onSurface.withOpacity(0.08), space: 1),
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
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: scheme.onSurface,
        side: BorderSide(color: scheme.onSurface.withOpacity(0.12)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        textStyle: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: scheme.primary,
        textStyle: GoogleFonts.nunito(fontWeight: FontWeight.w800),
      ),
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
      fillColor: Colors.white.withOpacity(0.85),
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
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.skyBlue,
    brightness: Brightness.dark,
    primary: AppColors.skyBlue,
    secondary: AppColors.accentCoral,
    surface: const Color(0xFF12242C),
    error: Colors.red,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    textTheme: buildTextTheme(AppColors.foregroundDark),
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
      if (!mounted) return;
      Navigator.of(context).pushReplacement(_fadeTo(const LoginScreen()));
    });
  }

  Route _fadeTo(Widget page) => PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      );

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 170,
                child: Lottie.asset(
                  'assets/lottie/splash-medical.json',
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 140,
                      height: 140,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppGradients.hero,
                      ),
                      child: const Icon(Icons.health_and_safety, color: Colors.white, size: 72),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              ShaderMask(
                shaderCallback: (rect) => AppGradients.hero.createShader(rect),
                child: Text(
                  'Dermavision',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'AI-powered skin insights, beautifully delivered.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.72),
                    ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 6,
                    backgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.08),
                    valueColor: const AlwaysStoppedAnimation(AppColors.primaryTeal),
                  ),
                ),
              ),
            ],
          ),
        ),
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
    final nav = Navigator.of(context);
    nav.pushReplacement(_fadeTo(const AppShell()));
  }

  Route _fadeTo(Widget page) => PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      );

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GradientScaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Sign in'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Welcome',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sign in to continue your skin journey.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: scheme.onSurface.withOpacity(0.72)),
              ),
            ),
            const SizedBox(height: 18),
            GlassCard(
              child: Column(
                children: [
                  TextField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.mail_outline),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: passCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: AppGradients.hero,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryTeal.withOpacity(0.32),
                            blurRadius: 18,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      child: FilledButton(
                        onPressed: loading ? null : _onLogin,
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                        ),
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
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Wire up Firebase Google Sign-In
                    },
                    icon: const Icon(Icons.g_mobiledata_rounded),
                    label: const Text('Sign in with Google'),
                  ),
                ],
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                // TODO: Navigate to signup if you separate screens
              },
              child: const Text('New here? Create an account'),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
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
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.75),
                Colors.white.withOpacity(0.55),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: Colors.white.withOpacity(0.55), width: 1),
            boxShadow: AppShadows.soft(Theme.of(context).colorScheme),
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
    return GradientScaffold(
      body: CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: false,
          expandedHeight: 160,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0x00FFFFFF), Color(0x00FFFFFF)],
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) => AppGradients.hero.createShader(rect),
                          child: Text(
                            'Welcome back',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Smart skin care with AI.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                              ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            _HomeIconChip(icon: Icons.spa),
                            SizedBox(width: 8),
                            _HomeIconChip(icon: Icons.water_drop),
                            SizedBox(width: 8),
                            _HomeIconChip(icon: Icons.shield_rounded),
                          ],
                        ),
                      ],
                    ),
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
    ),
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
  ImageProvider? preview; // set after user picks an image

  Future<void> _pickFromCamera() async {
    // TODO: Use image_picker to capture image and set `preview`
    setState(() {
      preview = null;
    });
  }

  Future<void> _pickFromGallery() async {
    // TODO: Use image_picker to pick image and set `preview`
    setState(() {
      preview = null;
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
          diseaseName: 'Eczema',
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

    return GradientScaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('Upload a photo', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(
            'Choose a clear image for best results.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
          ),
          const SizedBox(height: 14),
          GlassCard(
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(AppRadii.r20),
              child: Container(
                height: 240,
                decoration: BoxDecoration(
                  image: preview != null ? DecorationImage(image: preview!, fit: BoxFit.cover) : null,
                ),
                child: preview == null
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppGradients.hero,
                              ),
                              child: const Icon(Icons.add_a_photo_outlined, color: Colors.white, size: 34),
                            ),
                            const SizedBox(height: 10),
                            Text('No image selected', style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      )
                    : Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                color: Colors.black.withOpacity(0.28),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.auto_awesome, color: Colors.white, size: 18),
                                    SizedBox(width: 8),
                                    Text('Ready to analyze', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          buttonRow,
          const SizedBox(height: 16),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: AppGradients.hero,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: AppColors.primaryTeal.withOpacity(0.35), blurRadius: 18, offset: const Offset(0, 10))],
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
          const SizedBox(height: 18),
          if (analyzing)
            Expanded(
              child: Center(
                child: GlassCard(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(
                      height: 140,
                      child: Lottie.asset(
                        'assets/lottie/ai-analyze.json',
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: SizedBox(
                              width: 44,
                              height: 44,
                              child: CircularProgressIndicator(strokeWidth: 4),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Analyzing…', style: GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 16)),
                  ]),
                ),
              ),
            ),
        ]),
      ),
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

    return GradientScaffold(
      appBar: AppBar(title: const Text('Result')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          GlassCard(
            child: Row(children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppGradients.hero,
                ),
                child: const Icon(Icons.health_and_safety, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Detected condition', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 4),
                  Text(diseaseName, style: Theme.of(context).textTheme.titleLarge),
                ]),
              ),
            ]),
          ),
          const SizedBox(height: 14),
          GlassCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text('AI Confidence', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),
              Center(child: AIConfidenceGauge(value: confidence)),
              const SizedBox(height: 10),
              ShaderMask(
                shaderCallback: (rect) => AppGradients.hero.createShader(rect),
                child: Text(
                  '$percent%',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 14),
          Text('What this can mean', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            _descriptionFor(diseaseName),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.78),
                ),
          ),
          const Spacer(),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: AppGradients.hero,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: AppColors.primaryTeal.withOpacity(0.32), blurRadius: 18, offset: const Offset(0, 10))],
            ),
            child: FilledButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const DoctorsScreen(),
                    transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
                  ),
                );
              },
              icon: const Icon(Icons.map_outlined),
              label: const Text('Find Nearby Doctor'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

String _descriptionFor(String diseaseName) {
  final name = diseaseName.toLowerCase();
  if (name.contains('eczema')) {
    return 'Eczema is an inflammatory skin condition that can cause dry, itchy and red patches. '
        'Keeping the skin moisturised and avoiding known irritants can help reduce flares.';
  } else if (name.contains('chicken') || name.contains('pox')) {
    return 'Chicken pox is a viral infection that causes an itchy, blister-like rash and small, red spots. '
        'It usually resolves on its own, but you should see a doctor if you have fever, spreading pain, or breathing issues.';
  } else if (name.contains('wart')) {
    return 'Warts are small, rough growths on the skin caused by human papillomavirus (HPV). '
        'They are usually harmless, but treatment by a dermatologist can help them clear faster.';
  } else if (name.contains('acne')) {
    return 'Acne is a common condition where pores become blocked with oil and dead skin cells, leading to pimples and bumps. '
        'Gentle cleansing and early treatment can help reduce scarring and dark marks.';
  }
  return 'This description is for educational purposes only. Please consult a dermatologist for diagnosis and treatment that is specific to you.';
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
  bool showMap = false; // start with list to avoid map-related crashes on misconfigured devices

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
    return GradientScaffold(
      appBar: AppBar(title: const Text('Dermatologists')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: GlassCard(
            padding: const EdgeInsets.all(10),
            borderRadius: BorderRadius.circular(16),
            child: SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: true, icon: Icon(Icons.map_outlined), label: Text('Map')),
                ButtonSegment(value: false, icon: Icon(Icons.list_alt_outlined), label: Text('List')),
              ],
              selected: {showMap},
              onSelectionChanged: (s) => setState(() => showMap = s.first),
            ),
          ),
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) => SlideTransition(
              position: Tween<Offset>(begin: const Offset(0.08, 0), end: Offset.zero).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: showMap
                ? Padding(
                    key: const ValueKey('map'),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: GlassCard(
                      padding: EdgeInsets.zero,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(AppRadii.r20),
                        child: GoogleMap(
                          initialCameraPosition: const CameraPosition(target: LatLng(37.7749, -122.4194), zoom: 12),
                          markers: sampleMarkers,
                          onMapCreated: (c) => mapCtrl = c,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                        ),
                      ),
                    ),
                  )
                : ListView.separated(
                    key: const ValueKey('list'),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: 3,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final name = ['Dr. Alice Kim, MD', 'Dr. Omar Singh, MD', 'Dr. Priya Desai, MD'][i];
                      final rating = [4.8, 4.6, 4.7][i];
                      final distance = ['1.2 km', '2.1 km', '3.0 km'][i];
                      return GlassCard(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppGradients.hero),
                            child: const Icon(Icons.medical_services, color: Colors.white),
                          ),
                          title: Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                          subtitle: Text('Dermatologist • $rating★ • $distance'),
                          trailing: Wrap(spacing: 4, children: [
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
    final sample = [
      ('Eczema', 0.82, DateTime.now().subtract(const Duration(days: 1))),
      ('Chicken pox', 0.78, DateTime.now().subtract(const Duration(days: 4))),
      ('Warts', 0.74, DateTime.now().subtract(const Duration(days: 7))),
      ('Acne', 0.91, DateTime.now().subtract(const Duration(days: 10))),
    ];

    return GradientScaffold(
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        itemCount: sample.length + 1,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          if (i == 0) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(4, 6, 4, 8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Reports', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 6),
                Text(
                  'Your recent AI scans and confidence scores.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                ),
              ]),
            );
          }

          final (name, conf, date) = sample[i - 1];
          final percent = (conf * 100).toStringAsFixed(0);
          return GlassCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppGradients.hero),
                child: const Icon(Icons.assignment_outlined, color: Colors.white),
              ),
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

    return GradientScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('About', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 6),
          Text('Dermavision / SkinAid', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
          const SizedBox(height: 16),
          GlassCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('What it does', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                'SkinAid helps you detect potential skin conditions using AI and recommends nearby dermatologists.',
                style: infoStyle,
              ),
            ]),
          ),
          const SizedBox(height: 12),
          GlassCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Data Privacy', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                'Your images and results are stored securely. We never share your data without consent.',
                style: infoStyle,
              ),
            ]),
          ),
          const SizedBox(height: 12),
          GlassCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Contact', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text('support@skinaid.app', style: infoStyle),
            ]),
          ),
          const SizedBox(height: 12),
          GlassCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Disclaimer', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                'The app is not a substitute for professional medical advice. Consult a dermatologist for diagnosis and treatment.',
                style: infoStyle,
              ),
            ]),
          ),
          const SizedBox(height: 24),
        ]),
      ),
    );
  }
}