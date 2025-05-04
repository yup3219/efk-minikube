# Install argocd 

kubectl create namespace argocd 

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

OR

kubectl create namespace argocd 

helm repo add argo https://argoproj.github.io/argo-helm

helm install argo argo/argo-cd


# UserName and Password:
Username: admin

Password: 
echo $(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}") | base64 -d

kubectl port-forward svc/argo-argocd-server -n argocd  8080:443


# Delete ArgoCD CRDS:
kubectl delete crds applications.argoproj.io applicationsets.argoproj.io appprojects.argoproj.io
