import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/widget/app_snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

/// Reusable voice input button using speech_to_text.
/// It handles its own permissions, animations, and lifecycle.
/// Returns the final recognized text via [onResult].
class VoiceInputButton extends StatefulWidget {
  const VoiceInputButton({
    super.key,
    required this.onResult,
    this.activeColor,
    this.iconSize,
  });

  final ValueChanged<String> onResult;
  final Color? activeColor;
  final double? iconSize;

  @override
  State<VoiceInputButton> createState() => _VoiceInputButtonState();
}

class _VoiceInputButtonState extends State<VoiceInputButton>
    with SingleTickerProviderStateMixin {
  final SpeechToText _speech = SpeechToText();
  bool _isInitialized = false;
  bool _isListening = false;
  String _recognizedWords = '';

  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    if (_isListening) {
      _speech.cancel();
    }
    super.dispose();
  }

  Future<void> _initSpeech() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      if (mounted) {
        AppSnackBar.showError(
          context,
          message: 'Microphone permission is required to use voice input.',
        );
      }
      return;
    }

    try {
      _isInitialized = await _speech.initialize(
        onError: (error) {
          if (mounted) {
            AppSnackBar.showError(
              context,
              message: 'Speech recognition error: \${error.errorMsg}',
            );
            _stopListening();
          }
        },
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            if (_recognizedWords.trim().isNotEmpty) {
              widget.onResult(_recognizedWords.trim());
            }
            _stopListening();
          }
        },
      );
    } catch (e) {
      if (mounted) {
        AppSnackBar.showError(
          context,
          message: 'Failed to initialize speech recognition.',
        );
      }
    }
  }

  void _startListening() async {
    if (!_isInitialized) {
      await _initSpeech();
      if (!_isInitialized) return;
    }

    _recognizedWords = '';
    setState(() => _isListening = true);
    _pulseController.repeat(reverse: true);

    await _speech.listen(
      onResult: (result) {
        _recognizedWords = result.recognizedWords;
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 5),
    );
  }

  void _stopListening() async {
    if (!_isListening) return;
    
    await _speech.stop();
    if (mounted) {
      setState(() => _isListening = false);
      _pulseController.reset();
    }
  }

  void _toggleListening() {
    if (_isListening) {
      _stopListening();
    } else {
      _startListening();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleListening,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.r, horizontal: 6.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _isListening ? _pulseAnimation.value : 1.0,
              child: Icon(
                _isListening ? Icons.stop_circle : Icons.mic_none,
                size: widget.iconSize ?? 24.sp,
                color: _isListening
                    ? (widget.activeColor ?? AppColors.errorRed)
                    : context.colorTheme.onSurfaceVariant,
              ),
            );
          },
        ),
      ),
    );
  }
}
