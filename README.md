# ** Setting up OPA Gatekeeper in GKE**

#### # Step 1: Deploy OPA Gatekeeper
To deploy OPA Gatekeeper, follow these steps:

1. Add the Gatekeeper Helm repository:

helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts

2. Install Gatekeeper using Helm:

helm install gatekeeper/gatekeeper --name-template=gatekeeper --namespace gatekeeper-system --create-namespace

#### # Step 2: Check Gatekeeper Pods

After deploying Gatekeeper, check the pods in the gatekeeper-system namespace:

kubectl get pods -n gatekeeper-system

#### # Step 3: Observe Gatekeeper Component Logs

Monitor the logs of the Gatekeeper components once they are operational:

kubectl logs -l control-plane=audit-controller -n gatekeeper-system
kubectl logs -l control-plane=controller-manager -n gatekeeper-system

#### # Step 4: Build Constraint Templates

Next, build the Constraint Templates by applying the YAML configuration file:

kubectl create -f ./constrainttemplate.yaml

#### # Step 5: Build Constraints

Build the Constraints by applying the YAML configuration file:

kubectl create -f ./constraint.yaml

####  # Step 6: Test the Setup

#### # 6.1: Check Constraints
Verify that the Constraints and Constraint Templates are created successfully:

kubectl get constraint
kubectl get constrainttemplate

#### # 6.2: Deploy a Test Pod
Deploy a privileged Nginx pod to test the Gatekeeper setup:

kubectl create -f ./example.yaml

