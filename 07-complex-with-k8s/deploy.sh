cd 07-complex-with-k8s/

docker build -t lhbelfanti/multi-client:latest -t lhbelfanti/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lhbelfanti/multi-server:latest -t lhbelfanti/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lhbelfanti/multi-worker:latest -t lhbelfanti/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lhbelfanti/multi-client:latest
docker push lhbelfanti/multi-server:latest
docker push lhbelfanti/multi-worker:latest

docker push lhbelfanti/multi-client:$SHA
docker push lhbelfanti/multi-server:$SHA
docker push lhbelfanti/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployments server=lhbelfanti/multi-server:$SHA
kubectl set image deployments/client-deployments client=lhbelfanti/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=lhbelfanti/multi-worker:$SHA