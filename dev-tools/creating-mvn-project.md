---
title: Creating a Java project using Maven
slug: create-mvn-project
category: java-dev
```
Maven is a useful tool to speed up Java development, especially when you're working on projects with other people. It manages the project dependencies and build phases for you. In this article I'll guide you though the process of creating your first Maven project on the command line.

## Creating the project structure
Maven provides an iterative wizard for creating new projects in the correct structure. There are thousands templates (called archetypes in maven) for various types of projects. The default one (org.apache.maven.archetypes:maven-archetype-quickstart) is usually what I end up using.

### Pick an archetype

The command will cause maven to download the list of archetypes and display them in the console. The list is generally too large to see all of it, but you can filter it to find something specific (we'll be using the default).

```
mvn archetype:generate
...
Choose a number or apply filter (format: [groupId:]artifactId, case sensitive contains): 604: 
```

### Choose archetype version
Next we'll need to select the version of the archetype we want to use, We'll use the latest one, `1.1` (again, this is the default). Once we select it, it will download the archetype if we don't already have it.

```
Choose org.apache.maven.archetypes:maven-archetype-quickstart version: 
1: 1.0-alpha-1
2: 1.0-alpha-2
3: 1.0-alpha-3
4: 1.0-alpha-4
5: 1.0
6: 1.1
Choose a number: 6: 
```

## Project metadata
### Choose a group ID for our new project
Group IDs serve a similar role in maven to packages in Java. By convention, they also use the same format, a reverse url, my example will use ``com.example.myproject`` as the group ID.

```
Define value for property 'groupId': : com.example.myproject
```

### Choose an artifact ID
This is the name of your project, it will be used for the jar file created by maven. Because it will be used as part of file names, it should be alphanumeric (and preferably lowercase) and use dashes or hyphens rather than spaces. For our example, I'll use `myproject`.

```
Define value for property 'artifactId': : myproject
```

### Choose an initial project version
Maven will then prompt us for an initial version number. By convention development versions which aren't officially a release tend to have `-SNAPSHOT` at the end in maven projects.  I like version 1 of my software to be the first sable version of the API, so I tend to set this to `0.1-SNAPSHOT` but you can set it to be any version you like.

```
Define value for property 'version':  1.0-SNAPSHOT: : 0.1-SNAPSHOT
```

### Choose a name for our first package
This archetype also creates a Java package (and a main class) for us, so it now asks us what we would like the package name to be. It will prompt you to use the groupID provided earlier by default, so let's use that.

```
Define value for property 'package':  com.example.myproject: : <press enter>
```

### Confirm you are happy with your settings
Phew, we're almost done, now we need to just check we've not made any mistakes (typos, etc...). Maven will provide us with a summary of the options we just selected, we just need to press enter to confirm we're happy with the values.

```
Confirm properties configuration:
groupId: com.example.myproject
artifactId: myproject
version: 0.1-SNAPSHOT
package: com.example.myproject
 Y: : 
```

### Summary of our work
Now we have given it all the information it needs, maven will create our project for us. It will put our new project structure in a folder which matches the artifactID we provided (myproject).

```
[INFO] ----------------------------------------------------------------------------
[INFO] Using following parameters for creating project from Old (1.x) Archetype: maven-archetype-quickstart:1.1
[INFO] ----------------------------------------------------------------------------
[INFO] Parameter: basedir, Value: /home/webpigeon/Documents
[INFO] Parameter: package, Value: com.example.myproject
[INFO] Parameter: groupId, Value: com.example.myproject
[INFO] Parameter: artifactId, Value: myproject
[INFO] Parameter: packageName, Value: com.example.myproject
[INFO] Parameter: version, Value: 0.1-SNAPSHOT
[INFO] project created from Old (1.x) Archetype in dir: /home/webpigeon/Documents/myproject
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 03:47 min
[INFO] Finished at: 2015-05-22T15:12:04+01:00
[INFO] Final Memory: 17M/303M
[INFO] ------------------------------------------------------------------------
```

## Ok, now what?
Now we have a working maven project we can use for our development. At this stage I usually create our Git repo in our new project folder. This is so we can easily track and revert changes (we can also tag releases so they are easier to find later).

### Creating our git repo
To create our repo, we can use `git init` in the directory created by maven.

Maven helpfully puts all it's build data in a directory called `target/`. So in order to ensure that our builds don't get put in git all we need to do is add `target/` to our `.gitignore`. You can do this using your favorite text editor or the bash command I use below.

```
cd myproject/
git init
Initialized empty Git repository in /home/webpigeon/Documents/myproject/.git/
echo "target/" > .gitignore
git add .
git commit -m "initial commit"
```

### Building our project
Ok, right now we can build our project (even though there is only the example class in our project), generate jar files and run tests. Just by virtue of having used maven to create our project. Another advantage is that most java continuous integration systems will naively have support for building and running tests using maven.

So, how do we build our project and jar files? the command `mvn build` run from the root of our project (the folder maven just created for us).

```
mvn package
[INFO] Scanning for projects...
[INFO]                                                                         
[INFO] ------------------------------------------------------------------------
[INFO] Building myproject 0.1-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO] 
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ myproject ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /home/webpigeon/Documents/myproject/src/main/resources
[INFO] 
[INFO] --- maven-compiler-plugin:2.5.1:compile (default-compile) @ myproject ---
[INFO] Nothing to compile - all classes are up to date
[INFO] 
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ myproject ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /home/webpigeon/Documents/myproject/src/test/resources
[INFO] 
[INFO] --- maven-compiler-plugin:2.5.1:testCompile (default-testCompile) @ myproject ---
[INFO] Nothing to compile - all classes are up to date
[INFO] 
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ myproject ---
[INFO] Surefire report directory: /home/webpigeon/Documents/myproject/target/surefire-reports

