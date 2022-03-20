import 'package:polmeme/memeGenerator/data/provider/meme_gen_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => MemeGenProvider(),
  ),
];
