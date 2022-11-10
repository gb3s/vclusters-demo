kind create cluster vcluster-host-primary

cluster init --infrastructure vcluster

helm repo add cluster-api-visualizer https://jont828.github.io/cluster-api-visualizer/charts
helm install vcluster-api-visualizer cluster-api-visualizer/cluster-api-visualizer --version 1.0.1 --namespace observability --create-namespace


#For Debugging with visualizer 
# kubectl port-forward -n observability svc/capi-visualizer 18082:8081
# kubectl port-forward svc/capi-visualizer 18081:8081

curl -L -o vcluster "https://github.com/loft-sh/vcluster/releases/latest/download/vcluster-linux-amd64" && install -c -m 0755 vcluster /usr/local/bin

export CLUSTER_NAME=ephen01
export CLUSTER_NAMESPACE=ephen01
export KUBERNETES_VERSION=1.23.4 
export HELM_VALUES="service:\n  type: NodePort"

kubectl create namespace ${CLUSTER_NAMESPACE}
clusterctl generate cluster ${CLUSTER_NAME} \
    --infrastructure vcluster \
    --kubernetes-version ${KUBERNETES_VERSION} \
    --target-namespace ${CLUSTER_NAMESPACE} | kubectl apply -f -
