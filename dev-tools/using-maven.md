# 

## the project object model (POM)
The [project object model][mvn-pom] is used by Maven for your project configuration. It is an XML file named pom.xml which is stored in the root of your project. It is used by Maven (and some 3rd party tools) to build and test your project.

The POM can contain a large of variety information including project metadata (name, version, description), dependency information and any extra steps needed to compile the project. Most fields are optional and some have defaults which can be overridden. The only required fields are groupId, artifactId and version. 

## Directory Structure
Maven has a [standard directory layout][mvn-dir-layout] which is used for all projects. This makes it easier find where things are for projects which use Maven. It also makes it easier for use other tools with your project (Git).

    src/main/java - Used to store Java source files
    src/main/resources - Used to store resources (images, level data, etc...)
	src/test/java - Used to store test (JUnit) source files
	src/test/resources - Used to store resources for tests (eg. invalid files which should throw errors)
	target/ - Used by maven for building and storing compiled files (should be in `.gitignore')
	LICENCE.txt - The licence used by your project
	NOTICE.txt - Attribution for libraries, resources, etc...
	README.txt - Instructions on how to use your project
	pom.xml - Maven configuration file

## Running Maven builds
Most Java IDEs have plug-ins for Maven which will resolve dependencies, build steps for you. If you are not using an IDE or want to use the command line version, you can install it from your package management system on Linux or from the [website on Windows][mvn-dl].


[mvn-dl]: https://maven.apache.org/download.cgi
[mvn-pom]: https://maven.apache.org/guides/introduction/introduction-to-the-pom.html
[mvn-dir-layout]: https://maven.apache.org/guides/introduction/introduction-to-the-standard-directory-layout.html