-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running com.example.myproject.AppTest
Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.008 sec

Results :

Tests run: 1, Failures: 0, Errors: 0, Skipped: 0

[INFO] 
[INFO] --- maven-jar-plugin:2.4:jar (default-jar) @ myproject ---
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 0.735 s
[INFO] Finished at: 2015-05-22T15:24:57+01:00
[INFO] Final Memory: 10M/303M
[INFO] ------------------------------------------------------------------------
```

The output tells us how many of our tests passed and the result of our build our Jar file is created as `target/<artifactId>-<version>jar`.

### Generate javadocs
One other common task that you might want to do is generate developer documentation for your code (javadocs). We can do this with maven to using the javadoc plugin. To use the javadoc plugin, run `mvn javadoc:javadoc` your javadoc will then be located in `target/site/apidocs/`.

```
[webpigeon@desktop myproject]$ mvn javadoc:javadoc
[INFO] Scanning for projects...
[INFO]                                                                         
[INFO] ------------------------------------------------------------------------
[INFO] Building myproject 0.1-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO] 
[INFO] >>> maven-javadoc-plugin:2.10.3:javadoc (default-cli) > generate-sources @ myproject >>>
[INFO] 
[INFO] <<< maven-javadoc-plugin:2.10.3:javadoc (default-cli) < generate-sources @ myproject <<<
[INFO] 
[INFO] --- maven-javadoc-plugin:2.10.3:javadoc (default-cli) @ myproject ---
[INFO] 
Loading source files for package com.example.myproject...
Constructing Javadoc information...
Standard Doclet version 1.8.0_45
Building tree for all the packages and classes...
Generating /home/webpigeon/Documents/myproject/target/site/apidocs/com/example/myproject/App.html...
Generating /home/webpigeon/Documents/myproject/target/site/apidocs/com/example/myproject/package-frame.html...
Generating /home/webpigeon/Documents/myproject/target/site/apidocs/com/example/myproject/package-summary.html...
Generating /home/webpigeon/Documents/myproject/target/site/apidocs/com/example/myproject/package-tree.html...
Generating /home/webpigeon/Documents/myproject/target/site/apidocs/constant-values.html...
Generating /home/webpigeon/Documents/myproject/target/site/apidocs/com/example/myproject/class-use/App.html...
Generating /home/webpigeon/Documents/myproject/target/site/apidocs/com/example/myproject/package-use.html...
Building index for all the packages and classes...
Generating /home/webpigeon/Documents/myproject/target/site/apidocs/overview-tree.html...
Generating /home/webpigeon/Documents/myproject/target/site/apidocs/index-all.html...
Generating /home/webpigeon/Documents/myproject/target/site/apidocs/deprecated-list.html...
Building index for all classes...
Generating /home/webpigeon/Documents/myproject/target/site/apidocs/allclasses-frame.html...
Generating /home/webpigeon/Documents/myproject/target/site/apidocs/allclasses-noframe.html...
Generating /home/webpigeon/Documents/myproject/target/site/apidocs/index.html...
Generating /home/webpigeon/Documents/myproject/target/site/apidocs/help-doc.html...
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 1.324 s
[INFO] Finished at: 2015-05-22T15:34:14+01:00
[INFO] Final Memory: 16M/303M
[INFO] ------------------------------------------------------------------------
xdg-open target/site/apidocs/index.html # if we want to open the javadoc in our web browser
```

## Conclusion
Now you're ready to develop your application using maven. If you want to learn more about maven's directory layout or commands check out the documentation from the Apache project and our other articles.
