### Layout

Here is a high-level view of the folder structure and key components for your reference.
<pre>
diagrams  
    -> images    
takethat_project  
    -> lib  
    -> test  
    -> pubspec.yaml  
</pre>

### Folder contents
- 'diagrams' and 'images' contains necessary diagrams
- 'takethat_project' contains all necessary contents to run the software
  
### How to build the software.
In order to build the software you must download   
Android Studio https://developer.android.com/studio    
Flutter SDK https://docs.flutter.dev/get-started/install  
Visual Studio Code https://code.visualstudio.com/download  

Step 1. Download all necessary frameworks  
Step 2. Open VSCode and install Flutter and Dart extensions  
Step 3. Ensure flutter path is in path variables and version is correct in takethat_project/pubspec.yaml  
Step 4. Ensure gradle wrapper is compatible with java version in takethat_project/.gradle/wrapper/gradle-wrapper.properties  
Step 5. Run android emulator from command line >Flutter/Launch Emulator  
Step 6. Run dart pages from takethat_project/lib/main.dart  

### How to test the software
While in the project directory in the terminal/powershell run " flutter test"

### How to add new tests.
Add new test cases under takethat_project/test/  
Tests have the naming convention 'feature_test.dart'

### Developer release notes
Make sure all version are up to dates for all software technologies used.
