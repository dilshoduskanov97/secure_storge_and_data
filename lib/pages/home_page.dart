import 'package:flutter/material.dart';
import '../utils/user_secure_storage.dart';
import '../widget/birthday_widget.dart';
import '../widget/button_widget.dart';
import '../widget/pets_buttons_widget.dart';
import '../widget/title_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final formKey = GlobalKey<FormState>();
  final controllerName = TextEditingController();
  DateTime? birthday;
  List<String> pets = [];

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final birthday = await UserSecureStorage.getBirthday();
    final pets = await UserSecureStorage.getPets() ?? [];

    setState(() {
      controllerName.text = name;
      this.birthday = birthday;
      this.pets = pets;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const TitleWidget(icon: Icons.lock, text: 'Secure\nStorage'),
          const SizedBox(height: 32),
          buildName(),
          const SizedBox(height: 12),
          buildBirthday(),
          const SizedBox(height: 12),
          buildPets(),
          const SizedBox(height: 32),
          buildButton(),
        ],
      ),
    ),
  );

  Widget buildName() => buildTitle(
    title: 'Name',
    child: TextFormField(
      controller: controllerName,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Your Name',
      ),
    ),
  );

  Widget buildBirthday() => buildTitle(
    title: 'Birthday',
    child: BirthdayWidget(
      birthday: birthday,
      onChangedBirthday: (birthday) =>
          setState(() => this.birthday = birthday),
    ),
  );

  Widget buildPets() => buildTitle(
    title: 'Pets',
    child: PetsButtonsWidget(
      pets: pets,
      onSelectedPet: (pet) => setState(
              () => pets.contains(pet) ? pets.remove(pet) : pets.add(pet)),
    ),
  );

  Widget buildButton() => ButtonWidget(
      text: 'Save',
      onClicked: () async {
        await UserSecureStorage.setUsername(controllerName.text);
        await UserSecureStorage.setPets(pets);

        if (birthday != null) {
          await UserSecureStorage.setBirthday(birthday!);
        }
      });

  Widget buildTitle({
    required String title,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
}
