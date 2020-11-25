# Argo CD with ytt

- Argo CD: https://argoproj.github.io/argo-cd/
- ytt: https://get-ytt.io

## prerequisite

- kind: https://kind.sigs.k8s.io/docs/user/quick-start/
- kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl/
- argocd cli: https://github.com/argoproj/argo-cd/blob/master/docs/getting_started.md

## Demo

```console
kind create cluster --name argocd-ytt

docker build -t argocd-ytt:v1 .

kind load docker-image argocd-ytt:v1 --name argocd-ytt

kubectl create namespace argocd

cd argocd
wget https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
ytt -f . | kubectl apply -n argocd -f -

argocd app create testhttpd \
    --repo https://github.com/zoetrope/argocd-ytt.git \
    --path sample \
    --dest-server https://kubernetes.default.svc \
    --dest-namespace default \
    --config-management-plugin ytt

argcd app sync testhttpd
```
