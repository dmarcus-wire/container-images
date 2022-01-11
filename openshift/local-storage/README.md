# SNO Persistent Storage with Local Storage

Facts about Local Storage Operator:
1. Local volumes cannot be created with dynamic provisioning
1. MUST create file system or block
1. A local disk must be attached to the node
1. The local disk cannot be mounted
1. The local disk does not container partitions
1. Do not use different storage class names for the same device

FROM the Web Console
1. Login to web console
1. Go to Operators > OperatorHub
1. search for `Local Storage`
1. Install

From the CLI:
1. create the `openshift-local-storage` project
1. get the OCP major and minor version for the channel value
1. create a YAML file to define the Operator group and subscription for Locla STorage Operator
```
oc adm new-project openshift-local-storage

OC_VERSION=$(oc version -o yaml | grep openshiftVersion | \
    grep -o '[0-9]*[.][0-9]*' | head -1)

cat openshift-local-storage.yaml
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: local-operator-group
  namespace: openshift-local-storage
spec:
  targetNamespaces:
    - openshift-local-storage
---
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: local-storage-operator
  namespace: openshift-local-storage
spec:
  channel: "${OC_VERSION}"
  installPlanApproval: Automatic 
  name: local-storage-operator
  source: redhat-operators
  sourceNamespace: openshift-marketplace

oc -n openshift-local-storage get pods
```
