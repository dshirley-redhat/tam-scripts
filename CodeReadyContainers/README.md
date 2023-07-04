### CodeReady Container tool

#### Installing the crc tool

Run ```./install_crc.sh``` from a terminal, this will download and install the crc installer.

#### Creating a local OCP instance with crc

Run the following to create and start the local cluster

```
crc setup
crc start
```

#### Stopping the cluster

```
crc stop
```

#### Remove the local configs

```
crc cleanup
```

### Upgrading the cluster

#### Pre-requisite

Run ```oc adm upgrade```

If you see the following message, run through the steps in [1]
```
Cluster version is 4.11.1

Upgradeable=False

  Reason: ClusterVersionOverridesSet
  Message: Disabling ownership via cluster version overrides prevents upgrades. Please remove overrides before continuing.
```


[i] - https://access.redhat.com/solutions/6994678

#### Run the upgrade

After logging in with a user that has cluster-admin, upgrade the cluster with the web UI or run the cli command ```oc adm upgrade --to=<version number>```