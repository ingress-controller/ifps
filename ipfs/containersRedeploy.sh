docker container stop $1
docker container rm $1
docker image prune -f
docker build -t cluster:ipfs ./ipfs-cluster/
docker build -t go:ipfs ./ipfs-go/
docker build -t proxy:ipfs ./nginx/
docker-compose up -d $1