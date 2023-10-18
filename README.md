# Terraform Kubernetes Provider in `in-cluster` config

## Steps

1. Clone this repo:
    ```console
    $ git clone https://github.com/arybolovlev/terraform-kubernetes-in-cluster.git
    $ cd terraform-kubernetes-in-cluster
    ```

1. Prepare a Kubernetes cluster(must be [KinD](https://kind.sigs.k8s.io/)).

1. Provision storage class, PV and PVC:
    ```console
    $ kubectl apply -f storageClass.yaml
    $ kubectl apply -f persistentVolume.yaml
    $ kubectl apply -f persistentVolumeClaim.yaml
    ```

1. Create a new service account `terraform`:
    ```console
    $ kubectl apply -f serviceAccount.yaml
    ```

1. Spin up a pod that will serve as a Terraform code editor:
    ```console
    $ kubectl apply -f editorPod.yaml
    ```

    Wait until it is ready(status will be `Running`):
    ```console
    $ kubectl get pods -w
    ```

1. Copy Terraform code to the storage:
    ```console
    $ kubectl cp main.tf terraform-editor:/terraform/main.tf
    ```

1. Spin up a pod that will init and apply Terraform code:
    ```console
    $ kubectl apply -f terraformPod.yaml
    ```

    Watch the pod until it is ready(status will be `Error`)
    ```console
    $ kubectl get pods -w
    ```

    Watch pod logs to understand why it was errored:
    ```console
    $ kubectl logs -f terraform
    ```

1. Create necessary Role, RoleBinding, ClusterRole, and ClusterRoleBinding:

    ```console
    $ kubectl apply -f role.yaml
    $ kubectl apply -f clusterRole.yaml
    $ kubectl apply -f roleBinding.yaml
    $ kubectl apply -f clusterRoleBinding.yaml
    ```

1. Delete Terraform pod:

    ```console
    $ kubectl delete pod terraform
    ```

1. Spin up a pod that will init and apply Terraform code:
    ```console
    $ kubectl apply -f terraformPod.yaml
    ```

    Watch until it is ready(status will be `Completed`) and watch pod logs:
    ```console
    $ kubectl get pods -w
    $ kubectl logs -f terraform
    ```

1. Validate that a new pod and namespace were created:

    ```console
    $ kubectl get pods this
    $ kubectl get namespace this
    ```
