# TODO: Make Profile View and Profile More Attractive

## Profile View Enhancements (lib/screens/profile_view.dart)
- [x] Add gradient background to Scaffold body (light blue to white)
- [x] Enhance AppBar with gradient and shadow
- [x] Improve CircleAvatar: Add border, overlay edit icon, fade-in animation
- [x] Style Cards: Rounded corners (12), elevation 8, gradient headers for sections
- [x] Add AnimatedOpacity for info rows fade-in on data load
- [x] Enhance no-profile state: Gradient button, icon animation

## Profile Form Enhancements (lib/screens/profile.dart)
- [x] Add gradient AppBar matching view
- [x] Integrate ImagePicker: Button to select/upload photo, display preview CircleAvatar, save URL to Firestore
- [x] Style form fields: Wrap in Card sections with gradients, add prefix icons to TextFormFields
- [x] Add animations: ScaleTransition on save button tap, fade-in for sections
- [x] Improve validation: Error styling with red borders/icons
- [x] Group fields visually: Spaced Cards for Personal, Address, Education

## Testing and Verification
- [x] Run flutter pub get (if needed)
- [ ] Test UI on device/emulator: Load profile, edit, animations, image picker
- [ ] Verify Firebase data persistence and image upload
