export QONTO_SRC_PATH=~/Qonto
export DATA_SRC_PATH=~/Qonto
source ~/Qonto/devenv/activate
eval "$(docker-machine env qonto)"

function prod_api {
  kubectl config use-context qonto-production
  cd $HOME/Qonto/qonto-helm-vars
  ./cli.sh --config environments/qonto/production.yaml run api-private-web --namespace=master --part-of=api -- bundle exec rails c
}

function stg_pods {
  kubectl config use-context cbs-staging
  pod=$(kubectl -n $1 get pods | sed 's/ .*$//' | sed 1d | fzf --reverse)

  case $2 in
    logs)
      kubectl -n $1 logs $pod
      ;;
    bash)
      kubectl -n $1 exec -it $pod -- /bin/bash
      ;;
    *)
      kubectl -n $1 exec -it $pod -- bundle exec rails c
      ;;
  esac
}
