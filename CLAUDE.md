create terraform code here that creates 4 harness IACM CDK workspaces. the name of the workspace should be a single TF var, and then underscore + environment. 
environments should be based on a list, start with dev,test,uat,prod but configurable.

take in the following PLUGIN variables against the workspace env var section and apply:
PLUGIN_AWSCDK_LANGUAGE=python
PLUGIN_AWSCDK_LANGUAGE_VERSION=3.11
PLUGIN_AWSCDK_PACKAGE_MANAGER=pip
PLUGIN_AWSCDK_PACKAGE_MANAGER_VERSION=22.3
PLUGIN_TF_VERSION=2.1108.0
 
they should also be terraform variables.

