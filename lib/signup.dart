import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> 
    with TickerProviderStateMixin {  // Fixed: Removed SingleTickerProviderStateMixin conflict
  late AnimationController _mainController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Color?> _gradientAnimation;
  late Animation<Offset> _slideAnimation;

  // Additional controllers for field animations
  late AnimationController _fieldController;
  late Animation<double> _fieldScaleAnimation;
  late Animation<double> _fieldFadeAnimation;

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isPasswordFocused = false;
  bool _isEmailFocused = false;
  bool _isUsernameFocused = false;
  bool _isConfirmPasswordFocused = false;  // Fixed: Added missing focus state

  // For floating label animations
  late AnimationController _labelController;
  late Animation<double> _labelAnimation;

  @override
  void initState() {
    super.initState();

    // Main animations
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeIn),
      ),
    );

    _gradientAnimation = ColorTween(
      begin: Colors.deepPurple[400],
      end: Colors.indigo[900],
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    // Field animations
    _fieldController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fieldScaleAnimation = Tween<double>(begin: 0.98, end: 1.0).animate(
      CurvedAnimation(
        parent: _fieldController,
        curve: Curves.easeOutBack,
      ),
    );

    _fieldFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fieldController,
        curve: Curves.easeIn,
      ),
    );

    // Label animation
    _labelController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _labelAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _labelController,
        curve: Curves.easeInOut,
      ),
    );

    // Start animations with a slight delay
    Future.delayed(const Duration(milliseconds: 300), () {
      _mainController.forward();
      _fieldController.forward();
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _fieldController.dispose();
    _labelController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulate network request with animated loading
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        setState(() => _isLoading = false);
        // Navigate to home on success
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    }
  }

  void _onFieldFocusChange(bool hasFocus, String fieldType) {
    setState(() {
      switch (fieldType) {
        case 'username':
          _isUsernameFocused = hasFocus;
          break;
        case 'email':
          _isEmailFocused = hasFocus;
          break;
        case 'password':
          _isPasswordFocused = hasFocus;
          break;
        case 'confirmPassword':  // Fixed: Added missing case
          _isConfirmPasswordFocused = hasFocus;
          break;
      }
    });
    
    if (hasFocus) {
      _labelController.forward();
    } else {
      _labelController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _mainController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _gradientAnimation.value!,
                  _gradientAnimation.value!.withOpacity(0.8),
                ],
              ),
            ),
            child: child,
          );
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                
                // Animated Logo
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Colors.blueAccent, Colors.indigoAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 2,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person_add_alt_1,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Form Card
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Card(
                        elevation: 16,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadowColor: Colors.black.withOpacity(0.3),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Username Field
                                _buildAnimatedTextField(
                                  controller: _usernameController,
                                  label: 'Username',
                                  icon: Icons.person_outline,
                                  isFocused: _isUsernameFocused,
                                  fieldType: 'username',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please choose a username';
                                    }
                                    if (value.length < 4) {
                                      return 'Username too short';
                                    }
                                    return null;
                                  },
                                ),
                                
                                const SizedBox(height: 20),
                                
                                // Email Field
                                _buildAnimatedTextField(
                                  controller: _emailController,
                                  label: 'Email',
                                  icon: Icons.email_outlined,
                                  isFocused: _isEmailFocused,
                                  fieldType: 'email',
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                
                                const SizedBox(height: 20),
                                
                                // Password Field
                                _buildAnimatedTextField(
                                  controller: _passwordController,
                                  label: 'Password',
                                  icon: Icons.lock_outline,
                                  isFocused: _isPasswordFocused,
                                  fieldType: 'password',
                                  obscureText: _obscurePassword,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Colors.grey[600],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    if (value.length < 8) {
                                      return 'Password must be at least 8 characters';
                                    }
                                    return null;
                                  },
                                ),
                                
                                const SizedBox(height: 20),
                                
                                // Confirm Password Field - Fixed: Added missing parameters
                                _buildAnimatedTextField(
                                  controller: _confirmPasswordController,
                                  label: 'Confirm Password',
                                  icon: Icons.lock_reset_outlined,
                                  isFocused: _isConfirmPasswordFocused,
                                  fieldType: 'confirmPassword',
                                  obscureText: _obscureConfirmPassword,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureConfirmPassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Colors.grey[600],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureConfirmPassword = !_obscureConfirmPassword;
                                      });
                                    },
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please confirm your password';
                                    }
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),
                                
                                const SizedBox(height: 30),
                                
                                // Signup Button
                                _buildAnimatedSignupButton(),
                                
                                const SizedBox(height: 20),
                                
                                // Login Link
                                _buildLoginLink(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isFocused,
    required String fieldType,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return ScaleTransition(
      scale: _fieldScaleAnimation,
      child: FadeTransition(
        opacity: _fieldFadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Floating label animation
            AnimatedBuilder(
              animation: _labelAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    0,
                    isFocused ? -10 * (1 - _labelAnimation.value) : 0,
                  ),
                  child: Opacity(
                    opacity: isFocused ? _labelAnimation.value : 1.0,
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isFocused ? Colors.blueAccent : Colors.grey[600],
                        fontSize: isFocused ? 14 : 16,
                        fontWeight: isFocused ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 4),
            
            TextFormField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: isFocused ? Colors.blueAccent : Colors.grey[600],
                ),
                suffixIcon: suffixIcon,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isFocused ? Colors.blueAccent : Colors.grey[400]!,
                    width: isFocused ? 2.0 : 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isFocused ? Colors.blueAccent : Colors.grey[400]!,
                    width: isFocused ? 2.0 : 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.blueAccent,
                    width: 2.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
              ),
              validator: validator,
              onTap: () => _onFieldFocusChange(true, fieldType),
              onEditingComplete: () => _onFieldFocusChange(false, fieldType),
              onFieldSubmitted: (_) => _onFieldFocusChange(false, fieldType),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedSignupButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      width: _isLoading ? 60 : double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_isLoading ? 30 : 12),
        gradient: const LinearGradient(
          colors: [Colors.blueAccent, Colors.indigoAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.4),
            blurRadius: _isLoading ? 10 : 15,
            spreadRadius: _isLoading ? 2 : 4,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(_isLoading ? 30 : 12),
        child: InkWell(
          borderRadius: BorderRadius.circular(_isLoading ? 30 : 12),
          onTap: _isLoading ? null : _submitForm,
          child: Center(
            child: _isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    strokeWidth: 3,
                  )
                : const Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            // Add animation when navigating back
            _mainController.reverse().then((_) => Navigator.pop(context));
          },
          child: const Text(
            'Login',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}