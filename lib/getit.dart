import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wedme1/services/auth_service.dart';
import 'package:wedme1/utils/local_storage_utils.dart';
import 'package:wedme1/viewModel/auth_vm.dart';
import 'package:wedme1/viewModel/banner_vm.dart';
import 'package:wedme1/viewModel/chat_vm.dart';
import 'package:wedme1/viewModel/deeplink_vm.dart';
import 'package:wedme1/viewModel/marriage_vm.dart';
import 'package:wedme1/viewModel/profile_vm.dart';
import 'package:wedme1/viewModel/user_reaction.dart';
import 'package:wedme1/viewModel/wallet_vm.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<LocalStorage>(LocalStorage(sharedPreferences));

  getIt.registerSingleton<AuthViewModel>(AuthViewModel());
  getIt.registerSingleton<ProfileViewModel>(ProfileViewModel());
  getIt.registerSingleton<MarriageViewModel>(MarriageViewModel());
  getIt.registerSingleton<AuthServics>(AuthServics());
  getIt.registerSingleton<ChatViewModel>(ChatViewModel());
  getIt.registerSingleton<DynamicDeepLinkModelView>(DynamicDeepLinkModelView());
  getIt.registerSingleton<UserReactionVm>(UserReactionVm());
  getIt.registerSingleton<BannerVm>(BannerVm());
  getIt.registerSingleton<WalletVm>(WalletVm());

  
  
  
}
