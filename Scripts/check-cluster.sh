
# DEPLOYED_CLUSTER=$(aws eks list-clusters | jq -r ".clusters" | grep option-pricer-cluster || true)

# if [ "$DEPLOYED_CLUSTER" != "" ]; then
#     echo "There is already a cluster by this name; $DEPLOYED_CLUSTER. Cannot build another"
#     exit 1
# else
#     echo "No cluster by this name option-pricer-cluster, will continue with terraform"
# fi


#DEPLOYED_CLUSTER=$(aws eks list-clusters | grep option-pricer-cluster || true)
DEPLOYED_CLUSTER=$(cat file | grep option-pricer-cluster || true)
if [ "$DEPLOYED_CLUSTER" != "" ]; then
    echo "Cluster $DEPLOYED_CLUSTER is already deployed."              
else
    echo "Cluster needs to be deployed."              
    #eksctl create cluster -f eksctl_cluster_config.yml
fi
