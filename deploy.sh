docker build -t olehdev/multi-docker-client:latest -t olehdev/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t olehdev/multi-docker-server:latest -t olehdev/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t olehdev/multi-docker-worker:latest -t olehdev/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker

docker push olehdev/multi-docker-client:latest
docker push olehdev/multi-docker-server:latest
docker push olehdev/multi-docker-worker:latest

docker push olehdev/multi-docker-client:$SHA
docker push olehdev/multi-docker-server:$SHA
docker push olehdev/multi-docker-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=olehdev/multi-docker-server:$SHA
kubectl set image deployments/client-deployment client=olehdev/multi-docker-client:$SHA
kubectl set image deployments/worker-deployment worker=olehdev/multi-docker-worker:$SHA