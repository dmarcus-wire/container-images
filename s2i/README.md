# Source-to-Image (S2I)

provides an alternative to Containerfiles to create new container images. Takes an app source code from Git, injects the source into a base container image (s2i builder image) based on a language or framework. Produces a new container image.

Image Stream is a configuration that names a specific container image associated with image stream tags/alias. OCP watches when IS change and takes actions based on that change.

Works in openshift or standalone.

Creates slimmer images with fewer layers.

## Process
1. start container from base image `builder image`
	- detects language checks if source contains prog. lang. runtimes, dev tools, compilers, etc.
1. searches imagestrea, for tags that support the lang detected
1. fetch app code (usually from Git)
1. send app code to container
1. builds the app binary files inside container
1. saves the container as new container image

## Reasons
1. efficiency - devs don't need to understand Container/Dockerfiles nor OS's. 
2. patching - consistent rebuilding apps consistently off base image
3. speed - ecosystem - encourages shared base images and scripts consuming them for apps

## Languages
1. Ruby (Rakefile, Gemfile, config.ru)
2. Java EE (pom.xml)
3. Node.js (app.json, package.json)
4. PHP (index.php, composer.json)
5. Python (requirements.txt, config.py)
6. Perl (index.pl, cpanfile)

## Procedure
using the oc new-app command
1. imagestream~git.com/source
2. -i imagestream
3. Git repo in the current directory
4. Git repo remote and context subdirectory
5. Git repo specific branch
6. create a JSON reosurce definition file
	- image stream (the base image to build the source code on)
	- build configuration (defines params, triggers to transform source into a container)
	- deployment object (customizes the deployment process, params, triggers to create new instances)
```
oc new-app php~http://my.git.server.com/my-app
oc new-app -i php http://my.git.server.com/my-app
oc new-app .
oc new-app https://github.com/sti-ruby.git --context-dir=2.0/test/puma-test-app
oc new-app https://github.com/sti-ruby.git#branch
oc -o json new-app php~http://services.lab.example.com/app --name=myapp > s2i.json
```

## Steps that occur post build
1. build process starts `oc get builds`
2. build logs `oc logs build/app-name`
3. BuildConfig pod create the images in OCP
4. BuildConfig pushes to internal container registry
5. Deployment pod pushes pods into operation using the internal registry
