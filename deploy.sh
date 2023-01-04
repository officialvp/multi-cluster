docker build -t dako22/multi-client:latest -t dako22/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dako22/multi-server:latest -t dako22/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dako22/multi-worker:latest -t dako22/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dako22/multi-client:latest
dacker push dako22/multi-server:latest
docker push dako22/multi-worker:latest

docker push dako22/multi-client:$SHA
dacker push dako22/multi-server:$SHA
docker push dako22/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dako22/multi-server:$SHA
kubectl set image deployments/client-deployment client=dako22/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dako22/multi-worker:$SHA