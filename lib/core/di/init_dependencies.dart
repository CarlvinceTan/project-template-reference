import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'init_dependencies.config.dart';

final getIt = GetIt.instance;

@InjectableInit(  
  initializerName: 'init', 
  preferRelativeImports: false, 
  asExtension: true, 
  generateForDir: ['lib'],
)  

Future<void> configureDependencies() async => await getIt.init();  