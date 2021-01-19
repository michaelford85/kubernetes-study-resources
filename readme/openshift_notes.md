<p align="center">
  <img height="200" title="Openshift Logo" src="images/openshift_logo.jpg">
</p>

Notes on Openshift Container Platform and its differences from vanilla Kubernetes

## Openshift-Specific Resources:
- [Projects](https://docs.openshift.com/container-platform/4.6/rest_api/project_apis/project-project-openshift-io-v1.html)
  - An OpenShift project is an alternative representation of a Kubernetes namespace. Projects are exposed as editable to end users while namespaces are not. Direct creation of a project is typically restricted to administrators, while end users should use the requestproject resource.
  - A project has one or more members, a quota on the resources that the project may consume, and the security controls on the resources in the project. Within a project, members may have different roles - project administrators can set membership, editors can create and manage the resources, and viewers can see but not access running containers. In a normal cluster project administrators are not able to alter their quotas - that is restricted to cluster administrators.
- [Applications](https://docs.openshift.com/container-platform/4.6/applications/application_life_cycle_management/creating-applications-using-cli.html)
  - Openshift can use various sources to create an application and all asdociated services using a single command: `$ oc new-app`. Some of the artifacts created by an application:
    - **BuildConfig**: A BuildConfig is created for each source repository specified in the command line. The BuildConfig specifies the strategy to use, the source location, and the build output location.
    - **ImageStreams**: For BuildConfig, two ImageStreams are usually created. One represents the input image. With Source builds, this is the builder image. With Docker builds, this is the FROM image. The second one represents the output image. If a container image was specified as input to new-app, then an image stream is created for that image as well.
    - **DeploymentConfig**: A DeploymentConfig is created either to deploy the output of a build, or a specified image. The new-app command creates EmptyDir volumes for all Docker volumes that are specified in containers included in the resulting DeploymentConfig.
    - **Service**: The new-app command attempts to detect exposed ports in input images. It uses the lowest numeric exposed port to generate a service that exposes that port. In order to expose a different port, after new-app has completed, simply use the oc expose command to generate additional services.
    - **Other**: Other objects may be generated when instantiating templates, according to the template.
