OPTION=0
CONTAINER0=host0
CONTAINER1=host1
CONTAINER2=host2
NETWORK=mynet123
function createNetwork() {
  docker network create --subnet=172.18.0.0/16 $NETWORK
}
function createAndRun() {
  docker run  -d\
    -p 4444:22 \
    -e SSH_USERNAME=user0 \
    -e SSH_PASSWORD=user0p \
    -e AUTHORIZED_KEYS="$(cat ~/.ssh/id_rsa_ansiblecn.pub)" \
    --name=$CONTAINER0 \
    --net $NETWORK \
    --ip 172.18.0.22 \
  my-ubuntu-sshd3:latest

  docker run -d  \
    -p 5555:22 \
    -e SSH_USERNAME=user1 \
    -e SSH_PASSWORD=user1p \
    -e AUTHORIZED_KEYS="$(cat ~/.ssh/id_rsa_ansiblecn.pub)" \
    --name=$CONTAINER1 \
    --net $NETWORK \
    --ip 172.18.0.23 \
  my-ubuntu-sshd3:latest

  docker run -d  \
    -p 6666:22 \
    -e SSH_USERNAME=user2 \
    -e SSH_PASSWORD=user2p \
    -e AUTHORIZED_KEYS="$(cat ~/.ssh/id_rsa_ansiblecn.pub)" \
    --name=$CONTAINER2 \
    --net $NETWORK \
    --ip 172.18.0.24 \
  my-ubuntu-sshd3:latest
}
function ask_user_action() {
  read -rp "1 -> start | 2 -> stop | 3 -> clean : " option
  echo "$option"
}
function startC() {
  createNetwork
  createAndRun
}
function stopC() {
  docker stop $CONTAINER0
  docker stop $CONTAINER1
  docker stop $CONTAINER2 
}
function cleanC() {
  docker rm $CONTAINER0 -f
  docker rm $CONTAINER1 -f
  docker rm $CONTAINER2 -f
}
function main() {
  OPTION=$(ask_user_action)
  echo "$OPTION"
  case $OPTION in
  1)
    startC
    ;;
  2)
    stopC
    ;;
  3)
    cleanC
    ;;
  *)
    echo -n "Unknown"
    ;;

  esac
}
main
