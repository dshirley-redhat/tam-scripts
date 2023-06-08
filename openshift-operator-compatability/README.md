

## Prerequisites
1. You'll need to manually add the signing keys by following this document https://access.redhat.com/solutions/6542281
   Note: You may need to change the policy for registry.redhat.io/redhat/community-operator-index to accept anything as I had to on my system
   ~~~
          "registry.redhat.io/redhat/community-operator-index": [            {
              "type":"**insecureAcceptAnything**"
            }
          ],
   ~~~

2. Install jq on your system using yum/rpm or the standard package installer for you linux system
   ~~~
    yum install jq
   ~~~

3. Install podman on your system
   1. https://podman.io/docs/installation


## Running the script

Run the script from a terminal and provide the 1 required parameter and an optional output file name (default if not provided is ocp-release-operators.txt). 

~~~
./find-release-operator-versions.sh <OCP_RELEASE_VERSION> <OUTPUT_FILENAME>
./find-release-operator-versions.sh 4.11 ocp-release-operators.txt
./find-release-operator-versions.sh 4.10 ocp-release-operators.txt
./find-release-operator-versions.sh 4.8
~~~