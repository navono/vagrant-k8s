#! /bin/bash
# start-k8s-dashboard.sh

sa=`kubectl get serviceaccount | awk '{print $1}'`
eval $(echo $sa | awk '{split($0, filearray, " ");for(i in filearray)print "arr["i"]="filearray[i]}')

bInstalled=false
#echo ${arr[1]}  
for i in ${arr[*]};do
  if [ $i == "dashboard" ]; then
    bInstalled=true
  fi
done  
echo "dashboard was $bInstalled installed"

# 已经安装好 dashboard
if [ $bInstalled == true ];then
  # To get the secret key to be pasted to the dashboard token pwd.
  echo "Get dashboard secret ..."
  kubectl get secret $(kubectl get serviceaccount dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode

  echo -e "\nCopy the secret to Dashboard login page ..."

  echo -e "Start proxy and then need to open the login page \n"
  echo "http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login"
  kubectl proxy
else
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

  # To create a service account for dashboard
  echo "Creat service account ..."
  kubectl create serviceaccount dashboard -n default

  # To add cluster binding rules for roles on dashboard
  echo "Add cluster binding rules"
  kubectl create clusterrolebinding dashboard-admin -n default --clusterrole=cluster-admin --serviceaccount=default:dashboard

  # To get the secret key to be pasted to the dashboard token pwd.
  echo "Get dashboard secret ..."
  kubectl get secret $(kubectl get serviceaccount dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode

  echo "Copy the secret to Dashboard login page ..."
  echo "http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login"
 
  echo "Start proxy and then need to open the login page"
  kubectl proxy
fi
