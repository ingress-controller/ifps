echo "Clearing Old backup and creating New one!"
rm -rf ./backup/*
cp -r . ../backup/
echo "Done"
echo "Stopping and removing old containers and images!"
docker-compose down
docker image rm cluster:ipfs go:ipfs proxy:ipfs
if [ -z "$1"]
then 
    echo "No arguments provided keeping volumes!"
else
    echo "Deleting volumes"
    docker volume prune -f
fi
echo "Done"
echo "Building new images!"
docker build -t cluster:ipfs ./ipfs-cluster/
docker build -t go:ipfs ./ipfs-go/
docker build -t proxy:ipfs ./nginx/
echo "Done"
echo "Starting containers"
docker-compose up -d
echo "Done"