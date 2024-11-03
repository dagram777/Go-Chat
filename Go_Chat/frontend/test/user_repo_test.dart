
import 'package:flutter_test/flutter_test.dart';
import 'package:volunteer_ethiopia_mobile/domain/auth/user_model.dart';
import 'package:volunteer_ethiopia_mobile/infrastructure/auth/data_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'user_repo_test.mocks.dart';

@GenerateMocks([],customMocks: [MockSpec<UserDataProvider>(as: #MockUserRepository )])
void main() {
  late MockUserRepository mockUserRepository;
  late UserRepository userRepository;
  setUp((){
    mockUserRepository=MockUserRepository();
    userRepository=UserRepository(dataProvider: mockUserRepository);
  });
  

  final user=User(first_name: 'Ayele', email: 'Ayele@gmail.com', password: 'Ayele1234');
  test("if user is created", ()async {
    //arrange
    when(mockUserRepository.createUser(user)).thenAnswer((_) async=>user );
    //act
    final obtain=await userRepository.createUser(user);
    //assert
     expect(obtain, user);
    
  } ); 
  
  test("if user is not created", ()async {
    //arrange
    when(mockUserRepository.createUser(user)).thenAnswer((_) async=>null );
    //act
    final obtain=await userRepository.createUser(user);
    //assert
     expect(obtain, null);
     
  } ); 

  final user2=User(first_name: "Kinfe",email: "kinfe@yahoo.com", password: "kinfe11c12c");
  List<User> temp=[user,user2];
  test("if it return list of users in the system", ()async{
    //arrange
    when(mockUserRepository.getUsers()).thenAnswer((_) async => temp);

    //act
    final obtain=await userRepository.getUsers();

    //assert
     expect(obtain, temp);
     
  } );

   test("if it failed to return list of users in the system", (){
    //arrange
    when(mockUserRepository.getUsers()).thenAnswer((_) async => throw Exception('Failed to load courses'));

    //act
    final obtain=userRepository.getUsers();

    //assert
     expect(obtain,throwsException );
     
  } );   
  

test("if it fails to delete a user in the system ", (){
    //arrange
    when(mockUserRepository.deleteUser(10)).thenAnswer((_)async => throw Exception('Failed to delete user'));

    //act
    final obtain= userRepository.deleteUser(10);

    //assert
     expect( obtain , throwsException);
     
  } );

  test("if it fails to update a user in the system ", (){
    //arrange
    when(mockUserRepository.updateUser(user)).thenAnswer((_)async => throw Exception('Failed to delete user'));

    //act
    final obtain= userRepository.updateUser(user);

    //assert
     expect( obtain , throwsException);
     
  } );

}