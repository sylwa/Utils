## Standlone class/jar as executable

> Prerequisite : JAVA_HOME env variable is set to Java 8 or above

Class as executable
===================
cat *exec_class.sh* **ClassName**.class > **ClassName** \
chmod 755 **ClassName** \
./**ClassName**  

> Note : Use the ClassName as the executable name


Jar as executable
===================
cat *exec_jar_standard.sh* JarFile_With_MainClass_in_Manifest.jar > **executableName** \
chmod 755 **executableName** \
./**executableName**    


SpringBoot Jar as executable
============================
cat *exec_jar_springboot.sh* SpringBoot_JarFile.jar > **executableName** \
chmod 755 **executableName** \
./**executableName**  

