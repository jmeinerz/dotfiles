export QONTO_SRC_PATH=~/Qonto
export DATA_SRC_PATH=~/Qonto
source ~/Qonto/devenv/activate

alias onelogin='onelogin-aws-assume-role --onelogin-username jonas.meinerz.ext --client_id d8fa456813757a4c4fa78fe27d158b7fb17cc63f664adb55b751ad3a54029d04 --client_secret 192544b1a8e6e52aa77a619099ffd09fc2e8d9bc3a1a734484dbc74cb9f3dd8b --region eu --onelogin-app-id 387536 --onelogin-subdomain qonto --profile default --aws-region eu-west-3 --aws-account-id 674764870074 --aws-role-name qonto-team-backend --duration 43200'

function qonto_pull {
  for filename in ~/Qonto/*; do
    cd $filename
    git checkout master
    git pull
  done
}

function prod_api {
  kubectl config use-context cbs-production
  cd $HOME/Qonto/qonto-helm-vars
  ./cli.sh --config environments/qonto/production.yaml run api-private-web --namespace=master --part-of=api -- bundle exec rails c
}

function prod_auth {
  kubectl config use-context cbs-production
  cd $HOME/Qonto/qonto-helm-vars
  ./cli.sh --config environments/qonto/production.yaml run auth-private-web --namespace=master --part-of=auth -- bundle exec rails c
}

function prod_register {
  kubectl config use-context cbs-production
  cd $HOME/Qonto/qonto-helm-vars
  ./cli.sh --config environments/qonto/production.yaml run register-private-web --namespace=master --part-of=register -- bundle exec rails c
}

function stg_pods {
  kubectl config use-context staging
  pod=$(kubectl -n $1 get pods | sed 's/ .*$//' | sed 1d | fzf --reverse)

  case $2 in
    logs)
      kubectl -n $1 logs $pod -f
      ;;
    bash)
      kubectl -n $1 exec -it $pod -- /bin/bash
      ;;
    *)
      kubectl -n $1 exec -it $pod -- bundle exec rails c
      ;;
  esac
}

function devenv {
  devenv_activate
  eval $(docker-machine env qonto)
}
